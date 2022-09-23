문제:
1. 우유와 요거트를 동시에 구입한 장바구니의 아이디를 조회
2. 아이디 순

방법
1. self join + group by + distinct & milk, yogurt인 것 → 가능한가??
2. name like %milk% → 이럴 경우 or 로 하되 count > 1 ?

output 
1. select cart_id 
2. from cart_product
3. where
4. order by cart_id



### 1번 방법

select cp1.cart_id
from cart_products cp1
join cart_products cp2
on cp1.cart_id = cp2.cart_id
where cp1.name in ('Milk', 'Yogurt')
group by cp1.cart_id
having count(distinct cp1.name) > 1
order by cp1.cart_id;

오 맞았다.

이것도 가능하다고 한다.

select cp1.cart_id
from cart_products cp1
join cart_products cp2
on cp1.cart_id = cp2.cart_id
where cp1.name = 'milk' and cp2.name = 'Yogurt'
group by cp1.cart_id
order by cp1.cart_id;

### 2번 방법

select cart_id
from cart_products
where name like 'Milk' or 'Yogurt'
group by cart_id
having count(name) > 1
order by cart_id

실패..