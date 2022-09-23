쿼리 2개를 짜야 하는 문제

-- 첫 번째 쿼리가 요구하는 것--------------------------------------------
    1. order by name asc
    2. select : name, first letter of profession
-- 두 번째 쿼리가 요구하는 것--------------------------------------------
    1. There are total of (the number of occurrences / occupation) s.
    2. order by occupation_count asc, occupation asc
------------------------------------------------------------------------



첫 번째 쿼리

------------------------------------------------------------------------
-- 칼럼 값에서 가장 첫번째 글자만 가져오는 것?
→ SUBSTR 사용 가능한가?
→ LEFT?
------------------------------------------------------------------------


// 조건: first letter of profession + name asc //

SUBSTR(’occupation’, 1, 1)
substr(), left() 에서 칼럼명에 ‘’ 를 붙여서 문자열을 만들어버려서 틀림.

select name, substr(occupation, 1, 1)
from occupations
order by name;



------------------------------------------------------------------------
-- 괄호로 씌워서 가져오는 건 어떻게 하지?
함수가 있나?
어떻게 검색해야 할지도 모르겠다.
우선 pass

-- 설마 이것도 CONCAT?
------------------------------------------------------------------------
`'SUBSTR' is not a recognized built-in function name.`

구글링: 괄호로 값을 출력하는 법.
❗ substr 이 built-in 라서 안 되면 left 를 넣으면 된다.

select name, concat('(', left(occupation, 1), ')')
from occupations
order by name;

틀림. 왜?

-- name 을 concat 안에 안 넣어서… 띄어쓰기가 안 맞아서 틀렸다고 한다..
------------------------------------------------------------------------





두 번째 쿼리


------------------------------------------------------------------------
// 조건 There are total of (the number of occurrences / occupation) s. //

문장을 출력하되, 해당값을 넣은 문장을 출력하는 방법을 구해야 할 듯.
Q1. sql에서 원하는 문장을 출력하게끔 하는 방법이 뭐지? s까지 넣어줘야겠다.
Q2. () 안의 것은 보통의 쿼리처럼 뽑아내면 될 듯?

select count(occupation) AS occupation_count, occupation
from occupations
group by occupation
order by count(occupation), occupation
------------------------------------------------------------------------

이제 문장 안에 넣으면 되는데...

구글링
→ || ' ' ||   →  안 됨. 
→ CONCAT


❗ CONCAT 시험 삼아 해봤더니
select CONCAT('There are a total of', count(occupation), 's')
from occupations
결과: 'There are a total of18s'


------------------------------------------------------------------------
-- 이제 합치면 되겠다. 어떻게?
1. WITH로 임시 테이블 만들어 놓고 시작해도 될 것 같기도 하고
2. count(occupation) 자리에 만들어 놓은 쿼리를 넣고 싶은데 가능한가? → 안 됨.

CONCAT이라는 함수를 사용해야 하는 건 알겠는데, 쿼리값으로 도출해야 하는 occupation_count, occupation을 어떻게 넣어야 할지 모르겠다.
------------------------------------------------------------------------

구글링.

------------------------------------------------------------------------
❗ select에 들어갈 값만 concat 안에 넣어줘도 되는 구나.
     소문자 조건도 빼먹음. 소문자 조건은 lower


select CONCAT('There are a total of ', count(occupation), occupation, 's')
from occupations
group by occupation
order by count(occupation), occupation

3와 Doctor 사이를 띄우고 싶은데

❗ ‘ ‘ 로 공백을 삽입해주면 되는구나
------------------------------------------------------------------------


------------------------------------------------------------------------
+ 소문자 조건까지 + s 뒤의 .까지

select CONCAT('There are a total of ', count(occupation), ' ', lower(occupation), 's.')
from occupations
group by occupation
order by count(occupation), occupation
------------------------------------------------------------------------ 



--정답-------------------------------------------------------------------
select concat(name, '(', left(occupation, 1), ')')
from occupations
order by name;

select CONCAT('There are a total of ', count(occupation), ' ', lower(occupation), 's.')
from occupations
group by occupation
order by count(occupation), occupation;
------------------------------------------------------------------------