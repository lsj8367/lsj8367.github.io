---
type: concept
domain: backend
aliases: [GC, Garbage Collection, 가비지 컬렉터, Minor GC, Major GC, stop-the-world]
tags: [java, jvm, 메모리]
sources: ["[[면접 질문 정리 노트]]"]
updated: 2026-10-26
---
# 가비지 컬렉션 (Garbage Collection)
> JVM이 더 이상 참조되지 않는 객체의 메모리를 자동으로 회수하는 과정.

## 핵심
- 힙은 **Young 영역**과 **Old 영역**으로 나뉜다. Young은 **Eden 1개 + Survivor 2개**.
- (보충) 근거: 대부분의 객체는 금방 죽는다(약한 세대 가설, weak generational hypothesis). 그래서 Young을 자주, 싸게 청소한다.

## 세부 / 동작 방식
1. 새 객체는 Eden에 할당된다.
2. Eden이 차면 **Minor GC**. 살아남은 객체를 비어 있는 Survivor로 옮긴다. Survivor 둘 중 하나는 항상 비어 있어야 한다.
3. 다음 Minor GC 때 Eden과 사용 중인 Survivor의 생존 객체를 다른 Survivor로 옮기고, 원래 쪽을 비운다. 두 Survivor 사이를 오갈 때마다 객체의 age가 쌓인다.
4. age가 임계값을 넘거나 Survivor 공간이 부족하면 **Old 영역으로 승격(promotion)** 된다. (보충: 임계값은 `-XX:MaxTenuringThreshold`, 기본 15)
5. Old 영역이 차면 **Major GC(Full GC)** 가 일어나 Old 영역의 해제 가능한 메모리를 회수한다.
6. **stop-the-world(STW)** 는 Minor GC와 Major GC 모두에서 일어난다. 다만 Minor GC는 빠르다.

## 트레이드오프 · 주의점
- (보충) GC 알고리즘: Serial, Parallel, CMS(제거됨), **G1(Java 9+ 기본)**, ZGC·Shenandoah(저지연). G1은 힙을 고정 Young/Old가 아닌 **리전(region)** 단위로 관리한다.
- (보충) 긴 GC 정지는 [[분산 락 (Distributed Lock)]]의 락 만료 문제를 일으키는 원인이기도 하다.

## 관련 개념
- [[분산 락 (Distributed Lock)]] — GC 정지 중 락 만료 문제
- [[확장성 (Scalability)]] — GC 정지는 꼬리 지연(p99)의 흔한 원인 (보충)

## 면접 포인트
- [[가비지 컬렉터는 어떻게 동작하는가]]

## 출처
- [[면접 질문 정리 노트]] — Young/Old, Eden/Survivor, Minor/Major GC, age 임계값·Survivor 부족 시 승격, Minor·Major 모두 STW
- `(보충)` 표시는 LLM 보충
