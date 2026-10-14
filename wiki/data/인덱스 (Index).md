---
type: concept
domain: data
aliases: [Index, B-Tree 인덱스, Hash 인덱스, 커버링 인덱스, Covering Index, 클러스터드 인덱스, Secondary Index]
tags: [db, mysql, innodb]
sources: ["[[면접 질문 정리 노트]]"]
updated: 2026-10-14
---
# 인덱스 (Index)
> 테이블 전체를 훑지 않고 원하는 행을 빠르게 찾기 위한 보조 자료구조.

## 핵심
### 종류
| | B-Tree(B+Tree) 인덱스 | Hash 인덱스 |
|---|---|---|
| 구조 | 이진 트리를 일반화한 균형 트리 | 해시 함수로 key → 위치 |
| 조회 | O(log n), **범위 검색에 강함** | `=` 조회 O(1). 충돌이 심하면 O(n) |
| 범위 검색 | 적합 | 부적합 (순서 없음) |
| 사용처 | InnoDB 기본 | MEMORY 스토리지 엔진 |

- (보충) InnoDB는 정확히는 **B+Tree**를 쓴다. 데이터는 리프 노드에만 있고 리프끼리 연결되어 있어 범위 스캔이 빠르다.
- (보충) InnoDB에도 자주 쓰는 B-Tree 페이지 위에 자동으로 만드는 **적응형 해시 인덱스(Adaptive Hash Index)** 가 있다.

### Primary vs Secondary
- **Primary 인덱스**: 고유한 값으로 동작하는 인덱스. 주로 PK에 걸린 인덱스.
  - (보충) InnoDB의 PK 인덱스는 **클러스터드 인덱스**다. 리프 노드에 행 데이터 전체가 들어 있다.
- **Secondary 인덱스**: 사용자가 추가로 만든 인덱스. 리프에는 (InnoDB 기준) **PK 값**이 포인터로 저장되어, 이를 통해 원본 데이터로 이동해 나머지 컬럼을 조회한다(table lookup).

### 커버링 인덱스
- 쿼리에 필요한 컬럼이 **모두 인덱스 안에** 있는 경우. table lookup 없이 인덱스만으로 결과를 만들 수 있어 빠르다.
- (보충) MySQL `EXPLAIN`의 Extra에 `Using index`로 표시된다.

## 트레이드오프 · 주의점
- (보충) 인덱스는 읽기를 빠르게 하지만 **쓰기마다 갱신 비용**이 들고 저장 공간을 차지한다.
- (보충) 복합 인덱스는 왼쪽 컬럼부터 순서대로 쓰인다(leftmost prefix).
- (보충) PK가 크면 모든 secondary 인덱스가 PK를 담으므로 함께 커진다.

## 관련 개념
- [[트랜잭션 격리 수준 (Transaction Isolation Level)]] — InnoDB의 next-key lock은 인덱스 레코드에 걸린다
- [[관계형 모델과 문서 모델 (Relational vs Document Model)]]

## 면접 포인트
- [[인덱스 종류와 차이는]]
- [[Primary 인덱스와 Secondary 인덱스, 커버링 인덱스란]]

## 출처
- [[면접 질문 정리 노트]] — B-Tree/Hash, Primary/Secondary, 커버링 인덱스
- `(보충)` 표시는 LLM 보충
