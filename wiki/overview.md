---
type: analysis
domain: backend
aliases: [지식 지도]
tags: [overview]
sources: []
updated: 2026-10-14
---
# Overview

wiki 전체의 지식 지도. 도메인별 현황, 도메인 간 연결, 진행 중인 종합을 적는다. ingest가 쌓이면 LLM이 갱신한다.

## 도메인 현황
| 도메인 | 페이지 수 | 주요 주제 |
|---|---|---|
| backend | 10 | 시스템 설계 3대 속성, 장애 대응(서킷 브레이커), 리액티브, JVM GC, 분산 락 |
| data | 9 | DDIA, 데이터 모델, MySQL 인덱스·트랜잭션, Redis, Kafka, 데이터 엔지니어링 수명 주기 |
| math | 5 | 추론 통계(중심 극한 정리, 신뢰 구간), 선형대수(특수 행렬, 고유값) |
| sources | 9 | 책·학습 노트 요약 |

## 도메인 간 연결
- **신뢰성 축**: [[신뢰성 (Reliability)]] ↔ [[서킷 브레이커 (Circuit Breaker)]] ↔ [[리액티브 시스템 (Reactive Systems)]](회복성) ↔ [[메시지 전달 보장 (Delivery Semantics)]]. "결함이 장애로 번지지 않게 한다"는 같은 목표를 각기 다른 층에서 다룬다.
- **확장성 축**: [[확장성 (Scalability)]] ↔ 리액티브의 탄력성(elastic). DDIA의 "탄력적 시스템"과 리액티브 선언문의 "탄력성"은 같은 개념이다.
- **동시성 축**: [[트랜잭션 격리 수준 (Transaction Isolation Level)]](DB 안) ↔ [[분산 락 (Distributed Lock)]](DB 밖) ↔ [[Redis]](원자 연산·Lua 스크립트). 모두 read-modify-write 경쟁 조건을 다룬다. DDIA 7·8장을 읽으면 이 축이 크게 보강될 것.
- **GC ↔ 분산 시스템**: [[가비지 컬렉션 (Garbage Collection)]]의 정지가 [[분산 락 (Distributed Lock)]]의 락 만료 문제와 [[확장성 (Scalability)]]의 꼬리 지연으로 이어진다.
- **math ↔ backend**: [[중심 극한 정리 (Central Limit Theorem)]]와 응답 시간 백분위. 분포를 평균 하나로 요약하면 안 되는 이유가 같다.
- **추상화**: [[관계형 모델과 문서 모델 (Relational vs Document Model)]]의 "구현 세부를 숨긴다"는 목표는 [[유지보수성 (Maintainability)]]의 단순성 원칙과 같은 맥락.

## 진행 중인 종합 / 열린 질문
- Resilience4j 설정 노트에 공식 문서와 다른 설명이 2건 있다. → [[Resilience4j]]
- 다음 학습 후보: DDIA 5장(복제)·6장(파티셔닝)·7장(트랜잭션)·8장(분산 시스템)·9장(일관성과 합의). 이미 wiki에 있는 동시성 축 페이지들과 바로 연결된다.
- 아직 없는 페이지로 가는 링크: [[복제 (Replication)]], [[파티셔닝 (Partitioning)]], [[카오스 엔지니어링 (Chaos Engineering)]].
