---
type: concept
domain: backend
aliases: [Reactive Programming, Publisher, Subscriber, Operator]
tags: [리액티브, 비동기]
sources: ["[[리액티브 프로그래밍 - 리액티브 시스템과 리액티브 프로그래밍]]"]
updated: 2026-10-14
---
# 리액티브 프로그래밍 (Reactive Programming)
> 리액티브 시스템을 구축하는 데 필요한 프로그래밍 모델. Blocking I/O 대신 Non-Blocking I/O를 쓰고, 데이터를 끊임없이 흐르는 이벤트로 다룬다.

## 핵심
- **Non-Blocking I/O** 기반 (Blocking I/O ✕).
- **선언형 프로그래밍**: 동작을 구체적으로 명시하지 않고 목표만 선언한다. 메서드 체이닝으로 한 문장처럼 구성한다. 예: `.filter().map().toList()`
- **데이터가 지속적으로 발생**: 데이터가 생길 때마다 이를 변화 이벤트로 보고, 이벤트를 발생시켜 데이터를 계속 전달한다.

## 세부 / 동작 방식
### 구성 요소
| 요소 | 역할 |
|---|---|
| Publisher | 발행자. 입력 데이터를 제공 |
| Subscriber | Publisher가 준 데이터를 받아 사용 |
| DataSource (DataStream) | Publisher에 입력으로 들어오는 데이터 |
| Operator | Publisher와 Subscriber 사이에서 데이터를 가공하는 연산 (filter, map 등). 아무 가공 없이 전달되는 경우는 거의 없다 |

- 이 구성 요소들의 표준 인터페이스 사양이 [[리액티브 스트림즈 (Reactive Streams)]]다.

## 트레이드오프 · 주의점
- (보충) 높은 동시성을 적은 스레드로 처리할 수 있지만, 디버깅·스택트레이스 추적이 어렵고 학습 곡선이 높다.
- (보충) 체인 중간에 Blocking 호출(예: JDBC)이 끼면 이점이 사라진다.

## 관련 개념
- [[리액티브 시스템 (Reactive Systems)]] — 이 모델로 구현하려는 시스템 특성
- [[리액티브 스트림즈 (Reactive Streams)]] — 표준 사양

## 면접 포인트
- "Blocking I/O와 Non-Blocking I/O의 차이와, 리액티브가 이득인 상황은?" (보충: I/O 대기가 많은 고동시성 서비스)

## 출처
- [[리액티브 프로그래밍 - 리액티브 시스템과 리액티브 프로그래밍]] — 정의, 특징, 구성 요소
- `(보충)` 표시는 LLM 보충
