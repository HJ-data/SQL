-- 전제: 입양을 갔음. 
-- from animal_outs
-- 보호기간 : 입양일 - 보호 시작일  --> 시분초 포함인가?? 
-- order by 보호기간 desc limit 2
-- print : id, name

!!! 시분초 포함이든 아니든, 결국 int - int 로 '기간'을 나타내는 게 맞음. 

!! 내가 생각했던 게
-- 보호기간 중 가장 큰 두 기간을 구하고
-- 그것을 포함하는 쿼리를 돌리자.
-- 근데 이렇게 할 필요가 없었던 거지.  
--> 위에 order by 보호기간 다 적어놨는데, 왜 서브쿼리로 돌리고 싶었을까?? 
--> o.datetime - i.datetime를 구한 값을 통합해서 따로 테이블?? 같은 걸로 설정해주고 싶었던 것 같은데. 그럴 필요 없다. 

--> 아, 내가 헷갈렸던 게 '값을 필터링하는 조건'과 '정렬의 조건'을 헷갈렸네.
--> WHERE 조건은, 필터링의 조건. 
-- 그래서 보호기간이 긴 거를 필터링으로 생각했나보다..


-- 문제를 정리했으면, 그것에 맞춰 생각을 구조화할 필요가 있다.


# SELECT o.animal_id, o.name
# from animal_outs as o, animal_ins as i
# where (select o.datetime - i.datetime
#        from animal_outs as o, animal_ins as i
#        order by o.datetime desc
#        limit 2;)


select o.animal_id, o.name
from animal_outs o
where datetime in (select o.datetime - i.datetime
                    from animal_outs as o, animal_ins as i
                    where o.animal_id = i.animal_id
                    order by o.datetime desc
                    limit 2)
;


--> 이렇게 했을 때 where 절은 조건인데, '보호기간이 길었던'을 조건으로 보고 where 절에 넣고 싶었구나.  
!!!!!! ** 근데 결국 가장 큰 값, 이런 거 구할 때는 ORDER BY + LIMIT 으로 구하면 된다고 했는데, 조건절에 왜 넣었을까.. ?ㅋㅋㅋ

--> 이렇게 조건절에서 2개 이상 반환한다는 에러 떠서

# SELECT o.animal_id, o.name
# from animal_outs as o, animal_ins as i
# where (select o.datetime - i.datetime
#        from animal_outs as o, animal_ins as i
#        )
order by o.datetime desc
limit 2;

--> ORDER BY ~ LIMIT을 밖으로 뺐지. 그래도 2개 이상 반환한다는 에러 뜸. 어쨌든 LIMIT 2니까.


결국 답은

SELECT o.animal_id, o.name
from animal_outs as o, animal_ins as i
where o.animal_id = i.animal_id        

--> INS DATETIME 값을 가져오기 위해서 FROM에 같이 INS 테이블 넣어줬고
--> 가져오는 과정에서 같은 값끼리 묶기 위해서 조건절로 ID 값 같다고 해줬고

order by o.datetime - i.datetime desc
limit 2;

--> 보호 기간이 가장 길었던 동물 두 마리
--> 범위의 조건으로 DATETIME 구하는 거니까 ORDER BY에 넣어주면 됨.
--> 



다시정리...