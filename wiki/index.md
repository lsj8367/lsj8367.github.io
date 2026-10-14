# Index

wiki 전체 카탈로그. 도메인 → type 순으로 정리. 형식: `- [[페이지명]] — 한 줄 요약`

## backend
### concept
- [[신뢰성 (Reliability)]] — 결함이 있어도 올바르게 동작하는 성질. 결함≠장애, 하드웨어·소프트웨어·인적 오류
- [[확장성 (Scalability)]] — 부하 매개변수, 백분위 응답 시간, scale-up/out, 비공유 아키텍처
- [[유지보수성 (Maintainability)]] — 운용성·단순성·발전성, 우발적 복잡도와 추상화
- [[서킷 브레이커 (Circuit Breaker)]] — CLOSED/OPEN/HALF_OPEN 상태 전이로 연쇄 장애 차단
- [[리액티브 시스템 (Reactive Systems)]] — 리액티브 선언문: 응답성·탄력성·회복성·메시지 기반
- [[리액티브 프로그래밍 (Reactive Programming)]] — Non-Blocking, 선언형, Publisher/Subscriber/Operator
- [[리액티브 스트림즈 (Reactive Streams)]] — 비동기 스트림 표준 사양, 4개 인터페이스, 배압
- [[가비지 컬렉션 (Garbage Collection)]] — Young/Old, Eden/Survivor, Minor/Major GC, 승격
- [[분산 락 (Distributed Lock)]] — Redis 락의 TTL·GC 정지 문제, 펜싱 토큰, ZooKeeper
### entity
- [[Resilience4j]] — Java 내결함성 라이브러리. CircuitBreaker 설정값과 기본값

## data
### concept
- [[관계형 모델과 문서 모델 (Relational vs Document Model)]] — NoSQL 채택 이유, 임피던스 불일치, 관계 형태에 따른 선택
- [[데이터 엔지니어링 수명 주기 (Data Engineering Lifecycle)]] — 생성→저장→수집→변환→서빙 + undercurrents
- [[인덱스 (Index)]] — B+Tree vs Hash, 클러스터드/세컨더리, 커버링 인덱스
- [[트랜잭션 격리 수준 (Transaction Isolation Level)]] — 4단계, InnoDB MVCC·next-key lock, lost update, write skew
- [[메시지 전달 보장 (Delivery Semantics)]] — at-most/at-least/exactly-once와 오프셋 커밋 시점
### entity
- [[데이터 중심 애플리케이션 설계 (Designing Data-Intensive Applications)]] — Martin Kleppmann의 데이터 시스템 설계 책 (DDIA). 장별 소스 목록
- [[견고한 데이터 엔지니어링 (Fundamentals of Data Engineering)]] — Joe Reis·Matt Housley의 데이터 엔지니어링 입문서
- [[Redis]] — 인메모리 키-값 저장소. 자료구조, 단일 스레드 원자성, Lua 스크립트
- [[Kafka]] — 분산 이벤트 스트리밍. 파티션 로그, 오프셋, exactly-once

## math
### concept
- [[중심 극한 정리 (Central Limit Theorem)]] — 표본 평균의 분포는 정규분포로. 표준오차 σ/√n, 시뮬레이션 코드
- [[신뢰 구간 (Confidence Interval)]] — 95% 신뢰 구간의 정확한 해석, t분포
- [[특수 행렬 (Special Matrices)]] — 정방·항등·역·대각·삼각·희소 행렬
- [[고유값과 고유벡터 (Eigenvalues and Eigenvectors)]] — Av = λv, 행렬 분해, 특성방정식
### entity
- [[개발자를 위한 필수수학 (Essential Math for Data Science)]] — Thomas Nield의 데이터 과학 수학 입문서

## career
비공개(git 제외). 목록은 [[career-index]] 참고.

## personal
비공개(git 제외). 목록은 [[personal-index]] 참고.

## sources
- [[데이터 중심 애플리케이션 설계 1장 - 신뢰성·확장성·유지보수성]] — 데이터 시스템 관점과 좋은 시스템의 세 속성
- [[데이터 중심 애플리케이션 설계 2장 - 데이터 모델과 질의 언어]] — 관계형 vs NoSQL, 임피던스 불일치 (장 초반부)
- [[견고한 데이터 엔지니어링 - 데이터 엔지니어링 수명 주기]] — 수명 주기 5단계 (목차 수준)
- [[리액티브 프로그래밍 - 리액티브 시스템과 리액티브 프로그래밍]] — 리액티브 선언문, 프로그래밍 모델과 구성 요소
- [[리액티브 프로그래밍 - 리액티브 스트림즈]] — 표준 사양 정의 (한 줄)
- [[Resilience4j CircuitBreaker 설정값]] — 슬라이딩 윈도우, 최소 호출 수 (충돌 2건)
- [[선형대수학 - 행렬 노트]] — 고유값, 행렬 = 함수, 위치벡터
- [[개발자를 위한 필수수학 3장 - 기술 통계와 추론 통계]] — 중심 극한 정리, 표준오차, t분포, 신뢰 구간
- [[개발자를 위한 필수수학 4장 - 선형대수학]] — 특수 행렬, 고유값 방정식

## 미처리 소스 (raw/)
ingest 대기 중인 원본. 처리하면 이 목록에서 지우고 sources 섹션에 추가한다.
- (없음)
