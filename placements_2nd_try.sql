
CONTEXT:
- SELECT
    names of students
    - student’s salary < best friend’s salary (no same salay)
- order by salary of best friends

Table:
students - ID & name
Friends - ID & Friend_ID
Packages - ID & Salary 

Solution I guess
1. students + packages → A (join?)
2. Friends + packages → B (join)
3. A + B (join) → result 


---------------------------------------------------------
Solution of 1

select s.ID, Name
from students s, packages p
where s.ID = p.ID
```OR```
select s.ID, Name, Salary
from students s
left join (select ID, Salary
						from packages p)
on s.ID = p.ID
---------------------------------------------------------

---------------------------------------------------------
solution of 2
---------------------------------------------------------
select f.ID, friend_ID, salary
from friends f
left join packages p
on f.friend_ID = p.ID
---------------------------------------------------------

---------------------------------------------------------
solution of 3
---------------------------------------------------------
select s.ID, Name, Salary
from students s
left join packages p
on s.ID = p.ID
andw
left join (select f.ID, friend_ID, salary
            from friends f
            left join packages p
            on f.friend_ID = p.ID) b
on s.ID = b.ID
---------------------------------------------------------


FAIL

`ERROR 1064 (42000) at line 1: You have an error in your--------------------------------------------------------- syntax; check the manual that corresponds to your M--------------------------------------------------------- server version for the right syntax to use near 'where s.ID = p.ID and a.ID = s.ID' at line 7`

I realized that I don’t know how to join multiple tables, and I was looking for it. multiple join doesn’t need AND, it means just connect join in forms of ‘join on join on’.

 
used right forms of multiple join.


---------------------------------------------------------
select *
from students s
	join packages p
	on s.ID = p.ID
	join Friends f
	on s.ID = f.ID
	join packages p
on f.friend_ID = p.ID
---------------------------------------------------------


+ add condition to get names of students whose salary < best friend’s salary

→ where p.salary < p1.salary??

---------------------------------------------------------
select *
from students s
    join packages p
    on s.ID = p.ID
    join Friends f
    on s.ID = f.ID
    join packages p1
    on f.friend_ID = p1.ID
where p.salary < p1.salary

---------------------------------------------------------

+ add condition to order by friends’ salary and value as a result.

---------------------------------------------------------
select name
from students s
    join packages p
    on s.ID = p.ID
    join Friends f
    on s.ID = f.ID
    join packages p1
    on f.friend_ID = p1.ID
where p.salary < p1.salary
order by p1.salary
---------------------------------------------------------


SUCCESS.

What I learned.
multiple join doesn’t need AND, it means just connect join in forms of ‘join on join on’.