select Name, Grade, Marks
from studendts, Grades
where grade > 7 
order by grade desc, name

select translate(name, name, 'NULL'), Grade, Marks
from students, Grades
where grade < 8
order by marks asc;


--> 이 두가지를 합치면 되지 않을까?


select Name, Grade, Marks
from studendts, Grades (select translate(name, name, 'NULL'), Grade, Marks
                        from students, Grades
                        where grade < 8
                        order by grade desc, marks asc;) as t
where grade > 7
order by grade desc, name;


--> 안 됨. 


--> 구글링 : CASE WHEN 을 써라??