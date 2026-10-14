---
type: source
domain: backend
aliases: []
tags: [resilience4j, 장애대응]
sources: []
updated: 2026-10-14
---
# Resilience4j CircuitBreaker 설정값

- 원본: [[raw/CircuitBreaker/설정값|CircuitBreaker 설정값 노트]]
- 종류: 학습 노트 (공식 문서 https://resilience4j.readme.io/docs/circuitbreaker 참고)

## 요약
Resilience4j CircuitBreaker의 `slidingWindowSize`, `slidingWindowType`(COUNT_BASED/TIME_BASED), `minimumNumberOfCalls` 설정을 정리했다.

## 핵심 주장
- `slidingWindowSize`: 기준 치수. → [[Resilience4j]]
- `slidingWindowType`: 회로를 다시 닫는 기준. COUNT_BASED는 횟수, TIME_BASED는 시간. → [[Resilience4j]] (충돌 표시)
- `minimumNumberOfCalls`: 최소 호출 수. 이후 실패율이 `failureRateThreshold`에 닿으면 회로가 열린다. `slidingWindowSize` 이상으로 설정하면 의미가 없다. → [[Resilience4j]] (충돌 표시)

## 기존 wiki와 충돌 / 보완
- `slidingWindowType`은 "회로를 다시 닫는 기준"이 아니라 **실패율을 집계하는 범위**(최근 N회 호출 / 최근 N초)라는 것이 공식 문서 설명이다. 회로가 다시 닫히는 것은 HALF_OPEN 상태의 시험 호출 결과로 결정된다. (보충) → [[Resilience4j]]에 충돌 콜아웃.
- `minimumNumberOfCalls`를 `slidingWindowSize` 이상으로 두면 "작동하지 않는다"는 부분은 확인 필요. 두 값의 기본값이 모두 100으로 같고, COUNT_BASED에서는 윈도우 크기로 제한되는 것으로 안다. (보충, 확인 필요)
- 서킷 브레이커 개념 자체는 [[서킷 브레이커 (Circuit Breaker)]]에 정리.

## 남은 질문
- 실제 운영에서 쓴 설정값과 그 근거가 있으면 career/에 정리.
