# CSS 유틸리티 클래스

Markdown에서 `{: .클래스명 }` 문법으로 적용 가능한 CSS 유틸리티.

---

## 폰트 크기 (`.fs-*`)

| 클래스 | 소형 화면 | 대형 화면 |
|--------|----------|----------|
| `.fs-1` | 9px | 10px |
| `.fs-2` | 11px | 12px |
| `.fs-3` | 12px | 14px |
| `.fs-4` | 14px | 16px |
| `.fs-5` | 16px | 18px |
| `.fs-6` | 18px | 24px |
| `.fs-7` | 24px | 32px |
| `.fs-8` | 32px | 38px |
| `.fs-9` | 38px | 42px |
| `.fs-10` | 42px | 48px |

```markdown
큰 텍스트
{: .fs-9 }
```

## 폰트 굵기 (`.fw-*`)

| 클래스 | 값 |
|--------|-----|
| `.fw-300` | Light |
| `.fw-400` | Normal |
| `.fw-500` | Medium |
| `.fw-700` | Bold |

## 줄 높이 (`.lh-*`)

| 클래스 | 값 |
|--------|-----|
| `.lh-0` | 0 |
| `.lh-tight` | 1.1 (헤딩 기본) |
| `.lh-default` | 1.4 (본문 기본) |

## 텍스트 정렬

```markdown
{: .text-left }     <!-- 왼쪽 -->
{: .text-right }    <!-- 오른쪽 -->
{: .text-center }   <!-- 가운데 -->
```

## 텍스트 스타일

```markdown
{: .text-mono }     <!-- 모노스페이스 -->
```

---

## 색상

### 텍스트 색상 (`.text-*`) / 배경 색상 (`.bg-*`)

각 색상에 000~300 단계 제공:

| 계열 | 클래스 패턴 |
|------|------------|
| Light Grey | `.text-grey-lt-{000~300}` / `.bg-grey-lt-{000~300}` |
| Dark Grey | `.text-grey-dk-{000~300}` / `.bg-grey-dk-{000~300}` |
| Purple | `.text-purple-{000~300}` / `.bg-purple-{000~300}` |
| Blue | `.text-blue-{000~300}` / `.bg-blue-{000~300}` |
| Green | `.text-green-{000~300}` / `.bg-green-{000~300}` |
| Yellow | `.text-yellow-{000~300}` / `.bg-yellow-{000~300}` |
| Red | `.text-red-{000~300}` / `.bg-red-{000~300}` |

```markdown
빨간 텍스트
{: .text-red-300 }

노란 배경
{: .bg-yellow-000 }
```

---

## 여백 (Margin & Padding)

### 스케일

| 값 | 크기 |
|----|------|
| `1` | 4px (0.25rem) |
| `2` | 8px (0.5rem) |
| `3` | 12px (0.75rem) |
| `4` | 16px (1rem) |
| `5` | 24px (1.5rem) |
| `6` | 32px (2rem) |
| `7` | 40px (2.5rem) |
| `8` | 48px (3rem) |
| `auto` | auto |

### Margin 클래스

| 클래스 | 방향 |
|--------|------|
| `.m-{n}` | 전체 |
| `.mx-{n}` | 좌우 |
| `.my-{n}` | 상하 |
| `.mt-{n}` | 상 |
| `.mr-{n}` | 우 |
| `.mb-{n}` | 하 |
| `.ml-{n}` | 좌 |
| `.mx-auto` | 수평 중앙 |

### Padding 클래스

| 클래스 | 방향 |
|--------|------|
| `.p-{n}` | 전체 |
| `.px-{n}` | 좌우 |
| `.py-{n}` | 상하 |
| `.pt-{n}` | 상 |
| `.pr-{n}` | 우 |
| `.pb-{n}` | 하 |
| `.pl-{n}` | 좌 |

```markdown
아래 여백 32px
{: .mb-6 }
```

---

## Display

```markdown
{: .d-block }          <!-- display: block -->
{: .d-flex }           <!-- display: flex -->
{: .d-inline }         <!-- display: inline -->
{: .d-inline-block }   <!-- display: inline-block -->
{: .d-none }           <!-- display: none (숨김) -->
```

## 수평 정렬

```markdown
{: .float-left }
{: .float-right }
{: .flex-justify-start }     <!-- d-flex 필요 -->
{: .flex-justify-end }
{: .flex-justify-between }
{: .flex-justify-around }
```

## 수직 정렬

```markdown
{: .v-align-baseline }
{: .v-align-bottom }
{: .v-align-middle }
{: .v-align-text-bottom }
{: .v-align-text-top }
{: .v-align-top }
```

---

## 반응형 수정자

spacing, display 클래스에 인픽스로 추가하여 특정 화면 크기 이상에서만 적용:

| 수정자 | 브레이크포인트 |
|--------|---------------|
| (없음) | 모든 화면 |
| `xs` | 320px (20rem) 이상 |
| `sm` | 500px (31.25rem) 이상 |
| `md` | 740px (46.25rem) 이상 |
| `lg` | 1120px (70rem) 이상 |
| `xl` | 1400px (87.5rem) 이상 |

### 사용 예시

```markdown
대형 화면에서만 하단 여백 16px
{: .mb-lg-4 }

기본 숨김, 중형 화면 이상에서 표시
{: .d-none .d-md-inline-block }

모든 화면에서 좌우 패딩 32px
{: .px-6 }
```
