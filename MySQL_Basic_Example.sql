select count(productcode) as n_products
from classicmodels.products;

select customernumber
from classicmodels.orders;

select distinct customernumber
from classicmodels.orders;

select *
from classicmodels.customers
where country="USA";

select count(orderNumber)
from classicmodels.orderdetails
where priceEach between 30 and 50;

select *
from classicmodels.orderdetails
where priceEach >=30 and priceEach<=50;

# 미국 또는 캐나다에 거주하는 고객의 주문 번호를 뽑아주세요
select*
from classicmodels.orders;

select *
from classicmodels.customers;

# 서브 쿼리로 작성한다.
select ordernumber
from classicmodels.orders
where customernumber in (select customernumber from classicmodels.customers where country='USA' or 'Canada');

# buyprice 값이
# 0 ~ 30 : low
# 30 ~ 60 : middle
# 60 ~ : high

## 위의 세가지를 만족하지 않게 되는 조건이면, 만족안하는 값은 null로 입력된다.
select buyprice,
case when buyprice between 0 and 30 then 'low'
	 when buyprice between 30 and 60 then 'middle'
	 when buyprice >=60 then 'high' 
end label # 컬럼명을 label로 변경
from classicmodels.products;

# 북미, 비북미로 나눔
select country,
case when country in ('USA','CANADA') then 'North America' Else 'Others'
end region
from classicmodels.customers;

select count(customernumber),
		count(*) # customernumber안에 null이 없으면 세지않음. *로 하면 행을 센다. 집계함수에서 null은 반영되지 않는다. sum, 최소값, 최대값 등등
from classicmodels.customers;

select sum(creditlimit),
		min(creditlimit),
		max(creditlimit),
        count(customernumber)
from classicmodels.customers;

# 집계함수

select count(ordernumber) as CUS_CNT,
		sum(priceEach) as SUM_PR,
        min(priceEach) as MIN_PR,
        max(priceEach) as MAX_PR
from classicmodels.orderdetails;

# 해당하는 컬럼의 값으로 데이터를 그룹핑을 하고 집계한다.
select ordernumber,
		sum(priceEach) as PR_SUM
from classicmodels.orderdetails
group by ordernumber;

# 각 국가별, 도시별로 그룹핑해서 각 국가의 도시에 해당하는 고객수 셈
select country,
		city, 
		count(customernumber) as CUS_CNT
from classicmodels.customers
group by country,
		city;

select productLine,
		sum(quantityInStock) as QTY_CNT,
        max(quantityInStock) as MX_QTY,
        min(quantityInStock) as MN_QTY
from classicmodels.products
group by productLine;

## having은 group by 일때 조건을 걸어준다.

select productLine,
		sum(quantityInStock) as QTY_CNT,
        max(quantityInStock) as MX_QTY,
        min(quantityInStock) as MN_QTY
from classicmodels.products
group by productLine
having sum(quantityInStock)>=30000;

## where 절은 from 밑에 들어감. where절은 from에 대해 조건을 걸 수 있다. having은 집계한 결과에 대해 조건을 건다.

## 국가별, 도시별 구매자 수 구하기

select country,
		city,
        count(distinct orders.customernumber) cnt
from classicmodels.orders
left
join classicmodels.customers
on orders.customernumber=customers.customernumber
group by country,city;


## 자주 사용되는 함수

# 1. SUBSTR 
select substr(orderdate,1,4) # orderdate 값에서 첫번째부터 4번째까지 값만 가져오고 싶다 -> 2003-01-06 이면 2003만 출력됨
from classicmodels.orders;

# 2. FLOOR # 소수점 버림
select floor(1.231); # 1로 출력

# 3. DATEDIFF # 시작 날짜와 끝나는 날짜의 차이를 구함
select datediff("2015-08-03","2020-02-11");

# 4. DATEADD # 일자에서 더하고 싶은 날짜
select date_add("2015-08-03",INTERVAL 1653 DAY);

## 순위 매기기

# row_number
select buyPrice,
		row_number() over(order by buyprice), # 동일 값도 순서를 매김. 디폴트가 오름차순
        dense_rank() over(order by buyprice), # 동일 값은 동점으로 계산하지만, 2등이 2명일때 다음 등수를 4등이라하지않고 3등이라고 한다.
        rank() over(order by buyprice) # 동일 값 동점. 2등이 2명일때, 다음 등수는 4등이a라고 한다.
from classicmodels.products;

# 그룹별 순위매기기. productline 그룹별로 순위 매김
select productline,
		buyprice,
		row_number() over(partition by productline order by buyprice) as rnk
from classicmodels.products;


## SUBQUERY 쿼리 안에 쿼리가 있는 구조

# shipped 인 구매목록에 미국 거주 고객을 left join. 미국에 거주 하지 않으면 null로 저장될 것.
select *
from 
	(select *
	from classicmodels.orders
	where status = 'Shipped') a
left
join (select *
		from classicmodels.customers
        where country='USA')b
on a.customernumber = b.customernumber;