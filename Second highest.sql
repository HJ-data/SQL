
/*
context: second highest salary + if X, null 


method:
1. get max
    , and except max 

2. limit & offset
    , 1, 1??

3. rank() over(order by)

*/

-- REFER
-- https://www.java67.com/2015/01/second-highest-salary-in-mysql-and-sql-server.html



--CORRECT


1-----------------------------------------

SELECT MAX(Salary) as SecondHighestSalary 
FROM Employee
WHERE Salary < (SELECT Max(Salary)
                FROM Employee);

//

select max(salary) SecondHighestSalary 
from employee 
where salary not in (select max(salary) from employee);

---------------------------------------------


2--------------------------------------------

select 
    (select distinct salary 
    from Employee 
    order by salary desc 
    limit 1 offset 1) SecondHighestSalary

//

select 
    (select distinct salary 
    from Employee 
    order by salary desc 
    limit 1, 1) SecondHighestSalary
---------------------------------------------










--WRONG becuase of the NULL
1--------------------------------------------------

SELECT salary as SecondHighestSalary
FROM employee
WHERE salary = (SELECT max(salary) 
                FROM employee
                WHERE salary
                < (SELECT max(salary)
                    FROM  employee));
-- WHAT'S THE REASON?
-- BECAUSE OF THE = ?

--------------------------------------------------



2--------------------------------------------------

SELECT salary AS SecondHighestSalary 
FROM employee
WHERE salary = (SELECT salary 
                FROM employee
                WHERE salary 
                ORDER BY salary desc 
                LIMIT 1, 1); 

//

SELECT
    (SELECT Salary
     FROM Employee
     ORDER BY Salary DESC
     LIMIT 1 OFFSET 1) AS SecondHighestSalary
;


--------------------------------------------------



3--------------------------------------------------

SELECT salary AS SecondHighestSalary
FROM (select salary, rank() over(order by salary desc) as rn
        FROM employee) rn
where rn = 2;
*/
--------------------------------------------------







