-- 전제: 입양을 갔음. 
-- from animal_outs
-- 보호기간 : 입양일 - 보호 시작일  --> 시분초 포함인가??
-- order by 보호기간 desc limit 2
-- print : id, name

-- 보호기간 중 가장 큰 두 기간을 구하고
-- 그것을 포함하는 쿼리를 돌리자.
-- 근데 이렇게 할 필요가 없었던 거지??  --> 위에 order by 보호기간 다 적어놨는데, 왜 서브쿼리로 돌리고 싶었을까?? --> o.datetime - i.datetime를 구한 값을 통합해서 따로 설정해주고 싶었던 것 같은데. 그럴 필요 없다. 
-- 문제를 정리하면, 그것에 맞춰 생각을 구조화할 필요가 있다.

-- 보호 기간이 길었던 동물 
-- => 몇 일 이상 -> where
-- => 가장 긴 -> order by + limit


SELECT o.animal_id, o.name
from animal_outs as o, animal_ins as i
where o.animal_id = i.animal_id        
order by o.datetime - i.datetime desc
limit 2;