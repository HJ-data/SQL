-- 코드를 입력하세요

-- context : list 3 of animal in animal_ins -> no animal_id, NAME!
--           datetime
-- 1. from join
-- 2. where join, subquery
-- 3. other ways: row_number, top 

-- but 2, 3 isn't proper to get set difference, relative complement

1------------------------------------------

SELECT i.name, i.datetime  
from animal_ins as i
left join animal_outs as o
on i.animal_id = o.animal_id
where o.animal_id is null
order by datetime asc
limit 3;

------------------------------------------