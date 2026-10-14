---
type: entity
domain: data
aliases: [kafka, Apache Kafka, 카프카]
tags: [메시징, 스트리밍]
sources: ["[[면접 질문 정리 노트]]", "[[데이터 중심 애플리케이션 설계 1장 - 신뢰성·확장성·유지보수성]]"]
updated: 2026-10-14
---
# Kafka
> 분산 이벤트 스트리밍 플랫폼. 메시지를 파티션된 append-only 로그로 저장하고, 컨슈머는 오프셋으로 읽은 위치를 관리한다. (보충)

## 개요
- DDIA 1장은 Kafka를 "메시지 큐이면서 DB 수준의 지속성을 갖춘" 경계가 모호한 도구의 예로 든다.
- (보충) 토픽 → 파티션 → 오프셋 구조. 파티션 안에서만 순서가 보장된다. 컨슈머 그룹으로 파티션을 나눠 병렬 소비한다.

## 주요 특징 / 설정
- 오프셋 커밋 시점에 따라 전달 보장 수준이 달라진다. → [[메시지 전달 보장 (Delivery Semantics)]]
- (보충) `enable.auto.commit=false`로 두고 처리 후 수동 커밋하면 at-least-once.
- (보충) 멱등 프로듀서(`enable.idempotence`)와 트랜잭션으로 Kafka 내부의 exactly-once를 지원한다.

## 관련
- [[메시지 전달 보장 (Delivery Semantics)]]
- [[데이터 엔지니어링 수명 주기 (Data Engineering Lifecycle)]] — 수집 단계

## 출처
- [[면접 질문 정리 노트]] — offset commit 전략
- [[데이터 중심 애플리케이션 설계 1장 - 신뢰성·확장성·유지보수성]] — 경계가 모호한 도구의 예
- `(보충)` 표시는 LLM 보충
