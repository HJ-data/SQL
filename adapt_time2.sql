-- 없는 값의 행을 어떻게 만들지??? 값이 5-12면, 0-24를 표현하게 어떻게 만들지?????
-- set 으로 변수를 지정해주라고 한다...

-- SET 왜 -1 ? SELECT 구문에서 +1이기 때문에 시작을 0으로 하기 위해서.
-- 

# SET @HOUR = -1;
# SELECT @HOUR := @HOUR + 1 AS HOUR
#         (SELECT HOUR(DATETIME), count(datetime)
#         from animal_outs
#         group by hour(datetime)
#         )       
# FROM ANIMAL_OUTS;

-- 이게 왜 틀렸냐면, set 으로 처음 @hour를 -1 로 설정해주고, select 에서 결과값은 0으로 시작하는 hour 값을 이미 만들어냈음. 즉, 이게 hour(datetime)과 같은 값이라는 말
-- 그럼 이제 count(hour(datetime))를 만들어내야 하는데 

# SET @HOUR = -1;
# SELECT @HOUR := @HOUR + 1 AS HOUR,
#       (SELECT COUNT(*)
#        FROM ANIMAL_OUTS
#        WHERE @HOUR = HOUR(DATETIME))-- 여기서 변수를 다시 지정해준다는 말인 건지..?
# FROM ANIMAL_OUTS;

-- @hour = hour(datetime)을 했을 때... 
-- @hour 는 수가 0부터 돌아가긴 하는데, 나타내는 의미는 hour(Datetime)과 같다는 의미인가??
-- 즉, outs 테이블에서 hour(datetime)이 @hour 과 같다고 했을 때, count(*) 모든 경우의 수를 구해라
-- 그리고 



########
WHERE @HOUR = HOUR(DATETIME))-- 여기서 변수를 다시 지정해준다는 말인 건지..??? 
--> 가져올 때 같은 값끼리 매칭시켜준다는 의미지!



# SET @HOUR = -1;
# SELECT @HOUR := @HOUR + 1 AS HOUR,
#       (SELECT COUNT(*)
#        FROM ANIMAL_OUTS
#        WHERE @HOUR = HOUR(DATETIME))
# FROM ANIMAL_OUTS;

-- 그리고 python처럼 a = a+1 이면 무한대로 가기 때문에 변수의 범위도 지정해줘야 함.
-- where @hour < 23 이렇게.


SET @HOUR = -1;
SELECT @HOUR := @HOUR + 1 AS HOUR,
      (SELECT COUNT(*)
       FROM ANIMAL_OUTS
       WHERE @HOUR = HOUR(DATETIME))
FROM ANIMAL_OUTS
where @hour < 23;

-- <= 해버리면, 24까지 나옴!!! hour = hour +1 이니까!

 @ 붙여주면, 계속 쓰고 싶다, 는 의미.
:= 반복 구동이 된다.







-- 문제 풀이
-- 다른 방법 union 사용

with recursive base_h as (select 0 as hour
               union all
               select hour + 1 from base_h where hour < 23 )
select hour, count(animal_id) 
from base_h left join animal_outs o
    on hour = hour(o.datetime)
group by hour
order by hour


-- recursive 제기함수라서 while 문이랑 비슷하다고 생각하면 됨.

-- from dual = 함수값을 리턴할 때 쓰는 것임.