### DBMS
- 데이터를 CRUD(생성,수정,삭제,검색)하는 시스템
- 검색에 최적화(인덱스)
- 업데이트가 많은 경우 대안이 필요
- NoSQL

### RDBMS (관계형 데이터 베이스)
- 테이블 형태로 관리되는 DMBS의 한 형태
- SQL이라는 질의 형태 사용

### CMD
- `C:\Program Files\MySQL\MySQL Server 8.0\bin>mysql -uroot -p`

### Workbench
- Query 명령문 입력 후, 번개 모양 클릭. 번개+I는 한줄씩 실행, 번개 모양은 전체 실행

### DML (Data Manipulation Language)
- SQL 종류의 하나로, 데이터의 삽입, 삭제, 갱신 등을 처리

### CRUD (Create, Retrieve, Update, Delete)
- 기본적인 데이터 처리 기능인 생성, 읽기, 갱신, 삭제를 묶어서 일컫는 말
  - select 컬럼명 from 테이블명 where 조건절;
    - `select name from city where Population>5000000;`
  - insert into 테이블명(컬럼명) values (값);
    - `insert into city (ID,Name,CountryCode, District, Population) values (20000,'Sample','KOR','Test',2000000);`
  - update 테이블명 set 컬럼명=값, ... where 조건절;
    - `update city set name='SampleRevised' where id='20000';`
  - delete from 테이블명 where 조건절;
    - `delete from city where id='20000';`

### SQL의 DML

- 중복성 제거(distinct)
  - `select distinct countrycode from city where countrycode='kor';`
  - kor 하나만 출력됨
- 논리연산자(and, or, not, in, between)
  - `select * from city where countrycode in ('kor','chn') and (population between 1000000 and 5000000);`
- 결과값 정렬(order by)
  - city 테이블에서 국가코드와 인구수를  출력. 정렬은 국가코드 별로 오름차순, 동일한 코드안에서는 인구 수의 역순으로 표시
    - `select countrycode, population from city order by countrycode, population desc;`
- 결과값 일부 조회
  -  국가코드가 'kor'인 도시들 중 인구수 많은 순서로 상위 10개만 표시
    - `select name from city where countrycode='kor' order by population desc limit 10;`
- 집합함수 ( count(),sum(),avg(),min(),max() )
  - `select aggregation_function(컬럼명) from 테이블명 where 조건절;`
  - city 테이블에서 국가코드가 'kor'인 도시들의 인구수 중 최대값을 구하시오
    - `select max(population) from city where countrycode='kor';`
- 유용한 함수들
  - LENGTH()
    - 레코드의 문자열 컬럼의 글자수를 리턴
    - country 테이블 각 레코드의 name 칼럼의 글자수를 표시
      - `select length(Name) from country;`
  - MID()
    - substring
    - 문자열의 중간부분을 리턴
  - UPPER() / LOWER()
    - 문자열을 대문자 / 소문자로 리턴
    - 나라명을 앞 세글자만 대문자로 표시
      - `select upper(mid(Name,1,3)) from country;`
  - ROUND()
    - 레코드의 숫자컬럼값을 반올림해서 리턴
- JOIN
  - 서로 다른 테이블을 공통 컬럼을 기준으로 합치는 테이블 단위 연산
  - 조인의 결과 테이블은 이전 테이블의 컬럼 수의 합과 같다
  - select * from 테이블1 join 테이블2 on 테이블1.컬럼명 = 테이블2.컬럼명...
  - city테이블과 country테이블을 조인하시오
    - `select * from city join country on city.countrycode=country.code;`
  - 국가코드와 해당 나라의 GNP를 표시
    - `select city.countrycode, country.gnp from city join country on city.countrycode=country.code;`
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
    -  `select city.countrycode as abbr, country.name as fullname from city where city.countrycode='kor';`
    
- 뷰
  - SQL 쿼리의 결과값을 임시테이블로 저장해서 사용
  - 사용용도가 끝나면 명시적으로 삭제
  - create view 뷰명 as select ...
  - 국가코드가 'kor'인 도시들의 국가코드와 국가명을 뷰로 생성(국가코드를 abbr, 국가명을 fullname)
    - `create view sampleView as select city.countrycode as abbr,country.name as fullname from city join country on city.countrycode=country.code where city.countrycode='kor';`
    - `select * from sampleView;`
    - `drop view sampleView;` (뷰 삭제)
    - `show tables;` (지워졌는지 확인)

- select into
  - 쿼리 결과를 새 테이블로 만든다
  - create table 테이블명 select * from 테이블명
  - 기존에 존재하지 않는 테이블이 새로 생성
  - city 테이블의 내용에서 국가코드가 'kor'인 도시를 찾아 city_new 테이블에 넣으시오.
    - `create table city_new select * from city where countrycode='kor';`
    - `select * from city_new;`

- insert into select
  - 쿼리결과를 기존의 테이블에 추가
  - `insert into 테이블명1 select * from 테이블명2 where 조건절;`
  - 두 개의 별도 쿼리를 하나로 합침
  - city 테이블의 내용에서 국가코드가 'kor'인 도시를 찾아 city_kor 테이블에 넣는다
    - `show create table city; 스키마 조회`
    - `create table city_kor (스키마 내용)`
    - `insert into city_kor select * from city where countrycode='kor';`

- case when end
  -  SQL의 조건문에 해당
  - case when 조건값1 then <br>
         when 조건값2 then <br>
         else <br>
    end
  - city 테이블에서 도명이 3자가 넘어가는 경우에 앞쪽 세 자만 대문자로 출력하고 도시의 인구를 같이 표시
    - ```  
      select case when length(Name) > 3 then upper(mid(Name,1,3)) 
       ->          when length(name)<=3 then UPEER(name)
       ->     end, population from city;
      ```
- Like 검색
  - 정확한 키워드를 모를 경우 일부만으로 검색
  - 와일드카드( %, _ )를 사용하여 패턴 매칭
    - `select 컬럼명 from 테이블명 where 컬럼명 like 패턴`
  - 와일드카드(Wildcard)
    - % : 0-n 글자, _: 1 글자
  - 논리조건자를 중복해서 사용하지 않는게 좋다. 부담이 크다
  - city 테이블에서 국가코드가 k로 시작하는 국가코드를 표시하시오
    - `select countrycode from city where countrycode like 'k%';`
  - city 테이블에서 국가코드가 k로 시작하는 3글자 국가코드를 표시하시오
    - `select countrycode from city where countrycode like 'k__';`

- NULL 값
  -  해당 컬럼의 값이 없다는 의미
  - 널 값을 가지고 있는 컬럼을 검색하려면 is NULL
  - 널이 아닌 값을 가지고 있는 컬럼을 검색하려면 is not NULL
  - country 테이블에서 기대수명이 없는 국가개수를 표시
    - `select count(*) from country where LifeExpentancy is NULL;`
    
- NULL 함수
  -  숫자컬럼을 연산해야 할 때 NULL을 처리해주는 함수
  - 주로 0으로 대체
  - IFNULL(COALESCE) : MySQL
  - 숫자연산/집합함수의 경우는 처리가 내장
  - 직접 함수나 쿼리에 넣는 경우는 널 함수를 사용
  - country 테이블의 기대수명의 평균값을 표시 (널 값 미반영/반영)
    - `select avg(lifeexpectancy) from country`
    - `select avg(ifnull(lifeexpectancy,0)) from country;`
    
- Group by / having
  - group by
    - 집합 함수와 같이 사용해 그룹별 연산을 적용
    - select 컬럼명, 집합함수명(컬럼명) from 테이블명 group by 컬럼명;
    - city 테이블의 국가코드별 도시숫자를 구하시오.
      - `select countrycode, count(countrycode) from city group by countrycode;`
  - having
    - 집합 연산에 where 조건절 대체로 사용
    - city 테이블의 국가코드별 도시숫자를 구하시오(단, 70개 이상의 도시를 가지는 국가만 표시)
      - `select countrycode, count(countrycode) from city group by countrycode having count(countrycode)>=70;`
      
- 서브쿼리
  - 쿼리문 내에 또다른 쿼리문이 있는 형태
  - 서브쿼리는 메인쿼리에 포함되는 관계
    - ()를 사용해 감싸는 형태
    - order by를 사용하지 못함
  - 다중행 연산자
    - ALL 
      - 여러 개의 레코드의 and 효과(가장 큰 값보다 큰)
    - ANY
      - 여러 개의 레코드의 or 효과 (가장 작은 값보다 큰)
    - IN / EXISTS
      - 결과값 중에 있는 것 중에서의 의미
      - IN은 전체 레코드를 스캔하고, EXISTS는 존재여부만 확인하고 스캔하지 않음(상대적으로 빠름)
      - 존재하는 TRUE / 존재하지 않으면 FALSE
    - 국가명이 south korea의 국가코드를 찾아 이에 해당되는 도시의 수를 표시
      - `select count( * ) from city where countrycode=(Select code from country where name='south korea');`
    - city 테이블에서 국가코드가 'kor' 인 도시의 평균 인구 수보다 많은 도시들의 이름을 표시
      - `select name,population from city where population > (select avg(population) from city where countrycode='kor') order by poulation desc;`
    - 인구가 5000000명이 넘어가는 도시의 도시의 이름, 국가코드, 인구 수를 표시하시오(IN)
      - `select name, countrycode, population from city where (name,countrycode) in (select name,countrycode from city where population > 5000000);`
    - 한국의 모든 도시의 인구 수보다 많은 도시를 찾아 표시하시오
      - `select name, countrycode, population from city where population > all(select population from city where countrycode='kor');`
    - 국가코드가 'kor','chn','jpn' 인 도시명과 국가코드, 인구수르 출력 (exists)
      - `select name,countrycode,population from city where exists (select * from countrycode in ('kor','chn','jpn'));`

- 집합연산
  - 각종 집합연산 지원
  - 합집합(UNION), 교집합(INTERSECT), 차집합(MINUS)
    - MySQL은 INTERSECT / MINUS 는 지원하지 않아, 다른 쿼리로 대체해야함
  - UNION
    - select 쿼리1 union select 쿼리2 union ...
    - 두 쿼리의 결과 형식이 동일해야함(기본적으로 distinct 적용)
    - union all 의 경우는 중복허용 하지 않아 전부다 출력
    - 다른 테이블이라도 결과값의 형식만 일치하면 됨
  - city테이블에서 국가코드가 'kor', 국가코드가 'chn'인 도시를 구해라
    - `select * from city where countrycode='kor' union select * from city where countrycode='chn';`
  - INTERSECT
    - `select 쿼리1 intersect select 쿼리2`
  - minus / except
    - `select 쿼리1 minus select 쿼리2`
  - country 테이블에서 기대수명이 80세 이상인 나라와 인구가 100만 이상인 나라를 구하고 공통되는 나라를 표시
    - `select code from country where lifeexpectancy >=80 and countrycode in (select distinct code from coutry where population>=1000000);`
  - city 테이블에서 인구가 500만이 넘는 도시의 국가명(단, 국가코드가 'chn'인 도시를 제외)을 표시
    - `select distinct countrycode from city where population>5000000 and countrycode not in (select distinct countrycode from city where countrycode='chn');`
  
### DDL

- DDL
  - 데이터베이스와 테이블을 CRUD
  - 테이블에 대한 정보는 메타데이터로 데이터사전에 저장 관리된다.

- 데이터베이스 생성
  - `CREATE DATABASE 데이터베이스명;`

- 테이블 생성
  - `CREATE TABLE 테이블명 (컬럼명1 데이터타입(크기),컬럼명2...);`
  
- sampleDB 데이터베이스를 정의하고 생성
  - `create database sampleDB;`
  
- 컬럼으로 이름,주소,전화번호를 가지는 BusinessCard 테이블을 정의하고 생성(최대 길이 255)
  - `create table BusinessCard (Name Vachar(255), Address Varchar(255), Telephon Varchar(255));`
  
- 자료형
  - 정수형 (부호있음 / 부호없음)
    - TINYINT
    - INT
    - BIGINT
  - 실수형
    - FLOAT
    - DOUBLE
    - DECIMAL
  - 문자열
    - CHAR
    - VARCHAR
  - TEXT 문자열
    - TEXT
    - MEDIUMTEXT
    - LONGTEXT
  - BLOB
    - BLOB
    - MEDIUMBLOB
    - LARGEBLOB
  - 시간 관련
    - DATE
    - TIME
    - DATETIME
    - TIMESTAMP
    
- 제약조건
  - 입력 데이터의 제약조건을 걸어 해당되지 않는 데이터는 입력되지 않음
    - NOT NULL
    - UNIQUE
      - 동일 x
    - PRIMARY KEY
      - 기본키 제약(UNIQUE, NOT NULL 이여야함)
    - FOREIGN KEY
      - 외래키 제약
    - CHECK
      - 입력값 체크(MySQL에서는 x)
    - DEFAULT
      - 컬럼값이 입력되지 않으면 기본값 입력
    - 자동증가
      - BusinessCard의 ID 값을 자동증가되도록 지정
        - `create table BusinessCard(ID int auto_increment, name varchar(255)...)`
        - `insert into BusinessCard(Name...) // ID를 파라미터로 넣지 않아도 된다.`
      
- 중복정보 제거
  - 테이블 간의 정보는 중복되지 않아야 함
  - 이를 위해 정규화를 통해 중복성 제거
  - 중복성 제거 후 필요한 정보는 외래키를 통한 조인을 통해 필요한 정보를 구한다.
  - city 테이블의 국가코드외에 국가명을 추가할 경우 생길 문제에 대해 말하시오
    - 국가명을 south korea에서 republic of korea로 변경하려면, country 테이블의 name값과 city 테이블의 countryname 값에서 south korea를 찾아 모두 변경해야함
  
- 정규형
  - 중복을 제거하기 위한 테이블 정의 규칙
  
- 참조무결성
  - 외래키에 적용되는 규칙
  - 외래키와 참조되는 원래 테이블의 키와 관계를 명시
  - 외래키를 참조하면 원래 테이블에 해당 레코드 값이 반드시 존재해야함
  - 만약 원래 레코드를 삭제하려면 참조하는 외래키 값을 먼저 널로 만들어야함
  - city 테이블과 country 테이블과의 관계를 이용해 새로운 국가코드 zzz를 country에 추가하고 도시 yyy를 city 추가/삭제 하라
    - `insert into country(code,name) values('zzz','zzz');`
    - `insert into city(name,countrycode) values ('yyy','zzz');`
    - `delete from city where name='yyy' and countrycode='zzz';`
    - `delete from country where code='zzz' and name='zzz';`
    - 순서를 바꾸면 에러가 난다.

- 스키마 수정
  - 이미 생성된 스키마에 대해 수정할 경우 사용한다.
  - 테이블 컬럼 추가 / 삭제 /수정
    - `alter table 테이블명 add 컬렴명 데이터타입`
    - `alter table 테이블명 drop column 컬럼명`
    - `alter table 테이블명 change 컬럼명 new_컬럼명 데이터타입(컬럼명변경)`
    - `alter table 테이블명 modify 컬럼명 데이터타입 (컬럼타입변경)`
  - 기본키 제약조건 추가 / 기본키 제약조건 삭제
    - `alter table 테이블명 add primary key (컬럼명)`
    - `alter table 테이블명 drop primary key`
  - unique 제약조건 추가 / 삭제
    - `alter table 테이블명 add unique 컬럼명`
    - `alter table 테이블명 drop unique`
  - 외래키 제약조건 추가 / 삭제
    - `alter table 테이블명 add foreign key (컬럼명) references 원테이블명(원컬럼명)`
    - `alter table 테이블명 drop foreign key 컬럼명`
  - default 제약조건 추가 / 삭제
    - `alter table 테이블명 alter 컬럼명 set default 기본값`
    - `alter table 테이블명 alter 컬럼명 drop default`

- 스키마 삭제
  - 데이터베이스 삭제
    - `drop database 데이터베이스명`
  - 테이블 삭제
    - `drop table 테이블명`
      - 테이블 전체 삭제
  - `delete * from 테이블명`
    - 레코드를 일일히 하나씩 지움, 테이블 스키마는 유지
  - `truncate table 테이블명`
    - 테이블 내용만 지움, 스키마는 유지, 전용명령어
    
- 접근권한 설정
  - DCL
    - 권한 및 역할 설정하는 언어
    - 특정 테이블에 대한 CRUD 권한 설정
    - 사용자 sampleUser를 새로 하나 추가/삭제 하시오
      - `use mysql;`
      - `select user, host from user;`
      - `create user 'sampleUser'@'localhost'identified by '비밀번호';`
      - `drop user 사용자명@호스트;`
      - `flush privileges;`
    - sampleUser의 로컬 접속을 허용하시오.
      - `grant all privileges on world.* to sampleUser@localhost identified by '비밃번호';`
    - localhost의 sampleUser에게 world DB의 검색/추가권한을 부여하시오.
      - `grant select,insert world.* to sampleUser@localhost identified by '비밀번호';`
    - 모든 권한 삭제
      - `revoke all privileges on *.* from sampleUser@localhost;`

- 역할 설정
  - 역할 생성
    - `create role 역할명;`
  - 역할에 대해 권한 설정
    - `grant crud on 테이블명 to 역할명;`
  - 사용자에게 역할 부여
    - `grant 역할 to 사용자명;`
    
- 원격접속 설정
  - MySQL을 동일시스템 외에 접근가능하도록 설정
  - 사용자를 원격사용자로 등록
  - my.ini 수정(bind-address 부분 주석처리)
  - MySQL 서버 재시작
  - 방화벽 3306포트 열기
  
### SQL Advanced

- 인덱스
  - 검색을 빠르게 하기 위한 자료구조(주로 B트리계열)
    - 레코드 추가/수정/삭제시 해당 컬럼으로 다시 정렬한 후 검색에 필요한 값들을 미리 계산해 검색 속도를 높임(trade off). 업데이트는 느리지만 검색은 빠름(trade off)
    - 검색보다 추가/삭제가 빨라야 한다면??
      - 인덱스를 달지 않는다.
  - 기본키 조건을 주면 자동으로 인덱스가 설정됨.
    - 추가/삭제 할 때 마다 자동적으로 설정됨.
  - 인덱스 on/off를 통해 검색 속도 차이 체감(대량의 데이터일수록 큰 영향)
  - 조인시에도 영향을 줌
  - key가 없으면 index도 없다.

- 인덱스 설정
  - 인덱스 추가/삭제
    - `create index 인덱스명 on 테이블명(컬럼명)`
    - `create index 인덱스명 on 테이블명(컬럼명1, 컬럼명2,...)`
    - `create unique index 인덱스명 on 테이블명(컬럼명)`
      - 인덱스의 중복 방지
    - `alter table 테이블명 drop index 인덱스명`
      - 인덱스 삭제

- 메타데이터
  - 데이터를 위한 데이터
  - DB, 테이블의 스키마에 대한 정보를 저장하는 테이블
  - DB명 테이블명, 컬럼명, 사용자명, SHOW명령어의 결과값
  - 데이터 사전 : informaton_schema
    - 데이터베이스의 정보 저장
    - 시스템 카탈로그라고도 함
    - 일반적으로 읽기전용정보(Read-Only)
  데이터 디렉토리
    - DBMS의 모든 데이터가 저장되는 디렉토리
    - DB저장, 상태 및 로그저장

- 캐릭터셋
  - 문자인코딩 정보/메타데이터의 일종
  - 문자열의 값을 저장할 때 사용되는 기본정보
    - 아스키, UTF8(기본)
  - DB/테이블별로 별도 설정 가능
  - `status;`
  - `show variables like character set_system;`
  
- 콜레이션
  - 데이터를 정렬할 때 사용하는 정보
  - 정렬 시에 대소문자를 구분/비구분여부 설정
  - 한글데이터의 경우 무의미
  - `utf8-general-ci(기본값/추천)`
    - `alter database world character set utf8 collate utf8_general_ci;` 
    - create database sampleTestDB default character set utf8 collate utf8_general_ci;
    
- 스토리지 엔진
  - 데이터베이스엔진이라고도 불림
  - DBMS가 데이터를 CRUD할 때 사용하는 기본 컴포넌트
  - 대표적으로 MyLSAM과 InnoDB등이 있음
  - 데이터 접근속도/안정성/트랜잭션의 지원 여부등의 차이가 있음
  - 기본값은 InnoDB(MySQL 5.7기준)
    - InnoDB - 트랜잭션 지원/업데이트 위주/줄단위 락/복구용이/동시처리성능 높음
    - MyISAM - 상대적으로 높은 성능/읽기 위주/테이블단위 락
  
- 데이터베이스 백업  
  - 전체 데이터베이스 백업
    - `mysqldump -u아이디 -p -all-databases > 덤프파일명.sql // > : 리다이렉션`
  - 특정 디비 백업
    - `mysqldump -u아이디 -p --databases DB명 > 덤프파일명.sql`
  - 특정 테이블 백업(데이터 포함)
    - `mysqldump -u아이디 -p DB명 테이블명 > 덤프파일명.sql`
  - 스키마만 백업
    - `mysqldump -u아이디 -p--no-data...`
  - 데이터만 백업
    - `mysqldump -u아이디 -p --no-create-info...`
  
- 데이터베이스 복원
  - `mysql -u아이디 -p DB명 < 파일명`
  - `mysql -u아이디 -p < 파일명`
  - `mysql -u아이디 -p DB명 테이블명 < 파일명`
  
- 데이터베이스 로그
  - 에러로그
    - MySQL 구동과 모니터링, 쿼리 에러에 관련된 메시지를 포함
  - 일반로그
    - 전체 쿼리에 대하여 General log를 활성화 시켜서 저장 가능
      - 성능 저하
  - 슬로우 쿼리 로그
    - long_query_time에 설정된 시간 이상을 소요한 쿼리를 기록
  - 이진 로그 / 릴레이 로그
    - MySQL 쿼리를 수행하면서 쌓는 로그, 시점 복구등을 수행하는 역할
    - Replication에서 사용
    - 바이너리 로그 / 릴레이 로그에서 사용, 내용동일
    
- 데이터베이스 파티셔닝
  - VLDB(Very Large DBMS)
    - 전체 DB가 하나의 DBMS 시스템에 다 들어가기 힘들어지는 경우
      - 테이블들을 여러 개의 군으로 나눠 분산 저장
      - 하나의 테이블이 방대한 경우에는 사전방식과 같이 나눠 저장
  - 파티셔닝
    - Write 성능 증가
    - DBMS 레벨 분할
    - 제약사항
      - 테이블단위 연산이 힘들어짐(비용문제)
        - 조인 연산 어려움 -> 정규화 문제(데이터를 나눠서 필요한 것들을 뽑아 찾는다. 관계형DB)
        - 역정규화 -> 중복허용으로 해결(조인해서 알아내는 정보들을 미리 여러군데 두자)
      - 외래키의 효용문제
        - 레코드 추가시 참조무결성 조건 체크 -> 시스템 부담증가로 수동전환
        - crud시 위치를 인식해야 함
    - 이점
      - 성능 증가. 데이터 전체 검색시 필요한 부분만 탐색.
      - 파티션별 백업/복구 가능
      - 파티션 단위로 I/0 분산 가능 -> 업데이트 성능 증가. 특히 쓰기 성능 증가 (굉장히 중요)
        - DB1 : 트랜잭션 1000 서비스
        - DB2 : 1000
        - 전체 : 2000 성능이 나옴.
      - 전체 데이터를 손실할 가능성이 줆어듦 -> 가용성 향상
    - 파티셔닝 방식
      - 범위(a-m / n-r / s-z) 
        - 각각의 데이터양이 다를 수 있음
      - 해쉬
        - 데이터양을 비슷하게 나눔
      - 리스트
        - 특정한 컬럼을 기준
      - 컴포지트(위 3개를 섞음)
        - range hash / range list
    - 파티션 추가/삭제
      - `Alter TABLE BusinessCard ADD Partition(Partition p4 Values less than (2005));`
      - `Alter TABLE BusinessCard DROP Partition p4;`
    - 파티션 분할/병합
      - `Reorganize partition p3 into(partition p3 values less than(2015),partition p4 values less than maxvalue); // 분할
      - `Reorganize partition p2,p3 into(partion p23 values less than(2014)); // 병합
      
  - 샤딩
    - Wrtie 성능 증가
    - DBMS 외부에서 분할 / 응용레벨에서 구별해야 함
    - 사용자가 이를 알아야함
    - 프레임워크에서 다뤄줌

- 데이터베이스 복제
  - DBMS의 내용을 복제해 동일한 DB내용을 유지
  - 두개 이상의 DBMS 시스템을 마스터/슬레이브로 나눠 마스터 DBMS -> 슬레이브 DBMS로 SQL쿼리 복제(select 제외)
    - 데이터 업데이트(CUD)는 마스터에서
    - 읽기(R)는 슬레이브에서
  - **읽기 성능 향상**
  - 웹서버  시스템 성능확장에 적합
    - 마스터는 1개, 슬레이브는 여러개면, Read 성능이 증가함.
    - 네이버 기사보면 우리는 여러 슬레이브 중 하나의 슬레이브에서 보고, 댓글을 쓰면 마스터에서 업데이트
    - write 성능은 올라가지 않으므로, 댓글 써지는 건 지연이 걸리기도 한다.
  - 로그 기반 복제
    - statement baased
      - SQL 문장 복제, SQL에 따라 결과가 달라지는 경우(시간, UUID, ...). 마스터에 write하는 시간과 슬레이브에 write하는 시간이 다르므로 SQL을 직접 복제하면 문제가 발생
    - row based
      - SQL에 따라 변경된 라인만 기록하는 방식
      - 데이터가 많이 변경된 경우 데이터 커짐
    - mixed
      - 두 방식 복합

- Full Text Search
  - 전문검색
    - 기존 SQL의 LIKE 검색은 여러 개의 검색필터를 동시에 매칭시키는 방식
    - 여러 개의 조건문을 AND/OR 시킬 경우 심각한 성능 저하
    - 하지만 네이버/담음과 같은 포탈검색
    - 결과는 동일하지만 DB서버에 부담을 주지 않는 방식이다. 
    - 기본적으로 컬럼 내용 전체를 단순 문자열로 생각하고 검색하는 방식
    - 문자편집기의 편집 찾기/바꾸기 메뉴의 동작방식과 유사
  - 방식
    - 자연어 검색
      - 검색의 정확도 확인 as score
      - 결과는 검색의 정확도에 대한 내림차순 정렬
      - `where match(컬럼명) against('검색어/검색문장');
    - 불린 
      - 검색의 정확도에 따른 정렬이 안되고 연산자 사용한 구문 검색 가능
      - `where match(컬럼명) against('"단어*"-제외단어 in boolean mode);
    - 쿼리 확장 검색
   
- BULK Instert
  - insert의 경우 레코드를 추가한 후 내부적으로 인덱스 재구성 작업이 필요
  - 여러 개의 레코드를 넣어야 하는 경우 하나의 레코드 입력할 때 마다 이 작업이 연속적으로 발생
  - 이 문제를 해결
  - 인덱스 작업을 정지
    - `alter table '테이블명'disable keys;`
  - 인덱스 작업을 재설정
    - `alter table '테이블명'enable keys;`
  - `insert into 테이블명 values(...)values(...);`
    - 기존의 insert문에 values를 여러 번 나열한 방식
  - 파일로 덤프
    - SQL을 사용한 방식
    - CSV 파일을 사용한 방식
    - 보안 문제를 생각해야 한다
    - 인덱스 작업을 정지 시키고 복원해줘야함

- 트랜잭션
  - 복수의 SQL문을 수행하는 도중(예: 은행 간의 이체)에 장애가 발생했을 때 장애에 대응할 수 있도록 하는 기능
    - 전체 수행과 전체 취소 두가지의 결과값만 가져야함
    - 기본적으로 SQL의 수행모드는 오토커밋 모드
    - 트랜잭션을 지원하기 위해서는 오토커밋 모드를 오프시켜야 함
    - InnoDB 스토리지엔진만 가능함
  - ACID 특성
    - 원자성
    - 일관성
    - 고립성/격리수준
    - 지속성

- 락
  - 공유자원에 대해 여러 개의 트랜잭션이 접근하려고 경쟁하려고 할 때 제어하는 방법
    - 동시성제어라고 하고 보통 락으로 해결
    - 프로그래밍에서는 동기화이라고 함
  - 일관성과 무결성을 지키기 위해서 적용
  - 테이블단위 락
  - 줄단위 락
  
- 격리레벨
  - 트랜잭션에 일관성없는 데이터를 허용하는 레벨
  - 데이터의 안정성과 성능은 trade-off 관계
    - Read Uncommited
      - 트랜잭션이 처리되는 도중에 다른 트랜잭션이 해당 데이터를 읽기를 허용
      - 성능이 높지만 데이터의 안정성이 떨어짐
    - Read Commited
      - 트랜잭션이 끝난 이후에만 접근하도록 허용
    - Repeatable Read
      - 다른 트랜잭션이 업데이트하는 것은 금지하지만 레코드 추가하는 것은 허용
    - Serializable
      - 트랜잭션이 동시에 수행되는 것이 금지되고 순차적으로 순행
      - 성능 안좋음

- 저장 프로시저
  - SQL을 함수형태로 저장하고 사용하는 방법
    - 정의
    ```
      CREATE PROCEDURE 프로시저명(인자 인자형,...) RETURNS 타입
      BEGIN
        SQL문장들
      END
      ```
    - 호출
      - `CALL 프로시저명;`
    - 삭제
      - `DROP PROCEDURE 프로시저명;`

- 트리거
  - 특정한 조건이 되면 자동으로 호출되는 저장 프로시저
    - 레코드를 삭제하면 자동으로 참조무결성을 체크하는 트리거
  - 정의
  ```
  CREATE TRIGGER 트리거명 BEFORE(또는 AFTER) CRUD ON 테이블명
    FOR EACH ROW
  BEGIN
    변경 전(OLD.칼럼명) 또는 변경 후(NEW.칼럼명)을 이용한 처리
  END
  ```
  - 삭제
    - `DROP PROCEDURE 트리거명`

-대형 데이터베이스 구축기술
  - 데이터는 계속 늘어남 -> 한 대의 DBMS서버로는 처리능력의 한계
  - 성능 업그레이드
    - HDD -> SSD -> 인 메모리 머신
  - VLDB (Very Large DBMS)
    - 샤딩
      - DBMS 내용 분할
      - 쓰기 성능 향상
    - 복제
      - 동일한 DBMS를 여러 개 유지(마스터/슬레이브)
      - 읽기 성능 향상
    - 스케일업
      - 보통 말하는 업그레이드
      - CPU클럭속도 증가, 코어수 증가, 메모리 증가
      - 보통 성능증가에 비해 자격증가가 더 빠름
      - 병렬 컴퓨팅/전용 네트워크
      - Tiglely-Coupled System
    - 스케일아웃
      - 동일한 서버/DBMS를 병렬로 구축
      - 분산컴퓨팅
      - Lossely Coupled System -> 상대적으로 저렴
      - 노드 수 추가하여 계속 성능 향상 가능/효율은 상대적으로 떨어짐
      
- No SQl
  - Not Only SQL
  - 일반 RDMS가 주로 읽기/검색 성능에 최적화
  - 쓰기성능이 중요한 응용의 경우 좋은 성능을 보이는 경우가 많음
  - 로그 머신, SNS메신저 등
  - 기존 RDBMS를 완전히 대체하는 것이라기보다는 보완재의 역할
  - 특정 기술을 말하는 것이 아니라 일련의 제품군을 가리킴
  - 제품군
    - MongoDB가 시초
    - 아파치 카산드라(페이스북에 적용)
  - CAP 이론
    - C (일관성)
      - 어떤 노드를 접근하더라도 데이터값이 동일해야 한다.
    - A (가용성)
      - 노드 일부가 fail되더라도 서비스 중단이 안되야 한다.
    - P (파티션 내성)
      - 노드간 통신에 장애가 생겨도 문제가 없어야한다.
    - 어떤 시스템도 3가지 모두를 만족시킬 수 없다.
  - 저장형태에 대한 분류
    - 키/밸류
      - JSON과 유사
    - 정렬된 키/밸류
      - 키값으로 정렬되는 형태
    - 도큐먼트 형태
      - 밸류값이 JSON/XML
  - 스키마리스
    - 스키마(DDL) 기반이 아니라 필요하면 새로운 컬럼(키)를 추가하면 된다.
    - 전체적으로 동일한 구조가 아닐 수 있음
      - RDBMS - 정규형 데이터
      - NoSQL - 반정규형 데이터
      - 검색엔진 - 비정규형 데이터
