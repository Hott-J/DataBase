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

### SQL의 DML

- 중복성 제거(distinct)
  - select distinct countrycode from city where countrycode='kor';
  - kor 하나만 출력됨
- 논리연산자(and, or, not, in, between)
  - select * from city where countrycode in ('kor','chn') and (population between 1000000 and 5000000);
- 결과값 정렬(order by)
  - city 테이블에서 국가코드와 인구수를  출력. 정렬은 국가코드 별로 오름차순, 동일한 코드안에서는 인구 수의 역순으로 표시
    - select countrycode, population from city order by countrycode, population desc;
- 결과값 일부 조회
  -  국가코드가 'kor'인 도시들 중 인구수 많은 순서로 상위 10개만 표시
    - select name from city where countrycode='kor' order by population desc limit 10;
- 집합함수 ( count(),sum(),avg(),min(),max() )
  - select aggregation_function(컬럼명) from 테이블명 where 조건절;
  - city 테이블에서 국가코드가 'kor'인 도시들의 인구수 중 최대값을 구하시오
    - select max(population) from city where countrycode='kor';
- 유용한 함수들
  - LENGTH()
    - 레코드의 문자열 컬럼의 글자수를 리턴
    - country 테이블 각 레코드의 name 칼럼의 글자수를 표시
      - select length(Name) from country;
  - MID()
    - substring
    - 문자열의 중간부분을 리턴
  - UPPER() / LOWER()
    - 문자열을 대문자 / 소문자로 리턴
    - 나라명을 앞 세글자만 대문자로 표시
      - select upper(mid(Name,1,3)) from country;
  - ROUND()
    - 레코드의 숫자컬럼값을 반올림해서 리턴
- JOIN
  - 서로 다른 테이블을 공통 컬럼을 기준으로 합치는 테이블 단위 연산
  - 조인의 결과 테이블은 이전 테이블의 컬럼 수의 합과 같다
  - select * from 테이블1 join 테이블2 on 테이블1.컬럼명 = 테이블2.컬럼명...
  - city테이블과 country테이블을 조인하시오
    -  select * from city join country on city.countrycode=country.code;
  - 국가코드와 해당 나라의 GNP르 ㄹ표시
    - select city.countrycode, country.gnp from city join country on city.countrycode=country.code;
  - inner join
    - join 시 NULL 허용하지 않음
  - left join
    - join 시 왼쪽 테이블의 NULL 포함
  - right join
    - join 시 오른쪽 테이블의 NULL 포함

- 별명
  - SQL 쿼리 결과생성시 컬럼명에 대한 별명을 사용해 표시하는 기능
  - select 테이블명1.컬렴명1 AS 별명1, 테이블명2.컬럼명2 AS 별명2 FROM ...
  - 조인할 때 많이 사용
  - city 테이블과 country 테이블을 조인해서 국가코드가 'kor' 인 나라의 축약표시명과 정식명을 표시
    -  select city.countrycode as abbr, country.name as fullname from city where city.countrycode='kor';
    
- 뷰
  - SQL 쿼리의 결과값을 임시테이블로 저장해서 사용
  - 사용용도가 끝나면 명시적으로 삭제
  - create view 뷰명 as select ...
  - 국가코드가 'kor'인 도시들의 국가코드와 국가명을 뷰로 생성(국가코드를 abbr, 국가명을 fullname)
    - create view sampleView as select city.countrycode as abbr,country.name as fullname from city join country on city.countrycode=country.code where city.countrycode='kor';
    - select * from sampleView;
    - drop view sampleView; (뷰 삭제)
    - show tables; (지워졌는지 확인)
