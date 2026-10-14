---
type: concept
domain: backend
aliases: [Distributed Lock, 펜싱 토큰, Fencing Token]
tags: [분산시스템, 동시성, redis, zookeeper]
sources: ["[[면접 질문 정리 노트]]"]
updated: 2026-10-14
---
# 분산 락 (Distributed Lock)
> 여러 서버(프로세스)가 공유 자원에 동시에 접근하지 못하도록 외부 저장소를 이용해 거는 락.

## 핵심
- 단일 JVM의 `synchronized`로는 서버가 여러 대일 때 막을 수 없어 Redis·ZooKeeper 같은 외부 저장소로 락을 건다.

## 세부 / 동작 방식
### Redis 분산 락 (보충)
- `SET key value NX PX <ttl>`로 키가 없을 때만 설정해 락을 얻는다. value는 락 소유자 식별값으로, 해제 시 본인 락인지 확인한다(Lua 스크립트로 원자적 확인 + 삭제).
- Java에서는 Redisson 같은 클라이언트가 이를 감싸 준다.

### 발생할 수 있는 문제
1. **락 보유 중 서버 비정상 종료** → 락이 해제되지 않는다.
   - (보충) 해결: 락에 **TTL(만료 시간)** 을 둔다.
2. **TTL 때문에 생기는 문제**: 락을 잡은 서버가 Full GC 등으로 잠시 멈춘 사이 락이 만료되고, 다른 서버가 락을 얻어 데이터를 바꾼다. 멈췄던 서버가 깨어나 자기가 아직 락을 가졌다고 믿고 쓰기를 한다.
   - 해결: **펜싱 토큰(fencing token)**. 락을 줄 때마다 단조 증가하는 번호를 함께 주고, 낮은 번호의 쓰기는 실패시킨다.
   - (보충) 핵심은 **저장소(자원) 쪽이 토큰을 검증**해야 한다는 점이다. 락 서비스만으로는 막을 수 없다.

### 더 나은 락: ZooKeeper
- 앙상블(여러 노드)로 복제되어 한 인스턴스가 죽어도 일관된 상태를 유지한다.
- (보충) 임시 순차 노드(ephemeral sequential znode)로 락을 구현하고, 세션이 끊기면 락이 자동 해제된다. 트랜잭션 ID(zxid)나 노드 버전을 펜싱 토큰으로 쓸 수 있다.

## 트레이드오프 · 주의점
- (보충) Redis 여러 노드에 과반 락을 거는 Redlock 알고리즘은 시계·GC 정지에 대한 가정 때문에 안전성 논쟁이 있다(Martin Kleppmann vs antirez). 정합성이 중요하면 합의(consensus) 기반 시스템(ZooKeeper, etcd)을 쓰는 편이 안전하다.
- (보충) 효율 목적(중복 작업 방지)이냐 정합성 목적이냐에 따라 요구 수준이 다르다.

## 관련 개념
- [[Redis]] — 단일 스레드 원자 연산, Lua 스크립트
- [[가비지 컬렉션 (Garbage Collection)]] — GC 정지가 락 만료의 원인
- [[트랜잭션 격리 수준 (Transaction Isolation Level)]] — DB 수준의 동시성 제어(비관락·낙관락)와 비교
- [[데이터 중심 애플리케이션 설계 (Designing Data-Intensive Applications)]] — 8장(분산 시스템의 골칫거리)의 펜싱 토큰 (보충)

## 면접 포인트
- [[Redis 분산 락의 문제점과 해결 방법은]]

## 출처
- [[면접 질문 정리 노트]] — 비정상 종료, GC 중 락 만료, 펜싱 토큰, ZooKeeper 앙상블
- `(보충)` 표시는 LLM 보충
