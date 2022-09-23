-- 문제가 요구하는 것 -------------------------------------
1. SELECT
    1. buyer_id / orders (아이디당 구매 건수니까 group by 필요하겠다.)
    2. join data / Users (그대로 가져오기)
    3. the number of orders in 2019 / orders → count?

- buyer_id and seller_id are foreign keys to the Users table.
    - 즉 user_id 1인 사람이 팔면 buyer_id 에 1로 적히는 거지?

1. buyer_id & join data
    1. from 두 개 테이블 or join users + orders
2. 2019년도 구매 건수 0건 포함.
    1. 2019 구매 건수 null 값도 0으로 치환
        - ifnull(seller_id, 0)
    2. 2019년도 0 포함 구매 건수 
        - count
        - = no buyer_id in 2019
        - order_date? > 2018?
    3. group by ??

-----------------------------------------------------------


우선 대충의 구조

select buyer_id, join_date, ifnull(count(buyer_id), 0)
from orders
left join users
on user_id = buyer_id
group by buyer_id



-- + 2019년 구매 건수 걸러주는 조건 추가하기.---------------
- 2019 걸러주려면 having 써야 하나?
  2019년도 order_date가 있는 사람만 뽑아서 조인해줘야 하나?
  그럼 건수가 0인 값들은 안 나오는데?
- orders in 2019 = count order_date > 2019, else 0 
   '가능한가? 안 된다고 생각했는데…'
    → 오… 가능함. 
    → sum(if(year() ~ )).
    → count(case when year ~)
- having 절로 넣어주면 안 됨.

모르겠다 ㅎ
구글링
→ count(order_date)
→ count(buyer_id) 아니라 order_id도 된다고 한다.
-----------------------------------------------------------




select buyer_id, u.join_date, ifnull(count(order_date), 0) AS orders_in_2019
from orders o
left join users u
on user_id = buyer_id and  year(order_date) > 2018
group by buyer_id

- 결과   
[[1, "2018-01-01", ~~2~~], 
[2, "2018-02-09", 2], 
[~~4, null, 1~~], 
[~~3, null, 1~~]]



-----------------------------------------------------------
? 왜 join_date가 null이지?
왜 2019 안 걸러지지??

구글링 결과 이유:
→ not buyer_id, user_id
→ join 잘못해서 2019가 안 걸러진 것.
-----------------------------------------------------------







-- 틀린 것--------------------------------------------------
    - each user = user_id, not buyer_id → 잘 이해 안 됨. 왜 buyer_id 안 되지? 그럼 group by도 user_id로 바꿔줘야 함.
    - join 기준을 잘못 잡음.

-- 틀린 것 해결하기-------------------------------------------
    - for each user = user_id 를 구하라는 말이었는데, buyer_id 구함. 그런데 사실 똑같은 거 아닌가? 왜 user_id as buyer_id 로 구해야 하는 거지???
        - buyer_id 로 하니까 2019 구매 건수가 없는 사람들의 id가 나오지 않는 구나. 구매 건수가 없는 사람들도 구해야 하고, 그 사람의 아이디가 필요한데, 구매 건수를 충족시키지 않는 사람의 id가 필요하니까 user_id구나.
        - column이 buyer_id라서 buyer_id에만 집중함. 문제 해석을 제대로 하지 않았다.
    
    - 아직 join 기준을 어떻게 잡아야 하는지 명확히 모르는 건가?
        - 우선 기준을 buyer_id로 잡았기 때문에 기준 table을 order로 잡았음. → 1. 해석의 문제
        - 구매 건수가 없는 데이터라도 가져오고 싶으므로 users table을 기준으로 해야 함. 그래야 다른 orders 테이블에서 가져올 때 2019년도 데이터만 가져올 수 있고, 2019 기준을 충족하지 못하는 사람의 데이터는 null ⇒ 0으로 처리할 수 있기 때문. → 2. 해석의 문제?
-----------------------------------------------------------