# Log

append-only 작업 기록. 최근 항목: `grep "^## \[" wiki/log.md | tail -5`

## [2026-10-14] schema | wiki 초기 구성
- 기존 노트 7개 폴더(10개 파일)를 `raw/`로 이동 (원본 보존)
- `wiki/` 도메인 폴더 생성: backend, data, math, career, personal, sources
- `CLAUDE.md` 스키마, `index.md`, `overview.md`, `log.md` 작성
- Obsidian 첨부파일 경로를 `raw/assets/`로 설정

## [2026-10-14] schema | aliases 필드, 약어 규칙 추가
- frontmatter에 `aliases` 추가 (약어·다른 이름)
- 약어는 첫 등장 시 전체 이름 병기 규칙 추가

## [2026-10-14] ingest | 데이터 중심 애플리케이션 설계 1장
- 원본: `raw/데이터 중심 애플리케이션 설계/1장. 신뢰할 수 있고 확장 가능하며 유지보수하기 쉬운 애플리케이션.md`
- 결정: 세 속성은 backend 도메인, 노트에 없는 내용은 `(보충)`으로 채움, 강조점은 ingest하며 구체화
- 생성: [[데이터 중심 애플리케이션 설계 1장 - 신뢰성·확장성·유지보수성]], [[데이터 중심 애플리케이션 설계 (Designing Data-Intensive Applications)]], [[신뢰성 (Reliability)]], [[확장성 (Scalability)]], [[유지보수성 (Maintainability)]]
- 수정: index.md, overview.md
- 미작성 링크(후보): 서킷 브레이커, 카오스 엔지니어링, 복제, 파티셔닝

## [2026-10-14] ingest | 기존 노트 9개 일괄 처리
- 사용자 요청으로 소스별 승인 단계를 생략하고 일괄 처리. 기존 결정(`(보충)` 허용, 주 도메인 1개) 유지.
- 원본: DDIA 2장, 견고한 데이터 엔지니어링, 리액티브 2개, CircuitBreaker 설정값, 선형대수 행렬, 필수수학 3·4장, (비공개 소스 1개)
- 생성 (sources 9): DDIA 2장, 견고한 데이터 엔지니어링 수명 주기, 리액티브 시스템과 리액티브 프로그래밍, 리액티브 스트림즈, Resilience4j CircuitBreaker 설정값, 선형대수학 행렬 노트, 필수수학 3장, 필수수학 4장
- 생성 (backend 7): 서킷 브레이커, Resilience4j, 리액티브 시스템, 리액티브 프로그래밍, 리액티브 스트림즈, 가비지 컬렉션, 분산 락
- 생성 (data 8): 관계형 모델과 문서 모델, 데이터 엔지니어링 수명 주기, 견고한 데이터 엔지니어링, Redis, Kafka, 메시지 전달 보장, 인덱스, 트랜잭션 격리 수준
- 생성 (math 5): 개발자를 위한 필수수학, 중심 극한 정리, 신뢰 구간, 특수 행렬, 고유값과 고유벡터
- 생성 (career): 비공개 페이지 (career-index 참고)
- 수정: DDIA entity(2장 추가), 신뢰성·확장성·유지보수성(상호 링크), index.md, overview.md
- 충돌 표시: Resilience4j 설정 2건, 트랜잭션 격리 수준(next-key lock의 목적), 가비지 컬렉션(승격 조건)
- 판단: 분산 락·GC는 backend, Redis·Kafka·인덱스·격리 수준은 data

## [2026-10-14] schema | 블로그 저장소로 이전, 사이트 공개
- notes 저장소에서 lsj8367.github.io로 wiki·raw 이전. 이후 이 저장소가 wiki의 원본.
- 공개: wiki/overview, backend, data, math, sources. 비공개(git 제외): raw/, wiki/career/, wiki/personal/
- 공개 페이지의 본인 경험 서술을 제거하고 career/에만 유지. 면접 질문 정리 노트 소스 페이지를 career/로 이동
- career/personal 카탈로그를 각 폴더의 career-index, personal-index로 분리
- Obsidian 문법은 `_plugins/obsidian.rb`가 빌드 시 변환

## [2026-10-15] lint | 사이트 렌더링 (표·CI)
- 빈 줄 없이 제목 바로 뒤에 온 표가 사이트에서 깨지던 문제: `_plugins/obsidian.rb`가 빌드 시 표 앞에 빈 줄을 넣도록 수정 (원본은 그대로)
- 비교표의 빈 머리 칸을 "구분"으로 채움: [[인덱스 (Index)]], [[관계형 모델과 문서 모델 (Relational vs Document Model)]]
- 도메인 목록 페이지에 h1 추가, "Edit this page" 링크 URL 인코딩 (CI 접근성·HTML 검증 실패 수정)
