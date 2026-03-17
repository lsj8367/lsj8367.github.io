# docs/ 마크다운 컨벤션 가이드

이 문서는 `docs/` 폴더의 마크다운 파일 작성 시 따라야 할 컨벤션을 정리한다.

## 1. Frontmatter 규칙

모든 마크다운 파일은 YAML frontmatter로 시작한다.

### 필수 필드

```yaml
---
title: 페이지 제목
---
```

### 네비게이션 관련 필드

| 필드 | 타입 | 설명 |
|------|------|------|
| `nav_order` | 숫자 | 네비게이션 정렬 순서. 소수점 가능 (예: `4.5`) |
| `parent` | 문자열 | 부모 페이지의 `title` 값 |
| `grand_parent` | 문자열 | 조부모 페이지의 `title` 값 (3단계 계층) |
| `ancestor` | 문자열 | `grand_parent` 상위 계층 지정 시 사용 |

### 동작 제어 필드

| 필드 | 타입 | 설명 |
|------|------|------|
| `nav_exclude` | boolean | `true`이면 네비게이션에서 숨김 |
| `search_exclude` | boolean | `true`이면 검색에서 제외 |
| `has_toc` | boolean | 자식 페이지 목록 자동 생성 여부 |
| `permalink` | 문자열 | 커스텀 URL 경로 (예: `/404`) |

### 레이아웃

- 기본값: `default` (사이드바 포함)
- 사이드바 없는 페이지: `layout: minimal`

### 참고

- `has_children`은 v0.10.0+에서 무시되므로 더 이상 불필요하다.

## 2. 파일/디렉토리 네이밍

- **케밥케이스** 사용: `line-numbers.md`, `ui-components/`
- 섹션 부모 페이지는 디렉토리 내 **`index.md`** 로 생성

```
docs/
├── ui-components/
│   ├── index.md          # 섹션 부모 페이지
│   ├── buttons.md
│   ├── labels.md
│   └── code/
│       └── index.md      # 하위 섹션 부모 페이지
└── navigation/
    └── index.md
```

## 3. 네비게이션 구조

- `parent` 필드로 부모-자식 관계를 설정한다.
- `nav_order`는 숫자가 문자열보다 먼저 정렬된다.
- 동일 `parent` 이름이 존재할 경우 `grand_parent` 또는 `ancestor`로 구분한다.

**예시 — 3단계 계층:**

```yaml
---
title: Minimal Child
parent: Minimal
grand_parent: Layout
---
```

## 4. 콘텐츠 작성 패턴

### 제목 구조

- **H1** (`#`): 페이지당 1회, frontmatter 바로 뒤에 위치
- **H2** (`##`): 주요 섹션
- **H3** (`###`): 하위 섹션

### TOC (목차) 패턴

페이지 내 목차가 필요할 경우 아래 패턴을 사용한다:

```markdown
# 페이지 제목
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}
```

- `{: .no_toc }`: 해당 제목을 TOC에서 제외
- `1. TOC` + `{:toc}`: kramdown 자동 목차 생성

### 코드 블록

언어 지정 필수:

````markdown
```yaml
key: value
```

```ruby
puts "hello"
```

```js
console.log("hello");
```
````

### 코드 예시 + 렌더링 결과

코드의 렌더링 결과를 함께 보여줄 때 `code-example` div로 감싼다:

```markdown
<div class="code-example" markdown="1">
렌더링 결과가 여기에 표시됨
</div>
```코드 블록```
```

### 콜아웃

kramdown IAL(Inline Attribute List) 문법을 사용한다:

```markdown
> 일반 안내 메시지
{: .note }

> 경고 메시지
{: .warning }

> 중요 메시지
{: .important }

> 하이라이트
{: .highlight }

> 새 기능 안내
{: .new }
```

제목 포함 콜아웃:

```markdown
> **커스텀 제목**
>
> 콜아웃 내용
{: .note-title }
```

### 내부 링크

Jekyll `link` 태그를 사용한다:

```liquid
[링크 텍스트]({% link docs/path/to/file.md %})
```

### Mermaid 다이어그램

코드 펜스에 `mermaid` 언어를 지정하고, 접근성 속성(`accTitle`, `accDescr`)을 포함한다:

````markdown
```mermaid
graph TD;
    accTitle: 다이어그램 제목
    accDescr: 다이어그램에 대한 설명
    A-->B;
```
````

## 5. 스타일/유틸리티 클래스

kramdown IAL로 적용한다.

### 라벨

```markdown
라벨 텍스트
{: .label .label-green }
```

사용 가능한 색상: `.label-blue`, `.label-green`, `.label-purple`, `.label-yellow`, `.label-red`

### 버튼

```markdown
[버튼 텍스트](URL){: .btn .btn-purple }
```

사용 가능한 스타일: `.btn-blue`, `.btn-green`, `.btn-purple`, `.btn-outline`

### 텍스트/레이아웃 유틸리티

| 클래스 | 용도 |
|--------|------|
| `.fs-3` ~ `.fs-8` | 폰트 크기 |
| `.fw-300` | 폰트 굵기 (가벼움) |
| `.d-block`, `.d-inline-block` | display 제어 |
| `.m-2`, `.mr-2`, `.mr-4` | 마진 |
| `.text-delta` | 작은 대문자 스타일 텍스트 |
