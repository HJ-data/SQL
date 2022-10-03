---------------------------------------------------------------
Brazilian E-Commerce Public Dataset by Olist 데이터셋은 브라질의 이커머스 웹사이트인 Olist Store의 판매 데이터 입니다. 그 중 olist_orders_dataset 테이블에는 주문 ID, 고객 ID, 주문 상태, 구매 시각 등 주문 내역 데이터가 들어있습니다. olist_order_payments_dataset 테이블에는 주문 ID, 결제 방법, 결제 금액 등 각 주문의 결제와 관련된 정보가 저장되어 있습니다. 두 테이블을 이용해 2018년 1월 1일 이후 일별로 집계된 쇼핑몰의 결제 고객 수, 매출액, ARPPU를 계산하는 쿼리를 작성해주세요.

ARPPU는 Average Revenue Per Paying User의 약자로, 결제 고객 1인 당 평균 결제 금액을 의미합니다. 전체 매출액을 결제 고객 수로 나누면 ARPPU를 계산할 수 있습니다.

주문 각각에 대해 매출이 일어나는 시점은 olist_orders_dataset 테이블의 order_purchase_timestamp 컬럼에 기록되고, 주문 금액은 olist_order_payments_dataset 테이블의 payment_value 컬럼에 기록됩니다.

쿼리 결과는 아래 네 개의 컬럼을 포함해야 하고, 매출 날짜 기준으로 오름차순 정렬되어 있어야 합니다. 매출액과 ARPPU는 반올림 해 소수점 둘째자리까지 출력해주세요.

dt - 매출 날짜 (예: 2018-01-01)
pu - 결제 고객 수
revenue_daily - 해당 날짜의 매출액
arppu - 결제 고객 1인 당 평균 결제 금액


-- 문제가 원하는 것--
select 매출날짜, 결제 고객 수, 해당 날짜의 매출액, ARPPU(1인 당 평균 결제 금액 = 결제 고객 수 / 전체 매출액)를 계산
+ round(매출액 ARPPU, 2)
from olist_orders_dataset o, olist_order_payments_dataset op
where 2018년 1월 1일 이후
group by 일별로 집계된
order by 매출 날짜 기준으로 오름차순 정렬
---------------------------------------------------------------



해당 날짜의 매출액은 총 매출액이겠지?
ARPPU 스칼라쿼리로 빼야 하나?



-- 대충의 쿼리
select date(order_purchase_timestamp), count(o.order_id), round(sum(payment_value), 2), round(o.order_id / sum(payment_value))
from olist_orders_dataset o, olist_order_payments_dataset op
where date(order_purchase_timestamp) >= '2018-01-01'
group by date(order_purchase_timestamp)
order by date(order_purchase_timestamp)
-- limit 200
-- (쿼리 실행이 오래 걸려서 임의로 추가)
--


결과
Looks like the database engine is taking to long to respond, please try again in a while.
흠..




select date(order_purchase_timestamp)
from olist_orders_dataset o, olist_order_payments_dataset op
where date(order_purchase_timestamp) > '2018-01-01'
group by date(order_purchase_timestamp)
order by date(order_purchase_timestamp)
limit 5
--> 이것도 오래 걸리는데..?










