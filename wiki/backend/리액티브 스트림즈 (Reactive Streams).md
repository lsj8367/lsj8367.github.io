---
type: concept
domain: backend
aliases: [Reactive Streams, 배압, Backpressure]
tags: [리액티브, 비동기, 표준]
sources: ["[[리액티브 프로그래밍 - 리액티브 스트림즈]]"]
updated: 2026-10-14
---
# 리액티브 스트림즈 (Reactive Streams)
> 데이터 스트림을 Non-Blocking이면서 비동기적인 방식으로 처리하기 위한 라이브러리의 표준 사양.

## 핵심
- Java의 Stream처럼 정형화된 라이브러리가 아니라 **표준 사양(인터페이스)** 이다. 구현은 라이브러리마다 다르다.

## 세부 / 동작 방식
### 4개 인터페이스 (보충)
| 인터페이스 | 역할 |
|---|---|
| `Publisher` | 데이터를 발행. `subscribe(Subscriber)` |
| `Subscriber` | 데이터를 소비. `onSubscribe`, `onNext`, `onError`, `onComplete` |
| `Subscription` | 둘 사이의 연결. `request(n)`, `cancel()` |
| `Processor` | Publisher이면서 Subscriber (중간 가공) |

### 배압(Backpressure) (보충)
- Subscriber가 `request(n)`으로 **처리할 수 있는 만큼만 요청**한다. 빠른 Publisher가 느린 Subscriber를 압도해 메모리가 넘치는 것을 막는 핵심 장치.

### 구현체 (보충)
- Project Reactor (Flux / Mono, Spring WebFlux의 기반), RxJava, Akka Streams.
- Java 9부터 `java.util.concurrent.Flow`에 같은 인터페이스가 포함되었다.

## 관련 개념
- [[리액티브 프로그래밍 (Reactive Programming)]] — Publisher/Subscriber 구성 요소
- [[리액티브 시스템 (Reactive Systems)]]

## 면접 포인트
- "배압이 무엇이고 왜 필요한가?" → `request(n)` 기반 수요 신호로 생산 속도를 소비 속도에 맞춘다.

## 출처
- [[리액티브 프로그래밍 - 리액티브 스트림즈]] — 정의
- `(보충)` 표시는 LLM 보충
