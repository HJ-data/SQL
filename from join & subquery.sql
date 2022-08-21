PROBLEM NAME: ollivander solution

### MYSQL ###

/* 

1. context
 1-1. minimum number of gold galleons needed
 1-2. each non-evil wand 

2. order by
 3-1. descending power
 3-2. descending age
 
 
3. print
 id, age, coins_needed, and power of the wands
 
*/


/*

1. FROM JOIN + SUBQUERY
   from    join
   where   condition + in

2. SUBQUERY
   from    two table
   where   condition
   
*/

1--------------------------------------------------


SELECT W.id, P.age, W.coins_needed, W.power
FROM Wands W
    JOIN Wands_Property P 
    ON W.code = P.code
WHERE P.is_evil = 0
    AND W.coins_needed in (select Min(coins_needed) 
                            from Wands w1 
                            where w1.code= P.code 
                            group by w1.power ) 
ORDER BY W.power DESC, P.age DESC;


2--------------------------------------------------


Select w.id, wp.age, w.coins_needed, w.power
From Wands w, Wands_Property wp 
where w.code = wp.code 
and w.coins_needed IN (select Min(coins_needed) 
                       from Wands w1 
                       where w1.code= wp.code 
                       and wp.is_evil=0 
                       group by w1.power ) 
order by pow desc,wp.age desc;


//


Select w.id, wp.age, w.coins_needed, w.power
From Wands w, Wands_Property wp 
where w.code = wp.code 
and wp.is_evil = 0
and w.coins_needed IN (select Min(coins_needed) 
                       from Wands w1 
                       where w1.code= wp.code 
                       group by w1.power ) 
order by power desc, wp.age desc;

--------------------------------------------------



### MYSQL SERVER ###

/* 

not MYSQL, MYSQL SERVER.
What is the reason for this query is possible only in mysql server?

*/


-- 1st query -----------------------------------------------------

WITH min_coins as (
SELECT ROW_NUMBER() OVER(PARTITION BY code, power 
                      ORDER BY code, power, coins_needed asc) as RowNumber,
        id,
        code, 
        coins_needed,
        power
from    wands
)

SELECT  id,
        age,
        coins_needed,
        power
FROM    wands_property wp
JOIN    min_coins mc 
         ON mc.code = wp.code
         AND RowNumber = 1
WHERE    is_evil=0
ORDER BY power desc, age desc
;
