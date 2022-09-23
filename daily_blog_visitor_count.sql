solvesql


-- 문제-------------------------------------------------------
    - 날짜 + 방문자수
    - 방문자 기준: 로그 데이터에 event 1 이상 → 조건
    - 기간: 2021-08-02 ~ 2021-08-09  → 조건 between?
    - 일별로 추출 → group by 일별
    
    - output
        - select : dt(일별), count(user_pseudo_id)
        - group by date(event_date_kst)
        - ordery by date(event_date_kst)
--------------------------------------------------------------

-- 생각-------------------------------------------------------
1. select : dt(일별), count(user_pseudo_id)
    1. date as dt, count(disctinct user_pseudo_id)
2. 기간: 2021-08-02 ~ 2021-08-09 
    1. between?
    2. 
3. 문자 기준: 로그 데이터에 event 1 이상 
    1. 해당 날짜에 id 1개 이상 되면 되는 거 아닌가? 중복 지우고
4. 일별이 뭐더라..
    1. date 이용하면 되나?
    2. SUBSTR 도 가능하구나
    3. reg_dt 는 뭐지?
    4. 
--------------------------------------------------------------


대충 틀

select event_date_kst AS dt, count(distinct user_pseudo_id) AS users
from ga
where event_date_kst between 2021-08-02 and 2021-08-09
and count(distinct user_pseudo_id) > 0
group by event_date_kst



--------------------------------------------------------------
당연히 오답
틀렸는데 뭐가 틀렸는지 안 알려주니까 더 어렵다
구글링
→ having을 사용하네?
where 절에 있는 조건을 having으로 옮겨야 하나?

-> date에 '' 씌우고 해봤는데 misuse of aggregate: count()라고 뜸. 
아, 집계함수라서 안 되는 구나.
아직 좀 헷갈리는 것 같다.
--------------------------------------------------------------



select event_date_kst AS dt, count(distinct user_pseudo_id) AS users
from ga
where event_date_kst between 2021-08-02 and 2021-08-09
group by event_date_kst
having count(date(event_timestamp_kst)) > 0



--------------------------------------------------------------
쿼리 결과 없음.
로그 테이블에 event 1 이상  → 이 기준 설정이 잘못된 건가?
--------------------------------------------------------------



select event_date_kst AS dt, count(distinct user_pseudo_id) AS users
from ga
where event_date_kst between 2021-08-02 and 2021-08-09
group by event_date_kst
having count(date(event_timestamp_kst)) > 0



--------------------------------------------------------------
무엇이 문제인지 알기 위해 하나씩 삭제해보기로 함.
--------------------------------------------------------------



select event_date_kst AS dt, count(distinct user_pseudo_id) AS users
from ga
where event_date_kst between 2021-08-02 and 2021-08-09



--------------------------------------------------------------
결과  0… count(distinct user_pseudo_id) 가 잘못되었나???
--------------------------------------------------------------



select event_date_kst AS dt
from ga
where event_date_kst between 2021-08-02 and 2021-08-09



--------------------------------------------------------------
결과 없음. 
??
2021-08-02에 ‘’ 표시 안 해줘서 틀림 ㅎㅎ
date 형식에도 ‘’ 해줘야 한다..ㅎ
--------------------------------------------------------------



정답:

select event_date_kst AS dt, count(distinct user_pseudo_id) AS users
from ga
where event_date_kst between '2021-08-02' and '2021-08-09'
group by event_date_kst
having count(date(event_timestamp_kst)) > 0