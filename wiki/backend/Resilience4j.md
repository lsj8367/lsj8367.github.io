---
type: entity
domain: backend
aliases: [resilience4j]
tags: [java, 장애대응, 라이브러리]
sources: ["[[Resilience4j CircuitBreaker 설정값]]"]
updated: 2026-10-26
---
# Resilience4j
> Java용 경량 내결함성 라이브러리. CircuitBreaker, Retry, RateLimiter, Bulkhead, TimeLimiter 모듈을 제공한다. (보충)

## 개요
- 공식 문서: https://resilience4j.readme.io/docs/circuitbreaker
- (보충) Netflix Hystrix 유지보수 중단 이후 Spring Cloud에서 권장되는 대안. 함수형 데코레이터 방식.

## 주요 특징 / 설정 (CircuitBreaker)
| 설정 | 의미 | 기본값 (보충) |
|---|---|---|
| `slidingWindowType` | 실패율 집계 방식. `COUNT_BASED`(최근 N회 호출) / `TIME_BASED`(최근 N초) | COUNT_BASED |
| `slidingWindowSize` | 윈도우 크기. COUNT_BASED면 호출 수, TIME_BASED면 초 | 100 |
| `minimumNumberOfCalls` | 실패율을 계산하기 위한 최소 호출 수. 이 수에 도달한 뒤 실패율이 `failureRateThreshold` 이상이면 OPEN | 100 |
| `failureRateThreshold` | OPEN으로 전환되는 실패율(%) | 50 |
| `waitDurationInOpenState` (보충) | OPEN 유지 시간. 지나면 HALF_OPEN | 60초 |
| `permittedNumberOfCallsInHalfOpenState` (보충) | HALF_OPEN에서 허용하는 시험 호출 수 | 10 |
| `slowCallDurationThreshold` / `slowCallRateThreshold` (보충) | 느린 호출 기준 시간과 그 비율 임계치 | 60초 / 100% |

> [!warning] 충돌
> 원본 노트는 `slidingWindowType`을 "CLOSED 상태에서 다시 닫히게 할 기준"으로 설명하고, "window size만큼 성공/시간이 지나면 회로가 닫힌다"고 적었다.
> 이 설정이 CLOSED 상태에서 쓰인다는 점은 맞다. 다만 공식 문서 기준으로 `slidingWindowType`은 **CLOSED 상태에서 실패율을 집계하는 범위**이고, 회로를 닫는 기준이 아니다(CLOSED는 이미 닫힌 상태). 회로가 다시 닫히는 것은 OPEN에서 `waitDurationInOpenState`가 지난 뒤 HALF_OPEN의 시험 호출(`permittedNumberOfCallsInHalfOpenState`) 결과로 결정된다. (보충)

> [!warning] 충돌
> 원본 노트는 "`minimumNumberOfCalls`를 `slidingWindowSize`보다 크거나 같게 설정하면 작동하지 않아 의미가 없다"고 적었다.
> 두 값의 기본값은 모두 100으로 같아서, "같으면 작동하지 않는다"는 설명은 맞지 않는다. COUNT_BASED에서 윈도우보다 크게 주면 실제로는 윈도우 크기까지만 의미가 있는 것으로 알고 있다. (보충, 버전별 동작은 공식 문서·코드로 확인 필요)

## 관련
- [[서킷 브레이커 (Circuit Breaker)]] — 개념과 상태 전이
- [[신뢰성 (Reliability)]]

## 출처
- [[Resilience4j CircuitBreaker 설정값]] — slidingWindowSize, slidingWindowType, minimumNumberOfCalls, failureRateThreshold
- `(보충)` 표시는 LLM 보충
