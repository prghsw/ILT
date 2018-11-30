LAG
=========================

### LAG 란?
1. LAG는 이전 ROW 데이터에 접근할 수 있도록 하는 분석 함수이다.

## 문법

LAG ( 컬럼명 ) OVER ( ORDER BY 컬럼명 )

LAG ( 컬럼명 ) OVER ( PARTITION BY 컬럼명 ORDER BY 컬럼명 )

LAG ( 컬럼명, 접근위치 ) OVER ( ORDER BY 컬럼명 )

LAG ( 컬럼명, 접근위치 ) OVER ( PARTITION BY 컬럼명 ORDER BY 컬럼명 )

LAG ( 컬럼명, 접근위치, 접근위치 값이 없는 경우 노출값 ) OVER ( ORDER BY 컬럼명 )

LAG ( 컬럼명, 접근위치, 접근위치 값이 없는 경우 노출값 ) OVER ( PARTITION BY 컬럼명 ORDER BY 컬럼명 )

    1. 컬럼명
      - 이전 ROW에 접근할 컬럼.
    2. 접근위치
      - 정의 하지 않으면 기본값은 1.
    3. 접근위치 값이 없는 경우 노출 값
      - 정의 하지 않으면 null값으로 노출.
    4. PARTIRION BY
      - 접근할 ROW를 구분할 컬럼.
    5. ORDER BY
      - 접근할 ROW 순서.
      
## 예제
* 테이블 정보 (TEMP_TABLE)

|  <center>SEQ</center> |  <center>NAME</center> |  <center>AGE</center> |  <center>BIRTH_DAY</center> |
|:----:|:-------:|---:|:------|
| 1 | SangWan | 10 | 06-25 |
| 1 | MiRim   | 20 | 05-05 |
| 2 | JiYu    | 30 | 02-23 |
| 3 | Dana    | 40 | 12-12 |

* 쿼리 및 실행 결과

```
SELECT
   NAME
  ,AGE
  ,BIRTH_DAY
  ,LAG(AGE) OVER( ORDER BY AGE ASC ) AS LAG_AGE
FROM TEMP_TABLE
 ```

|  <center>SEQ</center> |  <center>NAME</center> |  <center>AGE</center> |  <center>BIRTH_DAY</center> |  <center>LAG_AGE</center> |
|:----:|:-------:|---:|:------|:----:|
| 1 | SangWan | 10 | 06-25 | NULL |
| 1 | MiRim   | 20 | 05-05 | 10 |
| 2 | JiYu    | 30 | 02-23 | 20 |
| 3 | Dana    | 40 | 12-12 | 40 |

```
SELECT
   NAME
  ,AGE
  ,BIRTH_DAY
  ,LAG(AGE) OVER( PARTITION BY SEQ ORDER BY AGE ASC ) AS LAG_AGE
FROM TEMP_TABLE
 ```

|  <center>SEQ</center> |  <center>NAME</center> |  <center>AGE</center> |  <center>BIRTH_DAY</center> |  <center>LAG_AGE</center> |
|:----:|:-------:|---:|:------|:----:|
| 1 | SangWan | 10 | 06-25 | NULL |
| 1 | MiRim   | 20 | 05-05 | 10 |
| 2 | JiYu    | 30 | 02-23 | NULL |
| 3 | Dana    | 40 | 12-12 | NULL |


```
SELECT
   NAME
  ,AGE
  ,BIRTH_DAY
  ,LAG(AGE, 2) OVER( ORDER BY AGE ASC ) AS LAG_AGE
FROM TEMP_TABLE
```

|  <center>SEQ</center> |  <center>NAME</center> |  <center>AGE</center> |  <center>BIRTH_DAY</center> |  <center>LAG_AGE</center> |
|:----:|:-------:|---:|:------|:----:|
| 1 | SangWan | 10 | 06-25 | NULL |
| 1 | MiRim   | 20 | 05-05 | NULL |
| 2 | JiYu    | 30 | 02-23 | 20 |
| 3 | Dana    | 40 | 12-12 | 30 |

```
SELECT
   NAME
  ,AGE
  ,BIRTH_DAY
  ,LAG(AGE, 2) OVER( PARTITION BY SEQ ORDER BY AGE ASC ) AS LAG_AGE
FROM TEMP_TABLE
```

|  <center>SEQ</center> |  <center>NAME</center> |  <center>AGE</center> |  <center>BIRTH_DAY</center> |  <center>LAG_AGE</center> |
|:----:|:-------:|---:|:------|:----:|
| 1 | SangWan | 10 | 06-25 | NULL |
| 1 | MiRim   | 20 | 05-05 | NULL |
| 2 | JiYu    | 30 | 02-23 | NULL |
| 3 | Dana    | 40 | 12-12 | NULL |

```
SELECT
   NAME
  ,AGE
  ,BIRTH_DAY
  ,LAG(AGE, 1, 'NO') OVER( ORDER BY AGE ASC ) AS LAG_AGE
FROM TEMP_TABLE
```

|  <center>SEQ</center> |  <center>NAME</center> |  <center>AGE</center> |  <center>BIRTH_DAY</center> |  <center>LAG_AGE</center> |
|:----:|:-------:|---:|:------|:----:|
| 1 | SangWan | 10 | 06-25 | NO |
| 1 | MiRim   | 20 | 05-05 | 10 |
| 2 | JiYu    | 30 | 02-23 | 20 |
| 3 | Dana    | 40 | 12-12 | 30 |

```
SELECT
   NAME
  ,AGE
  ,BIRTH_DAY
  ,LAG(AGE, 1, 'NO') OVER( PARTITION BY SEQ ORDER BY AGE ASC ) AS LAG_AGE
FROM TEMP_TABLE
```

|  <center>SEQ</center> |  <center>NAME</center> |  <center>AGE</center> |  <center>BIRTH_DAY</center> |  <center>LAG_AGE</center> |
|:----:|:-------:|---:|:------|:----:|
| 1 | SangWan | 10 | 06-25 | NO |
| 1 | MiRim   | 20 | 05-05 | 10 |
| 2 | JiYu    | 30 | 02-23 | NO |
| 3 | Dana    | 40 | 12-12 | NO |
