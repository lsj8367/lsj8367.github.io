# 테마 커스터마이징

Just the Docs 테마를 커스터마이징하는 방법. 코어 파일 수정 없이 확장 가능.

---

## 커스텀 색상 스킴

### 1. SCSS 파일 생성

`_sass/color_schemes/my-scheme.scss`:
```scss
@import "./color_schemes/dark";   # 기존 스킴 기반 (선택)
$link-color: $blue-000;           # 변수 오버라이드
```

### 2. _config.yml에 적용

```yaml
color_scheme: my-scheme
```

### 3. 스킴 전환 (JavaScript)

동적 전환을 위해 CSS 파일 생성 — `assets/css/just-the-docs-my-scheme.scss`:
```liquid
---
---
{% include css/just-the-docs.scss.liquid color_scheme="my-scheme" %}
```

JavaScript에서 전환:
```javascript
jtd.setTheme("my-scheme")
```

## SCSS 변수 오버라이드

`_sass/custom/setup.scss`에서 기본 변수 재정의:
```scss
$pink-000: #f77ef1;
$pink-100: #f967f1;
$pink-200: #e94ee1;
$pink-300: #dd2cd4;
```

## 커스텀 CSS

`_sass/custom/custom.scss`에서 추가 스타일 작성:
```scss
// 인쇄 스타일 예시
@media print {
  .side-bar, .page-header { display: none; }
  .main-content { max-width: auto; margin: 1em; }
}
```

## Include 오버라이드

테마 기본 include를 프로젝트에 동일 경로로 생성하여 오버라이드:

| 파일 | 용도 |
|------|------|
| `_includes/head_custom.html` | `</head>` 직전에 삽입 (메타, CSS 등) |
| `_includes/header_custom.html` | 매 페이지 본문 상단 |
| `_includes/footer_custom.html` | 매 페이지 하단 |
| `_includes/nav_footer_custom.html` | 사이드바 하단 |
| `_includes/toc_heading_custom.html` | 자식 페이지 목차 위 커스텀 헤딩 |
| `_includes/search_placeholder_custom.html` | 검색바 플레이스홀더 텍스트 |

### TOC 헤딩 예시

`_includes/toc_heading_custom.html`:
```html
<h2 class="text-delta">Contents</h2>
```

## 오버라이드 가능한 컴포넌트

```
_includes/head.html                    # <head> 전체
_includes/icons/icons.html             # SVG 아이콘
_includes/components/sidebar.html      # 사이드바
_includes/components/header.html       # 헤더
_includes/components/breadcrumbs.html  # 브레드크럼
_includes/components/children_nav.html # 자식 페이지 네비게이션
_includes/components/footer.html       # 페이지 푸터
_includes/components/search_footer.html # 검색 DOM
_includes/components/mermaid.html      # Mermaid 초기화
_includes/vendor/anchor_headings.html  # 앵커 헤딩 링크
```
