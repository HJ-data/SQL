-- 들어온 날짜를 어떻게 일자까지만 뽑지??
-- left, substring, substr 차이를 모르겠다.


SELECT animal_id, name, substr(datetime, 1, 10)
from animal_ins
order by animal_id;


SELECT animal_id, name, left(datetime, 10)
from animal_ins
order by animal_id;


-- !!!!
-- substr(datetime, 1, 10) 처음부터 10번째 자리까지
-- left(datetime, 7) 처음부터 7번째 자리까지

-- 그리고 2017-04-13 16:29:00 에서 이미 - 나 : 등 기호를 통해서 연결했기 때문에 neumeric 이 아니라 string이다. 그래서 datetime에 ' 를 붙여줄 이유가 없다.