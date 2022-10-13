

CONTEXT:
- number of order
 + delivered to courier but not completed 
 + during a month of January 2017.

additional context
when parcel doesn’t arrive to cusomer, arrive time is recorded in ‘order_delivered_carrier_data’ column, but there is null in ‘order_delivered_customer_date’.


Group by 
arrive date to courier
Order by 
arrive date to courier in ascending order
Set column
arrive date as delivered_carrier_date → use ‘date()’ function
number of orders as orders


----------------------------------------------------------------
select date(order_delivered_carrier_date) as delivered_carrier_date, order_delivered_customer_date as orders
from olist_orders_dataset
where order_delivered_carrier_date is not null and order_delivered_customer_date is null
group by 1
order by 1
----------------------------------------------------------------


Add the condition, which is for a month of Jan 2017.


-------------------------------------------------------------
select date(order_delivered_carrier_date) as delivered_carrier_date, order_delivered_customer_date as orders
from olist_orders_dataset
where order_delivered_carrier_date is not null and order_delivered_customer_date is null
and date(order_delivered_carrier_date) between '2017-01-01' and '2017-01-31'
group by 1
order by 1
------------------------------------------------------------


테스트 케이스를 통과하지 못했습니다!
정답 데이터의 1번째 컬럼 delivered_carrier_date와 쿼리 결과의 1번째 컬럼 delivered_carrie_date가 다릅니다.


I realized that ‘arrived to the courier, but not completed’ means the number of order literally. How can I count number of ‘Null’? COUNT function? CASE WHEN?


fail serveral times.
I searched the way to count null value, and I try to use coun
t(*).


-------------------------------------------------------------
select 
	date(order_delivered_carrier_date), count(*)
from 
	olist_orders_dataset
where 
	order_delivered_customer_date is null 
	and date(order_delivered_carrier_date) between '2017-01-01' and '2017-01-31'
group by 1
-------------------------------------------------------------


Faill.. need to sepecify to get value instead of count(*)? 


-------------------------------------------------------------
select 
	date(o.order_delivered_carrier_date)
	, count(o.order_delivered_customer_date)
from
	olist_orders_dataset o
join
	(select o2.order_delivered_carrier_date, o2.order_delivered_customer_date
	from olist_orders_dataset o2
	where o2.order_delivered_customer_date is null) A
on o.order_delivered_carrier_date = A.order_delivered_carrier_date
where
	date(o.order_delivered_carrier_date) between '2017-01-01' and '2017-01-31'
group by 1
order by date(o.order_delivered_carrier_date)
------------------------------------------------------------


테스트 케이스를 통과하지 못했습니다!
정답 데이터의 1번째 컬럼 delivered_carrier_date와 쿼리 결과의 1번째 컬럼 count(o.order_delivered_customer_date)가 다릅니다.


I selected easy level problem, but it’s not easy not at all for me….. 
Back to the first, I try to get all result of the number of order data 


-------------------------------------------------------------
select date(order_delivered_carrier_date), count(*)
from olist_orders_dataset
where date(order_delivered_carrier_date) between '2017-01-01' and '2017-01-31'
group by date(order_delivered_carrier_date)-------------------------------------------------------------


add the null condition 


-------------------------------------------------------------
select date(order_delivered_carrier_date), order_delivered_customer_date
from olist_orders_dataset
where date(order_delivered_carrier_date) between '2017-01-01' and '2017-01-31'
and order_delivered_customer_date is null
group by
order by date(order_delivered_carrier_date);
-------------------------------------------------------------


-------------------------------------------------------------
select date(order_delivered_carrier_date) as delivered_carrier_date, count(*) as orders
from olist_orders_dataset
where date(order_delivered_carrier_date) between '2017-01-01' and '2017-01-31'
and order_delivered_customer_date is null
group by date(order_delivered_carrier_date)
-------------------------------------------------------------


Success….

정답 데이터의 1번째 컬럼 delivered_carrier_date와 쿼리 결과의 1번째 컬럼 count(o.order_delivered_customer_date)가 다릅니다.
→ It means COLUMN, NOT COLUMN VALUE
→ That’s why I fail again and again…


What I learned. 
how to count to NULL value.