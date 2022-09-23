-- context : heavy users
-- print : id, name, host_id

-- 내가 생각한 것: host_id >= 2 로 카운트하면 되지 않을까?
 


1 --------------------------------------------------
SELECT id, name, host_id
FROM places
group by host_id
having count(host_id) > 1
order by id;


--> 오류
왜냐하면 host_id 로 grouping 해버리면, 그 중 1개 값만 무작위로 나옴. 
그리고 count는 select와 함께 쓸 수 있는 함수임.



2 --------------------------------------------------
SELECT id, name, host_id
FROM places
where i.c = (select count(host_id)
      from places) > 1
order by id;

where 일 때는 subquery와의 관계가 포함된 관계여야 한다. 부호가 있어야 한다는 말.


--> 오류
Unknown column 'i.c' in 'where clause'
where 절에는 임의로 설정한 column 일 수 없나보다.
from 일 경우는 테이블을 임의로 만들어주는 거고, where은 조건절이기 때문인 듯.



3 --------------------------------------------------
SELECT id, name, host_id
FROM places
where host_id = (select count(host_id)
      from places) > 1
order by id;


= 으로 해봤더니 결과값은 안 나왔으나 칼럼값들은 나옴. 


*** !!!!! group by에 대해 잘못 알고 있었다. group by를 해버리면 아이디별로 그룹핑해버리기 때문에 id가 한개씩밖에 안 나옴!!!!!!! ****
즉, group by를 하면 id 1 인 사람을 모두 1개의 행으로 묶어버리는 것.
여기서 같은 host_id 가 여러 개의 값을 가진 것을 구하고 싶은 것이지, 통합해버리고 싶은 게 아니기 때문에 group by를 쓰면 안 됨.

????????? -> subquery로 넣고 다중행 반환을 써버리면.. 여러 개 나옴...!!

즉, 뭐가 이해가 안 되냐면 
in 이 어떤 칼럼값에서 계속 비교해서 다중값 반환하는 건 이해가 되는데,
서브쿼리에서 나오는 값은 group by로 인해서 통합되어 결과가 1개의 값밖에 없는데,
이걸 서브쿼리로 놓고 in 으로 돌렸을 때는 다중값이 반환된다?? 이 흐름이 이해가 안 감. 

-- !!! 아, in 을 썼다고 해서 서브쿼리 결과값이 바깥까지 영향을 미치는 게 아니고, 거기서 목록만 차출해주는 거고, 그 목록에서 해당하는 값으로 다시 시작하는 것임!!!