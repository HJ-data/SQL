-- 코드를 입력하세요

-- ------------------------------------------------------
-- 방법 1 요거트, 우유 동시
-- 1) and은 한 행에 두 값이 나와야 하기 때문에 안 됨. 그럼 조인인가보다
-- 2) yogurt인 값 and milk인 값 합치기 
-- 검색 결과 join은 맞다는데?

 # join은 뭐가 틀린 거지???
 # on 조건절에 cart_id 가 아니라 id를 넣어서 틀림.. 왜 틀리는 거지???

-- ------------------------------------------------------
-- 방법 2. 서브쿼리로 써도 됌. (where문에 M, Y 해당하는 CART_ID AND로 묶는거)

1 ---------------------------------------------------------------
SELECT cart_id
from cart_products cp
where cp.name in (select cp.name
                from cart_products cp2
                where cp.name = 'yogurt')
order by cart_id

-- 이렇게 하면 요거트는 나오는데, 왜 and milk를 붙이면 안 나오지?? 
-- 이름이 요거트인 것의 name을 구하고 그 네임을 가진 아이디를 구함.
-- 여기서 and name milk를 해버리면 네임이 milk 네임 + 네임이 yogurt인 네임이 구해져서 공통값을 구할 수 없음.
-- !! 그러나 yogurt 네임을 가진 cart_id를 구하고 그 cart_id 중에 milk 네임을 가진 값을 구하라는 식으로 구하면 가능함. 

--> 
SELECT cart_id
from cart_products
where cart_id in (select cp2.cart_id
                from cart_products cp2
                where cp2.name = 'yogurt')
    and name = 'milk'
order by cart_id

---------------------------------------------------------------

SELECT cp.cart_id
from cart_products cp
join cart_products cp2
on cp.id = cp2.id
where cp.name = 'yogurt'
and cp2.name = 'milk'
order by cp.cart_id;

-- inner join 하는 게 아닌가...?
??????? on 조건절에 cart_id 가 아니라 id를 넣어서 틀림.. 왜 틀리는 거지???


SELECT cp.cart_id
from cart_products cp
join cart_products cp2
on cp.id = cp2.id
where cp.name = 'yogurt'
and cp2.name = 'milk'
order by cp.cart_id;

--!!!!!!!!!! 한 행에 yogurt, milk 로 들어가야 하기 때문에!
-- 그렇지만 or을 넣으면 yogurt는 구매했으나 milk는 없는 등의 행도 구해진다..
-- 그럼 어떻게 하지?





--- 제일 간단!!
select cart_id
from cart_products
where name in ('milk', 'yogurt')
group by cart_id
having count(distinct name) = 2;
milk, milk milk, yogurt, yogurt yogurt, milk yogurt 에서 중복 제거하고 2개만 남기면 milk yogurt만 남음.






-- group_concat cart_id가 같은 경우 이름을 모두 한 행에 붙여줌. 

select cart_id
from (select cart_id, group_concat(name) names
      from cart_products
      group by cart_id) A 
where names like '%Milk%' and names like '%yogurt%';











