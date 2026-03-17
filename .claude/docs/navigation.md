# 네비게이션

페이지 구조와 네비게이션을 구성하는 데 사용할 수 있는 모든 frontmatter 키와 설정.

---

## 페이지 기본 구조 (Frontmatter)

### 최상위 페이지

```yaml
---
title: UI Components
nav_order: 3
---
```

### 자식 페이지

```yaml
---
title: Buttons
parent: UI Components
nav_order: 2
---
```

### 손자 페이지 (3단계)

```yaml
---
title: Line Numbers
parent: Code
grand_parent: UI Components
---
```

### 깊은 계층 (4단계 이상, v0.10.0+)

```yaml
---
title: Deep Page
parent: Parent Title
ancestor: Top Ancestor Title    # grand_parent 대신 사용, 더 깊은 계층 구분
---
```

## 페이지 정렬 (`nav_order`)

```yaml
nav_order: 1       # 숫자 (정수/소수)
nav_order: "aa"    # 문자열
```

- 숫자 값이 문자열보다 먼저 표시
- 미지정 시 제목 알파벳순 정렬
- 동일 `nav_order` 값의 순서는 불안정 (보장 안됨)
- `_config.yml`에서 `nav_sort: case_insensitive` 설정 가능

## 네비게이션 제외

```yaml
---
nav_exclude: true      # 메인 네비게이션에서 숨김
---
```

- 제목 없는 페이지도 자동 제외
- 부모 제외 시 자식도 함께 제외
- 브레드크럼과 자식 목록에는 여전히 표시됨

## 검색 제외

```yaml
---
search_exclude: true   # 검색 결과에서 숨김
---
```

## 자식 페이지 목차 (자동)

부모 페이지 하단에 자식 페이지 목록 자동 생성. 비활성화:

```yaml
---
has_toc: false
---
```

## 페이지 내 목차 (TOC)

### 기본 TOC

```markdown
## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}
```

### 비순서 TOC

```markdown
- TOC
{:toc}
```

### 특정 헤딩 TOC에서 제외

```markdown
## 이 헤딩은 TOC에 안 나옴
{: .no_toc }
```

### 접히는 TOC

```markdown
<details open markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>
```

## 브레드크럼

- 최상위가 아닌 모든 페이지에 자동 생성
- frontmatter로 비활성화 불가 (커스텀 레이아웃 또는 include 오버라이드 필요)

## 레이아웃

```yaml
layout: default    # 사이드바 + 브레드크럼 + TOC (기본)
layout: minimal    # 사이드바 없음, 간소화
layout: home       # default 기반
layout: page       # default 기반
layout: post       # default 기반
layout: about      # default 기반
```

### 페이지별 사이드바 제어

```yaml
---
nav_enabled: false   # 이 페이지에서 사이드바 숨김
---
```

## 제목 규칙

- 같은 레벨의 페이지는 고유한 제목 필요
- 페이지 제목은 자신의 자식 페이지 제목과 달라야 함
- 컬렉션은 별도 네임스페이스 → 다른 컬렉션과 제목 중복 가능
