---
type: concept
domain: data
aliases: [Transaction Isolation Level, 격리수준, MVCC, Lost Update, Write Skew, 팬텀 리드, Phantom Read, next-key lock]
tags: [db, mysql, innodb, 동시성, 트랜잭션]
sources: ["[[면접 질문 정리 노트]]"]
updated: 2026-10-14
---
# 트랜잭션 격리 수준 (Transaction Isolation Level)
> 동시에 실행되는 트랜잭션들이 서로의 변경을 얼마나 볼 수 있는지 정하는 수준. 높을수록 이상 현상이 줄고 동시성은 떨어진다.

## 핵심
| 격리 수준 | 설명 | Dirty Read | Non-Repeatable Read | Phantom Read |
|---|---|---|---|---|
| Read Uncommitted | 커밋·롤백 전의 변경도 보인다 | O | O | O |
| Read Committed | 커밋된 데이터만 본다. 같은 조회를 반복하면 결과가 달라질 수 있다 | X | O | O |
| Repeatable Read | 한 트랜잭션 안의 반복 조회 결과를 보장. **MySQL 기본** | X | X | O (표준) / InnoDB는 대부분 방지 |
| Serializable | 모든 조회·쓰기에 락. 동시성 위반 없음, 처리량 낮음 | X | X | X |

(표의 O/X는 보충: 표준 SQL 정의 기준)

## 세부 / 동작 방식
### InnoDB의 Repeatable Read
- **MVCC**(다중 버전 동시성 제어): 일반 SELECT는 undo log의 스냅샷을 읽어 같은 결과를 보장한다(consistent read).
- `SELECT ... FOR UPDATE`(잠금 읽기)는 undo log에 락을 걸 수 없으므로 **최신 커밋 데이터**를 읽고 락을 건다. 그 사이 변경이 있었다면 같은 트랜잭션 안에서도 조회 결과가 달라질 수 있다.
- 그래서 InnoDB는 조건에 해당하는 범위에 **next-key lock**(레코드 락 + 갭 락)을 함께 걸어 그 범위로의 INSERT를 막는다.

> [!warning] 충돌
> 원본 노트는 next-key lock이 "멱등성을 보장한다"고 적었다. next-key lock의 목적은 **팬텀 리드 방지**(범위에 새 행이 끼어드는 것을 막음)이다. "멱등성"은 같은 연산을 여러 번 해도 결과가 같다는 다른 개념이다. (보충)

- 노트: next-key lock이 걸리지 않는 경우 서로 다른 트랜잭션이 각자 INSERT할 수 있으므로, 개발자가 직접 `SELECT ... FOR UPDATE`로 락을 잡아야 한다. (보충, 확인 필요: 빈 범위에 대한 갭 락은 서로 호환되어 둘 다 획득된 뒤 INSERT 시 데드락이 나는 경우가 많다)

### 이상 현상과 대응
- **Lost Update(갱신 손실)**: 두 트랜잭션이 같은 값을 읽고 각자 갱신해 한쪽 변경이 사라진다.
  - 낙관적 락: version 컬럼으로 충돌 감지 후 재시도.
  - 비관적 락: 충돌이 잦으면 `SELECT ... FOR UPDATE`.
- **Write Skew(쓰기 스큐)**: MVCC를 쓰더라도 두 트랜잭션이 **같은 조건을 읽고 서로 다른 행을 쓰는** 바람에 락이 겹치지 않아, 합치면 제약이 깨진다.
  - (보충) DDIA 7장의 예: 당직 의사가 최소 1명이어야 하는데 두 의사가 동시에 "다른 의사가 있다"는 것을 확인하고 둘 다 당직을 빠진다.
  - (보충) 대응: 읽은 행에 `FOR UPDATE`, 충돌 구체화(materializing conflicts), Serializable.

## 트레이드오프 · 주의점
- (보충) MySQL InnoDB의 Serializable은 autocommit이 꺼진 상태에서 일반 SELECT를 공유 락 읽기로 바꾸는 방식이라 처리량이 크게 떨어진다.
- (보충) DB마다 같은 이름의 격리 수준이라도 보장이 다르다. 예: PostgreSQL의 Repeatable Read는 lost update를 감지해 에러를 내지만 MySQL은 그렇지 않다.

## 관련 개념
- [[인덱스 (Index)]] — 락은 인덱스 레코드 단위로 걸린다
- [[분산 락 (Distributed Lock)]] — DB 밖에서의 동시성 제어
- [[데이터 중심 애플리케이션 설계 (Designing Data-Intensive Applications)]] — 7장 트랜잭션 (미정리)

## 면접 포인트
- [[트랜잭션 격리 수준을 설명하라]]

## 출처
- [[면접 질문 정리 노트]] — 4단계, MVCC, select for update, next-key lock, lost update, write skew
- `(보충)` 표시는 LLM 보충
