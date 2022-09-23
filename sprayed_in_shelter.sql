-- what i've thought


SELECT o.animal_id, o.animal_type, o.name
FROM animal_outs as o
join (SELECT animal_id, animal_type, name
FROM animal_ins as i
where i.sex_upon_outcome != 중성화) intact
on i.animal_id = o.animal_id
where o.sex_upon_outcome = 중성화
order by o.animal_id

-- 중성화 어떻게 표현하지?
-- $ 이런 거 넣어야 하나?? ex 'intact$' ->  다 외울 수 없는데 항상 serching 해야 하나??
-- 다른 방법 없나??


-- 대박.. 중성화를 'intact'이라는 중성화 아닌 걸로 바꿨다가
-- 의미가 정반대로인 단어로 바꿨는데, 부호도 안 바꿔서, 즉 != 과 = 도 안 바꿔서.. 오류남..ㅋㅋㅋㅋㅋ
-- 내가 짠 코드는 맞았나봐. 행벅해..



- 1. join
SELECT o.animal_id, o.animal_type, o.name
FROM animal_outs as o
join (SELECT *
FROM animal_ins as i
where i.sex_upon_intake like 'intact%') as i
on i.animal_id = o.animal_id
where o.sex_upon_outcome not like 'intact%'
order by o.animal_id;


- 2. where
SELECT o.animal_id, o.animal_type, o.name
FROM animal_outs as o, animal_ins as i
where i.animal_id = o.animal_id
and i.animal_id in (SELECT animal_id
FROM animal_ins as i
where i.sex_upon_intake like 'intact%')
and o.sex_upon_outcome not like 'intact%'
order by o.animal_id;

SELECT o.animal_id, o.animal_type, o.name]
FROM animal_outs as o, animal_ins as i
where i.animal_id = o.animal_id
and i.sex_upon_intake like 'intact%'
and o.sex_upon_outcome not like 'intact%'
order by o.animal_id;


3. 그 외
SELECT o.animal_id, o.animal_type, [o.name]
FROM animal_outs as o, animal_ins as i
where i.animal_id = o.animal_id
and i.sex_upon_intake != o.sex_upon_outcome;