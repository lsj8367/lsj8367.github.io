---
type: entity
domain: data
aliases: [DDIA, Designing Data-Intensive Applications, 데이터 중심 애플리케이션 설계]
tags: [책, ddia]
sources: ["[[데이터 중심 애플리케이션 설계 1장 - 신뢰성·확장성·유지보수성]]", "[[데이터 중심 애플리케이션 설계 2장 - 데이터 모델과 질의 언어]]"]
updated: 2026-10-14
---
# 데이터 중심 애플리케이션 설계 (Designing Data-Intensive Applications)
> Martin Kleppmann이 쓴 데이터 시스템 설계 책. 저장소·복제·파티셔닝·트랜잭션·분산 시스템·스트림 처리를 다룬다. (보충)

## 개요
- 문제의식: 애플리케이션의 병목이 CPU에서 데이터의 양·복잡도·변화 속도로 옮겨 갔다.
- 데이터베이스·캐시·메시지 큐 등을 경계 없이 조합한 것을 하나의 **데이터 시스템**으로 보고, 애플리케이션 개발자가 곧 데이터 시스템 설계자라고 본다.
- 좋은 데이터 시스템의 세 속성: [[신뢰성 (Reliability)]], [[확장성 (Scalability)]], [[유지보수성 (Maintainability)]]

## 장별 정리
| 장 | 소스 페이지 |
|---|---|
| 1장. 신뢰할 수 있고 확장 가능하며 유지보수하기 쉬운 애플리케이션 | [[데이터 중심 애플리케이션 설계 1장 - 신뢰성·확장성·유지보수성]] |
| 2장. 데이터 모델과 질의 언어 | [[데이터 중심 애플리케이션 설계 2장 - 데이터 모델과 질의 언어]] |

## 관련
- [[신뢰성 (Reliability)]] · [[확장성 (Scalability)]] · [[유지보수성 (Maintainability)]]
- [[관계형 모델과 문서 모델 (Relational vs Document Model)]] — 2장
- 아직 소스는 없지만 다른 노트에서 이 책의 주제가 나온 곳: [[분산 락 (Distributed Lock)]] (8장 펜싱 토큰), [[트랜잭션 격리 수준 (Transaction Isolation Level)]] (7장 write skew)
- [[견고한 데이터 엔지니어링 (Fundamentals of Data Engineering)]] — 파이프라인 관점의 짝이 되는 책

## 출처
- [[데이터 중심 애플리케이션 설계 1장 - 신뢰성·확장성·유지보수성]]
- [[데이터 중심 애플리케이션 설계 2장 - 데이터 모델과 질의 언어]]
