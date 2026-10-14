---
type: concept
domain: backend
aliases: [GC, Garbage Collection, 가비지 컬렉터, Minor GC, Major GC, stop-the-world]
tags: [java, jvm, 메모리]
sources: ["[[면접 질문 정리 노트]]"]
updated: 2026-10-14
---
# 가비지 컬렉션 (Garbage Collection)
> JVM이 더 이상 참조되지 않는 객체의 메모리를 자동으로 회수하는 과정.

## 핵심
- 힙은 **Young 영역**과 **Old 영역**으로 나뉜다. Young은 **Eden 1개 + Survivor 2개**.
- (보충) 근거: 대부분의 객체는 금방 죽는다(약한 세대 가설, weak generational hypothesis). 그래서 Young을 자주, 싸게 청소한다.

## 세부 / 동작 방식
1. 새 객체는 Eden에 할당된다.
2. Eden이 차면 **Minor GC**. 살아남은 객체를 비어 있는 Survivor로 옮긴다. Survivor 둘 중 하나는 항상 비어 있어야 한다.
3. 다음 Minor GC 때 Eden과 사용 중인 Survivor의 생존 객체를 다른 Survivor로 옮기고, 원래 쪽을 비운다. (보충: 이때 객체의 age가 1씩 증가)
4. (보충) age가 임계값(`-XX:MaxTenuringThreshold`, 기본 15)을 넘거나 Survivor 공간이 부족하면 **Old 영역으로 승격(promotion)** 된다.
5. Old 영역이 차면 **Major GC(Full GC)** 가 일어나 stop-the-world 상태로 Old 영역의 해제 가능한 메모리를 회수한다.

> [!warning] 충돌
> 원본 노트는 "Minor GC가 2회째 수행될 때 비워지는 survivor의 객체들이 old로 이동한다"고 적었다. 실제로는 두 Survivor 사이를 오가며 age가 쌓이고, **age 임계값을 넘었을 때**(또는 Survivor 공간 부족 시) Old로 승격된다. (보충)
> 또한 stop-the-world는 Major GC만의 특징이 아니다. **Minor GC도 STW**이며, 다만 짧다. (보충)

## 트레이드오프 · 주의점
- (보충) GC 알고리즘: Serial, Parallel, CMS(제거됨), **G1(Java 9+ 기본)**, ZGC·Shenandoah(저지연). G1은 힙을 고정 Young/Old가 아닌 **리전(region)** 단위로 관리한다.
- (보충) 긴 GC 정지는 [[분산 락 (Distributed Lock)]]의 락 만료 문제를 일으키는 원인이기도 하다.

## 관련 개념
- [[분산 락 (Distributed Lock)]] — GC 정지 중 락 만료 문제
- [[확장성 (Scalability)]] — GC 정지는 꼬리 지연(p99)의 흔한 원인 (보충)

## 면접 포인트
- [[가비지 컬렉터는 어떻게 동작하는가]]

## 출처
- [[면접 질문 정리 노트]] — Young/Old, Eden/Survivor, Minor/Major GC, STW
- `(보충)` 표시는 LLM 보충
