---
type: concept
domain: data
aliases: [Delivery Semantics, exactly-once, at-least-once, at-most-once, 오프셋 커밋 전략]
tags: [메시징, kafka, 분산시스템]
sources: ["[[면접 질문 정리 노트]]"]
updated: 2026-10-14
---
# 메시지 전달 보장 (Delivery Semantics)
> 메시지가 몇 번 전달·처리되는지에 대한 보장 수준. Kafka에서는 오프셋을 언제 커밋하느냐로 결정된다.

## 핵심
| 수준 | 의미 | 유실 | 중복 | 컨슈머 구현 (보충) |
|---|---|---|---|---|
| at-most-once | 최대 1회 | 가능 | 없음 | **처리 전에** 오프셋 커밋 |
| at-least-once | 최소 1회, 재전송 가능 | 없음 | 가능 | **처리 후에** 오프셋 수동 커밋 |
| exactly-once | 정확히 1회 | 없음 | 없음 | 멱등 프로듀서 + 트랜잭션, 또는 멱등 처리 |

- at-most-once: 구현이 간단하지만 처리되지 못한 메시지가 유실될 수 있다.
- at-least-once: 메시지가 중복될 수 있지만 유실되지 않는다. 그래서 오프셋을 수동 커밋해 처리한다.

## 세부 / 동작 방식
- (보충) 실무에서 가장 흔한 조합은 **at-least-once + 멱등한 컨슈머**(처리 ID로 중복 제거, upsert 등)다. 결과적으로 "효과상 정확히 한 번(effectively once)"을 얻는다.
- (보충) Kafka의 exactly-once 트랜잭션은 Kafka → Kafka(read-process-write) 범위에서 보장된다. 외부 DB에 쓰는 경우는 멱등성이나 오프셋을 DB와 같은 트랜잭션에 저장하는 방식이 필요하다.

## 관련 개념
- [[Kafka]]
- [[신뢰성 (Reliability)]] — 재시도는 중복을, 커밋 선행은 유실을 낳는 트레이드오프

## 면접 포인트
- [[Kafka 메시지 전달 보장 전략은]]

## 출처
- [[면접 질문 정리 노트]] — 3가지 전략과 특성
- `(보충)` 표시는 LLM 보충
