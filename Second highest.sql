
/*
context: second highest salary + if X, null 


method:
1. get max
    , and except max 

2. limit & offset
    , 1, 1??

3. rank() over(order by)

*/



1--------------------------------------------------

SELECT salary as SecondHighestSalary
FROM employee
WHERE salary = (SELECT max(salary) 
                FROM employee
                WHERE salary
                < (SELECT max(salary)
                    FROM  employee));

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







