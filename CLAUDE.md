# LLM Wiki 스키마

이 저장소(lsj8367.github.io)는 LLM이 관리하는 개인 지식 wiki이자, 그 공개 부분을 GitHub Pages(https://lsj8367.github.io)로 배포하는 Jekyll 사이트다. 저장소 루트가 Obsidian vault다. 사람은 소스를 고르고, 질문하고, 방향을 정한다. LLM(너)은 요약·상호참조·정리·기록 등 나머지 전부를 맡는다.

용도: 기술 학습(백엔드·데이터·수학) + 면접/커리어 준비 + 개인 지식(목표·회고·아이디어).

## 레이어

| 레이어 | 위치 | 규칙 |
|---|---|---|
| 원본 소스 | `raw/` | **불변.** 읽기만 하고 절대 수정·삭제·이동하지 않는다. 사람이 파일을 넣는다. |
| 첨부 | `raw/assets/` | 이미지 등. Obsidian 첨부파일 경로. |
| wiki | `wiki/` | LLM이 전부 작성·관리한다. 사람은 읽는다. |
| 스키마 | `CLAUDE.md` | 이 문서. 사람과 LLM이 함께 고쳐 나간다. |

## 공개 규칙

**이 저장소는 공개 저장소다. 커밋된 파일은 사이트에 안 나오더라도 GitHub에서 누구나 볼 수 있다.**

| 경로 | git | 사이트 |
|---|---|---|
| `raw/` | 제외 (`.gitignore`) | 제외 |
| `wiki/career/`, `wiki/personal/` | 제외 (`.gitignore`) | 제외 |
| `wiki/index.md`, `wiki/log.md` | 커밋 | 제외 (LLM 작업용) |
| `wiki/overview.md`, `wiki/{backend,data,math,sources}/` | 커밋 | **공개** |

- **본인 경험·프로젝트 상세(회사·서비스명, 수치, 장애 사례 등)는 `career/`에만 쓴다.** 공개 도메인 페이지·overview·index·log에는 쓰지 않는다.
- career/personal 소스(예: 면접 준비 노트)의 source 페이지는 `sources/`가 아니라 해당 도메인 폴더에 둔다.
- career/personal 페이지 목록은 `index.md`가 아니라 `wiki/career/career-index.md`, `wiki/personal/personal-index.md`에 둔다. log에는 "비공개 페이지 N개" 수준으로만 적는다.
- 공개 페이지에서 비공개 페이지로 링크해도 된다. 사이트에서는 링크 없이 글자만 표시된다. 단 링크 텍스트(질문 제목 등)에도 개인 정보가 없어야 한다.
- 커밋·push는 사람 확인 후. `main`에 push하면 바로 공개 배포된다.
- 비공개 영역은 git 백업이 없다.

## wiki 구조

```
wiki/
  index.md      도메인별 전체 카탈로그 (모든 페이지 한 줄씩)
  log.md        작업 기록, append-only
  overview.md   전체 지식 지도 / 도메인 간 연결 / 진행 중인 종합
  backend/      분산 시스템, 리액티브, 장애 대응, 아키텍처, 언어·프레임워크
  data/         데이터 모델, 저장소, 데이터 엔지니어링, 파이프라인
  math/         선형대수, 통계, 확률
  career/       면접 질문·답변, 이직·성장 계획
  personal/     목표, 회고, 아이디어, 비기술 독서
  sources/      소스 요약 페이지 (도메인 무관, 한곳에. 단 career/personal 소스는 제외)
```

### 배치 규칙
- **주 도메인 하나.** 여러 도메인에 걸치는 페이지는 가장 핵심적인 도메인 폴더 하나에만 두고, 다른 도메인에서는 링크로 참조한다. 판단이 애매하면 사람에게 묻는다.
- **파일명은 vault 전체에서 고유**해야 한다. `[[링크]]`가 폴더와 무관하게 동작하도록.
- 파일명 형식: `한국어 이름 (English).md` — 예: `복제 (Replication).md`, `서킷 브레이커 (Circuit Breaker).md`. 영어 대응어가 없으면 한국어만.
- 고유명사(제품·라이브러리·인물)는 원어 그대로: `Kafka.md`, `Resilience4j.md`.
- **새 도메인 폴더**: 기존 도메인에 억지로 들어가는 페이지가 3개 이상 쌓이면 분리를 제안한다. 생성은 사람 승인 후.

## 페이지 형식

모든 wiki 페이지(index/log 제외)는 frontmatter를 가진다. **frontmatter가 없으면 Jekyll이 원본 .md를 그대로 사이트에 복사하므로** 반드시 넣는다.

```yaml
---
type: concept | entity | source | question | analysis | note
domain: backend | data | math | career | personal
aliases: [약어, 다른 이름]                # 예: [DDIA], [Replication]. Obsidian 링크·검색에 쓰임
tags: [세부 태그]
sources: ["[[소스 요약 페이지]]", ...]   # 근거가 된 소스 요약 페이지
updated: YYYY-MM-DD
---
```

### type별 본문 템플릿

**concept** — 개념 (복제, 백프레셔, 고유값 …)
```
# 이름
> 한두 문장 정의

## 핵심
## 세부 / 동작 방식
## 트레이드오프 · 주의점
## 관련 개념        ← [[링크]] 목록, 관계를 한 줄씩 설명
## 면접 포인트      ← 해당되면. 관련 question 페이지 링크
## 출처            ← [[소스 페이지]] + 어떤 주장이 어디서 왔는지
```

**entity** — 고유명사 (Kafka, Resilience4j, 책, 저자 …)
```
# 이름
> 무엇인지 한 문장
## 개요
## 주요 특징 / 설정
## 관련
## 출처
```

**source** — `wiki/sources/`에 둔다(career/personal 소스는 해당 폴더). raw 파일 하나(또는 책 한 장) 당 하나.
```
# 소스 제목
- 원본: [[raw 경로]]
- 종류: 책 장 / 아티클 / 강의 / 노트 / 기타
- 날짜: 소스 날짜 (알면)
## 요약
## 핵심 주장        ← 각 항목에서 반영된 wiki 페이지 [[링크]]
## 기존 wiki와 충돌 / 보완
## 남은 질문
```

**question** — `wiki/career/`. 면접 질문 하나 당 하나.
```
# 질문 원문
## 답변 (30초 버전)
## 답변 (심화)
## 꼬리 질문
## 관련 개념
```

**analysis** — 질의 결과 중 남길 가치가 있는 비교·분석·종합. 주 도메인 폴더에 둔다.

**note** — personal 영역의 목표·회고·아이디어 등 자유 형식.

### 작성 규칙
- 한국어로 쓰고, 기술 용어는 처음 등장 시 `한국어(English)` 병기.
- 약어는 설명 없이 쓰지 않는다. 처음 등장 시 전체 이름을 쓰고, 약어는 해당 페이지 `aliases`에 넣는다.
- 근거 없는 주장 금지. 모든 사실 주장은 `## 출처`나 `sources`로 추적 가능해야 한다. LLM 자체 지식으로 보충한 내용은 `(보충)` 표시.
- 소스 간 **충돌**은 지우지 말고 양쪽을 적은 뒤 `> [!warning] 충돌` 콜아웃으로 표시한다.
- **wiki는 항상 최신 내용만 담는다.** raw가 수정되거나 새 소스로 주장이 바뀌면 본문을 그냥 고친다. 언제·무엇이 바뀌었는지 알리는 콜아웃이나 날짜 표기는 달지 않는다. 변경 이력은 `log.md`에만 남긴다 (frontmatter `updated`는 갱신).
- 링크는 Obsidian `[[페이지명]]` 위키링크를 쓴다.

## 워크플로우

### Ingest
**`wiki-ingest` 스킬(`.claude/skills/wiki-ingest/`)을 따른다.** 기본은 대화형(한 번에 소스 하나, 승인 후 반영)이고, `(보충)` 해소와 비공개 내용 분리 규칙이 들어 있다.

### Query
1. `index.md`를 먼저 읽고 관련 페이지를 찾아 읽는다.
2. 페이지를 인용(`[[링크]]`)하며 답한다. wiki에 없는 내용은 그렇다고 밝힌다.
3. 답이 남길 가치가 있으면 analysis 페이지로 저장할지 묻는다. 저장하면 index·log 갱신.

### Lint (요청 시)
점검 항목: 페이지 간 모순 / 새 소스로 대체된 낡은 주장 / inbound 링크 없는 고아 페이지 / 언급되지만 페이지 없는 개념 / 누락된 상호참조 / frontmatter 누락·형식 오류 / index에 없는 페이지.
결과를 보고하고, 수정은 승인 후. 조사할 만한 질문과 찾아볼 소스도 제안한다. log에 기록.

## index.md 형식
도메인별 섹션, 그 안에서 type별로. 각 페이지 한 줄:
`- [[페이지명]] — 한 줄 요약`

## log.md 형식
append-only. 각 항목은 아래 접두사로 시작한다 (grep 가능하게):
```
## [YYYY-MM-DD] ingest | 소스 제목
## [YYYY-MM-DD] query | 질문 요약
## [YYYY-MM-DD] lint | 범위
## [YYYY-MM-DD] schema | 변경 내용
```
본문에 생성/수정한 페이지를 나열한다. 최근 기록 확인: `grep "^## \[" wiki/log.md | tail -5`

## 사이트 (Jekyll + Just the Docs)

wiki 원본은 Obsidian 문법 그대로 쓴다. 빌드 시 `_plugins/obsidian.rb`가 변환한다(원본 파일은 건드리지 않음).
- 제목 = 파일명, 사이드바 부모 = 도메인 폴더(Backend/Data/Math/Sources), URL = `/wiki/<도메인>/<괄호 속 영어명 slug>/` (영어명 없으면 한국어 slug)
- `[[링크|별칭]]` → 사이트 링크. 사이트에 없는 페이지(비공개·미작성)는 글자만 남는다. `#heading`은 무시
- `> [!warning] 제목` → Just the Docs 콜아웃 (warning/note/new/important/highlight로 매핑)
- `$...$`, `$$...$$` → MathJax
- `updated` → 페이지 하단 최종 수정일
- **파일명을 바꾸면 URL이 바뀐다.** 같은 도메인 안에서 slug가 겹치면 빌드 시 `Obsidian: URL 충돌` 경고가 난다.

### 명령어
```bash
bundle exec jekyll serve --livereload   # 로컬 미리보기 (Ruby 3.x 필요. macOS 기본 Ruby 2.6은 불가)
bundle exec jekyll build                # _site/ 빌드
# Ruby가 없으면 Docker:
docker run --rm -v "$PWD":/srv/jekyll -w /srv/jekyll ruby:3.4 bash -c "bundle install && bundle exec jekyll build"
```
- `_config.yml` 변경은 서버 재시작 후 반영. Liquid strict 모드이며 wiki 페이지는 Liquid 렌더링을 끈다.
- 배포: `.github/workflows/deploy.yml`이 `main` push 시 빌드·배포. `ci.yml`은 테마 원본의 매트릭스 CI.
- 테마 개발용 명령(`npm run lint`, `bundle exec rspec`, `rake search:init`)과 구조(`_layouts/`, `_includes/`, `_sass/`)는 Just the Docs 테마 저장소 구성을 그대로 따른다. `_includes/head_custom.html`에 MathJax가 있다.

## 아직 하지 않는 것 (필요해지면 추가)
- 검색 엔진(qmd 등): 페이지가 수백 개가 되어 index.md로 부족해지면 도입.
- Dataview 쿼리, Marp 슬라이드: 요청 시.
