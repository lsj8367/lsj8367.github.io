# 사이트 설정 (`_config.yml`)

`_config.yml`에서 사용 가능한 모든 설정 키와 값 정리. 변경 후 서버 재시작 필요.

---

## 사이트 기본

```yaml
title: "사이트 제목"
description: "사이트 설명"
baseurl: ""            # 서브 경로 (예: /blog)
url: "https://example.com"
```

## 로고 & 파비콘

```yaml
logo: "/assets/images/logo.png"       # 사이트 제목 대신 로고 표시
favicon_ico: "/assets/images/favicon.ico"
```

## 색상 스킴

```yaml
color_scheme: nil      # "light"(기본), "dark", 또는 커스텀 스킴 이름
```

## 검색

```yaml
search_enabled: true   # true(기본) / false

search:
  heading_level: 2              # 1~6, 섹션 분할 기준 헤딩 레벨 (기본: 2)
  previews: 3                   # 검색 결과당 미리보기 수 (기본: 3)
  preview_words_before: 5       # 매칭 단어 앞 표시 단어 수 (기본: 5)
  preview_words_after: 10       # 매칭 단어 뒤 표시 단어 수 (기본: 10)
  tokenizer_separator: /[\s\-/]+/  # 토크나이저 정규식 (기본값)
  rel_url: true                 # 검색 결과에 URL 표시 (기본: true)
  button: false                 # 우하단 검색 버튼 (기본: false)
  focus_shortcut_key: "k"       # Ctrl/Cmd + K로 검색 포커스
```

### 페이지별 검색 제외 (frontmatter)

```yaml
---
search_exclude: true
---
```

## Mermaid 다이어그램

```yaml
mermaid:
  version: "9.1.6"                          # jsDelivr CDN 버전
  # path: "/assets/js/mermaid.esm.min.mjs"  # 로컬 파일 경로 (CDN 대신)
```

## 코드 복사 버튼

```yaml
enable_copy_code_button: true   # 코드 블록에 복사 버튼 표시
```

## 헤딩 앵커 링크

```yaml
heading_anchors: true   # 헤딩에 앵커 링크 자동 추가 (기본: true)
```

## 네비게이션

```yaml
nav_enabled: true                # 사이드바 메뉴 전역 활성화/비활성화
nav_sort: case_sensitive         # case_insensitive(기본) / case_sensitive
nav_error_report: true           # 네비게이션 오류 리포트 (기본: false)
```

## 보조 링크 (우측 상단)

```yaml
aux_links:
  "GitHub":
    - "https://github.com/user/repo"
aux_links_new_tab: false         # 새 탭에서 열기 (기본: false)
```

## 외부 네비게이션 링크

```yaml
nav_external_links:
  - title: "GitHub"
    url: https://github.com/user/repo
    hide_icon: false              # 외부 링크 아이콘 숨김 (기본: false)
    opens_in_new_tab: false       # 새 탭에서 열기 (기본: false)

nav_external_links_new_tab: true  # 전체 외부 링크 새 탭 (기본: false)
```

## 맨 위로 이동

```yaml
back_to_top: true
back_to_top_text: "Back to top"
```

## 푸터

```yaml
footer_content: 'Copyright &copy; 2024 ...'

# 마지막 수정 시간 (페이지에 last_modified_date 필요)
last_edit_timestamp: true
last_edit_time_format: "%b %e %Y at %I:%M %p"

# GitHub 편집 링크
gh_edit_link: true
gh_edit_link_text: "Edit this page on GitHub"
gh_edit_repository: "https://github.com/user/repo"
gh_edit_branch: "main"
# gh_edit_source: docs           # 소스 디렉토리 (선택)
gh_edit_view_mode: "tree"        # "tree" 또는 "edit"
```

## 콜아웃 정의

```yaml
callouts:
  highlight:
    color: yellow
  important:
    title: Important
    color: blue
  new:
    title: New
    color: green
  note:
    title: Note
    color: purple
  warning:
    title: Warning
    color: red
```

사용 가능한 색상: `grey-lt`, `grey-dk`, `purple`, `blue`, `green`, `yellow`, `red`

## Google Analytics

```yaml
ga_tracking: "UA-1234567-89"           # UA 또는 GA4 형식
# ga_tracking: "UA-1234567-89,G-XXXXX" # 복수 ID (CSV)
ga_tracking_anonymize_ip: true          # GDPR 준수 (기본: true)
```

## 컬렉션

```yaml
collections:
  tests:
    permalink: "/:collection/:path/"
    output: true

just_the_docs:
  collections:
    tests:
      name: Tests
      nav_exclude: true       # 네비게이션 제외
      nav_fold: true          # 접힌 상태로 표시
      search_exclude: true    # 검색 제외
```

컬렉션 디렉토리는 반드시 `_` 접두사 필요 (예: `_tests/`)

## Kramdown / HTML 압축

```yaml
kramdown:
  syntax_highlighter_opts:
    block:
      line_numbers: false      # 코드 라인 번호 (true 시 HTML 압축과 충돌 가능)

compress_html:
  clippings: all
  comments: all
  endings: all
  startings: []
  blanklines: false
  # ignore:
  #   envs: all               # 라인 번호 사용 시 압축 비활성화 필요
```

## 기본 레이아웃 설정

```yaml
defaults:
  - scope:
      path: "docs"
      type: "pages"
    values:
      layout: "default"
```
