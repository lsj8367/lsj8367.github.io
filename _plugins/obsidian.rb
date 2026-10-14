# frozen_string_literal: true

# Obsidian으로 관리하는 wiki/ 페이지를 Just the Docs 사이트용으로 변환한다.
#
# - 제목·URL·내비게이션: 파일명에서 title, 도메인 폴더에서 parent, 괄호 속 영어명에서 permalink 생성
# - [[위키링크|별칭]] → 마크다운 링크. 사이트에 없는 페이지(비공개·미작성)는 링크 없이 글자만 남긴다
# - > [!warning] 제목 콜아웃 → Just the Docs 콜아웃 ({: .warning-title })
# - 인라인 수식 $...$ → kramdown이 인식하는 $$...$$
#
# wiki 원본 파일은 수정하지 않는다. 변환은 빌드 결과에만 반영된다.
module ObsidianWiki
  WIKI_DIR = "wiki"

  # 폴더 => [내비게이션 제목, nav_order]
  DOMAINS = {
    "backend" => ["Backend", 3],
    "data" => ["Data", 4],
    "math" => ["Math", 5],
    "sources" => ["Sources", 6]
  }.freeze

  CALLOUT_TYPES = {
    "note" => "note", "info" => "note", "abstract" => "note", "summary" => "note", "todo" => "note",
    "warning" => "warning", "caution" => "warning", "danger" => "warning", "error" => "warning",
    "bug" => "warning", "failure" => "warning",
    "tip" => "new", "hint" => "new", "success" => "new", "check" => "new", "done" => "new",
    "important" => "important", "question" => "important",
    "example" => "highlight", "quote" => "highlight"
  }.freeze

  WIKILINK = /(!?)\[\[([^\]|#\\]+)(?:#[^\]|\\]*)?(?:\\?\|([^\]]+))?\]\]/
  CODE_SPANS = /(^```.*?^```[ \t]*$|^~~~.*?^~~~[ \t]*$|`[^`\n]+`)/m

  def self.wiki_page?(page)
    page.relative_path.start_with?("#{WIKI_DIR}/") && page.ext == ".md"
  end

  def self.slug(name)
    english = name[/\(([^()]+)\)\s*\z/, 1]
    Jekyll::Utils.slugify(english || name)
  end

  class Generator < Jekyll::Generator
    priority :highest

    def generate(site)
      registry = {}
      seen_urls = {}

      site.pages.select { |p| ObsidianWiki.wiki_page?(p) }.each do |page|
        name = File.basename(page.name, ".md")
        domain = page.relative_path.split("/")[1]
        domain = nil unless DOMAINS.key?(domain)

        page.data["title"] ||= name == "overview" ? "Overview" : name
        page.data["nav_order"] ||= 2 if name == "overview"
        page.data["parent"] = DOMAINS[domain][0] if domain
        page.data["permalink"] = ["", WIKI_DIR, domain, ObsidianWiki.slug(name), ""].compact.join("/")
        page.data["render_with_liquid"] = false
        page.data["last_modified_date"] ||= page.data["updated"] if page.data["updated"]
        page.instance_variable_set(:@url, nil)

        if (other = seen_urls[page.url])
          Jekyll.logger.warn "Obsidian:", "URL 충돌 #{page.url}: #{other} / #{page.relative_path}"
        end
        seen_urls[page.url] = page.relative_path

        url = site.baseurl.to_s + page.url
        ([name] + Array(page.data["aliases"])).each do |key|
          registry[key.to_s.strip.downcase] ||= url
        end
      end

      DOMAINS.each do |dir, (title, order)|
        parent = Jekyll::PageWithoutAFile.new(site, site.source, "#{WIKI_DIR}/#{dir}", "index.html")
        parent.content = ""
        parent.data.merge!(
          "title" => title, "nav_order" => order, "has_children" => true,
          "layout" => "default", "permalink" => "/#{WIKI_DIR}/#{dir}/"
        )
        site.pages << parent
      end

      site.config["obsidian_registry"] = registry
    end
  end

  def self.convert(content, registry)
    content.split(CODE_SPANS).each_with_index.map do |chunk, i|
      i.odd? ? chunk : convert_text(chunk, registry)
    end.join
  end

  def self.convert_text(text, registry)
    text = convert_callouts(text)
    text = text.gsub(WIKILINK) do
      target = Regexp.last_match(2).strip
      label = (Regexp.last_match(3) || File.basename(target)).strip
      url = registry[target.downcase] || registry[File.basename(target).downcase]
      url ? "[#{label}](#{url})" : label
    end
    text.gsub(/(?<![$\\])\$(?![$\s])([^$\n]+?)(?<![\s\\])\$(?!\$)/) { "$$#{Regexp.last_match(1)}$$" }
  end

  # > [!type] 제목  →  {: .type-title } + 제목 문단
  def self.convert_callouts(text)
    text.gsub(/^>[ \t]*\[!(\w+)\][+-]?[ \t]*(.*)$/) do
      kind = CALLOUT_TYPES.fetch(Regexp.last_match(1).downcase, "note")
      title = Regexp.last_match(2).strip
      title.empty? ? "{: .#{kind} }\n>" : "{: .#{kind}-title }\n> #{title}\n>"
    end
  end
end

Jekyll::Hooks.register :pages, :pre_render do |page|
  next unless ObsidianWiki.wiki_page?(page)

  page.content = ObsidianWiki.convert(page.content, page.site.config["obsidian_registry"] || {})
end
