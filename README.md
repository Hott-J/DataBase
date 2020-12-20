### DBMS
- 데이터를 CRUD(생성,수정,삭제,검색)하는 시스템
- 검색에 최적화(인덱스)
- 업데이트가 많은 경우 대안이 필요
- NoSQL

### RDBMS (관계형 데이터 베이스)
- 테이블 형태로 관리되는 DMBS의 한 형태
- SQL이라는 질의 형태 사용

### CMD
- C:\Program Files\MySQL\MySQL Server 8.0\bin>mysql -uroot -p

### Workbench
- Query 명령문 입력 후, 번개 모양 클릭. 번개+I는 한줄씩 실행, 번개 모양은 전체 실행

### DML (Data Manipulation Language)
- SQL 종류의 하나로, 데이터의 삽입, 삭제, 갱신 등을 처리

### CRUD (Create, Retrieve, Update, Delete)
- 기본적인 데이터 처리 기능인 생성, 읽기, 갱신, 삭제를 묶어서 일컫는 말
  - select 컬럼명 from 테이블명 where 조건절;
    - select name from city where Population>5000000;
  - insert into 테이블명(컬럼명) values (값);
    - insert into city (ID,Name,CountryCode, District, Population) values (20000,'Sample','KOR','Test',2000000);
  - update 테이블명 set 컬럼명=값, ... where 조건절;
    - update city set name='SampleRevised' where id='20000';
  - delete from 테이블명 where 조건절;
    - delete from city where id='20000';

### SQL

- 중복성 제거(distinct)
  - select distinct countrycode from city where countrycode='kor';
  - kor 하나만 출력됨
- 논리연산자(and, or, not, in, between)
   -select * from city where countrycode in ('kor','chn') and (population between 1000000 and 5000000);
- 결과값 정렬(order by)
  - city 테이블에서 국가코드와 인구수를  출력. 정렬은 국가코드 별로 오름차순, 동일한 코드안에서는 인구 수의 역순으로 표시
  - select countrycode, population from city order by countrycode, population desc;
