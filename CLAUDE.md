# CLAUDE.md

이 파일은 Claude Code(claude.ai/code)가 이 저장소의 코드를 다룰 때 참고하는 가이드입니다.

## 프로젝트 개요

**Just the Docs** 테마(v0.12.0) 기반의 Jekyll 문서 사이트("공부 내용 정리 Wiki")이며, GitHub Pages(https://lsj8367.github.io)에 배포됩니다.

## 주요 명령어

### 로컬 개발

```bash
bundle exec jekyll serve --livereload   # 라이브 리로드로 로컬 서버 실행
bundle exec jekyll build                # _site/ 디렉토리에 사이트 빌드
```

참고: `_config.yml`은 라이브 리로드 시 반영되지 않으므로, 설정 변경 후 서버를 재시작해야 합니다.

### 의존성 설치

```bash
bundle install      # Ruby gem 설치
npm install         # Node.js 개발 의존성 설치 (린팅/포매팅 전용)
```

### 린팅 & 포매팅

```bash
npm run lint                # 전체 린터 실행 (CSS + 포매팅)
npm run lint:css            # SCSS 파일 Stylelint 검사
npm run lint:formatting     # SCSS, JS, JSON Prettier 검사
npm run format              # Prettier로 포매팅 자동 수정
```

### 테스트

```bash
bundle exec rspec           # 접근성 테스트 실행 (axe-core + Capybara/Selenium)
rake search:init            # 검색 데이터 JSON 생성
```

## 아키텍처

- **콘텐츠**: `docs/`에 YAML frontmatter가 포함된 마크다운 파일로 관리. `docs/` 하위 페이지의 기본 레이아웃은 `default`.
- **레이아웃** (`_layouts/`) — HTML 템플릿: `default`, `home`, `page`, `post`, `minimal`, `about`.
- **인클루드** (`_includes/`) — 재사용 컴포넌트(`components/`), 커스텀 CSS(`css/`), JS(`js/`), Lunr 검색(`lunr/`), 벤더 코드.
- **스타일** (`_sass/`) — SCSS 구성: `color_schemes/`, `utilities/`, `support/`, `custom/`, `vendor/`.
- **에셋** (`assets/`) — 컴파일된 CSS 진입점(`css/just-the-docs-*.scss`), JS, 이미지.
- **Ruby lib** (`lib/tasks/`) — Rake 태스크 (예: 검색 초기화).
- **테스트** (`spec/`) — axe-core 기반 RSpec 접근성 테스트.
- **픽스처** (`fixtures/`) — 다양한 Jekyll 버전(3.9, 4.3) 테스트용 gem 정의.

## 주요 설정 파일

- `_config.yml` — 사이트 설정, 플러그인 목록, 검색 설정, 콜아웃, Mermaid 지원, 푸터/편집 링크.
- `Gemfile` + `just-the-docs.gemspec` — Ruby 의존성. gemspec은 테마를 배포 가능한 gem으로 정의.
- `package.json` — Node.js 도구 전용 (Stylelint, Prettier). stylelint 및 prettier 설정이 인라인으로 포함.
- Liquid strict 모드 활성화 (`error_mode: strict`, `strict_filters: true`).

## CI/CD

GitHub Actions 워크플로우 위치: `.github/workflows/`
- **`ci.yml`** — 멀티 매트릭스 빌드 (Ruby 3.2–3.4, Jekyll 3.9/4.3, Ubuntu/macOS/Windows), HTML 유효성 검사 (Nu Validator + html-proofer), CSS/JS 린팅, 접근성 테스트.
- **`deploy.yml`** — `main` 브랜치에 push 시 GitHub Pages로 빌드 및 배포.
