---
type: concept
domain: math
aliases: [Central Limit Theorem, CLT, 표준오차, Standard Error]
tags: [통계, 추론통계]
sources: ["[[개발자를 위한 필수수학 3장 - 기술 통계와 추론 통계]]"]
updated: 2026-10-14
---
# 중심 극한 정리 (Central Limit Theorem)
> 모집단의 분포와 상관없이, 표본 크기가 충분히 크면 표본 평균들의 분포는 정규분포에 가까워진다.

## 핵심
값 하나로는 정규분포를 만들 수 없지만, **표본의 평균**을 여러 번 내서 분포로 그리면 정규분포가 나타난다.

1. 표본 평균의 평균은 모평균과 같다.
2. 모집단이 정규분포이면 표본 평균도 정규분포가 된다.
3. 모집단이 정규분포가 아니어도 표본 크기가 30보다 크면 표본 평균은 대략 정규분포를 따른다.
   - 왜 30인가? 통계학 실험을 통해 정해진 관례적 기준선이다.
4. 표본 평균의 표준편차, 즉 **표준오차(standard error)** 는 모표준편차를 √n으로 나눈 값이다: SE = σ / √n

## 세부 / 동작 방식
### 표준오차 시뮬레이션
균등분포 모집단(1만 개)에서 크기 30인 표본을 여러 번 뽑아 `s / √n`의 평균을 구하면 `σ / √n`과 거의 같다.

```python
import random, math
population = [random.uniform(0.0, 1.0) for _ in range(10000)]
p_mean = sum(population) / len(population)
p_std_dev = math.sqrt(sum((v - p_mean) ** 2 for v in population) / len(population))

n = 30
estimated_SEs = []
for _ in range(n):
    samples = random.sample(population, n)
    s_mean = sum(samples) / n
    s_std_dev = math.sqrt(sum((v - s_mean) ** 2 for v in samples) / (n - 1))  # 표본은 n-1
    estimated_SEs.append(s_std_dev / math.sqrt(n))

print(sum(estimated_SEs) / len(estimated_SEs), p_std_dev / math.sqrt(n))
```
- 표본 분산은 n이 아니라 **n − 1**로 나눈다(베셀 보정). (보충: 표본 평균이 모평균보다 표본에 더 가까워 분산이 작게 추정되는 것을 보정)

### 왜 중요한가 (중간 정리)
- 모집단 전체를 알 수 없으므로 주어진 데이터는 표본이라고 가정해야 한다.
- 표본 평균을 반복해서 구하면 모집단의 평균·분산·표준편차를 추정할 수 있고, 데이터가 얼마나 신뢰할 만한지도 확인할 수 있다.
- 표본(각 31개 이상)이 여럿 있으면 히스토그램으로 추이를 보고, 정규분포가 나타나면 중심 극한 정리로 표준오차와 모표준편차를 추정할 수 있다.
- (보충) 실무에서는 대개 반대 방향으로 쓴다. 표본 하나의 표준편차 s로 SE ≈ s/√n을 추정하고, 이를 [[신뢰 구간 (Confidence Interval)]]과 가설 검정에 쓴다.

## 트레이드오프 · 주의점
- (보충) n > 30은 경험칙이다. 모집단이 심하게 치우쳐 있으면(예: 응답 시간처럼 꼬리가 긴 분포) 더 큰 표본이 필요하다.
- (보충) 정리는 **평균**의 분포에 관한 것이다. 원래 데이터가 정규분포가 된다는 뜻이 아니다.

## 관련 개념
- [[신뢰 구간 (Confidence Interval)]] — 표준오차로 구간을 만든다
- [[확장성 (Scalability)]] — 응답 시간은 꼬리가 긴 분포라 평균 대신 백분위를 쓴다

## 면접 포인트
- "표본 분산을 n−1로 나누는 이유는?"
- "중심 극한 정리가 A/B 테스트에서 왜 필요한가?" (보충: 전환율 같은 평균 차이를 정규분포로 근사해 검정)

## 출처
- [[개발자를 위한 필수수학 3장 - 기술 통계와 추론 통계]] — 4가지 성질, 30 기준, 시뮬레이션 코드, 중간 정리
- `(보충)` 표시는 LLM 보충
