-- datetime 에서 시간만 추출해서 group by 해서 order 시간순?



-- 1 ----------------------------------------------------------- 

-- 시간만 어떻게 추출하지?? --!!! month()구나!!!!  -> 근데 그게 문자열에도 통하는 문법인가? -> 되네?!

SELECT hour(datetime) as hour, count(datetime) as count
from animal_outs
group by hour(datetime) 
order by datetime;






-- 2 -----------------------------------------------------------

-- 09~19까지만 어떻게 가져오지?? between 09 and 19 쓰니까 왜.. 값이 7과 11만 나오지?
-- 숫자와 문자열의 차이인가?? 
-- 그럼 문자열은 < = > 와 같이 부호를 사용하면 되는 건가??

SELECT hour(datetime) as hour, count(datetime) as count
from animal_outs
group by hour(datetime) 
having hour(datetime) < 20 and hour(datetime) >=9
order by datetime;

-- 처음에 having을 씀. 
-- Unknown column 'datetime' in 'having clause' error 발생.
-- group by를 hour(datetime) 으로 해서 having 에도 썼는데 having은 오직 table 의 column 만 가능한 건가??0 
-- where 로 바꿔봄. 


SELECT hour(datetime) as hour, count(datetime) as count
from animal_outs
where hour(datetime) < 20 and hour(datetime) >=9
group by hour(datetime) 
order by datetime;


-- 3 -----------------------------------------------------------

-- 마지막.. 문자열 order는 어떻게 하지? -- 구글링해보니 숫자로 바꾸라고 함. cast?? 
-- 근데 안 됨..

SELECT hour(datetime) as hour, count(datetime) as count
from animal_outs
where hour(datetime) < 20 and hour(datetime) >=9
group by hour(datetime) 
order by CAST(datetime AS SIGNED);



-- datetime 이 문자열이라는 것에 꽂혀서 수로 변환하고 정렬하려고 했는데
-- 애초에 그냥 hour(datetime) 자체가 시간만 빼주는 거였고 그 시간에서 정렬할 수 있구나!!!!!



SELECT hour(datetime) as hour, count(datetime) as count
from animal_outs
where hour(datetime) < 20 and hour(datetime) >=9
group by hour(datetime) 
order by hour(datetime);