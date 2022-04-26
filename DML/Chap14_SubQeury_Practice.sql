SELECT *
FROM employees e 
WHERE e.salary > (SELECT AVG(e2.salary) FROM employees e2);

SELECT count(*)
FROM employees e 
WHERE e.salary > (SELECT AVG(e2.salary) FROM employees e2);

SELECT *
FROM employees e 
WHERE e.salary > (SELECT AVG(e2.salary) FROM employees e2 WHERE e2.job_id='IT_PROG');

SELECT
    *
FROM
    employees e
WHERE
    e.department_id = (
        SELECT
            d.department_id
        FROM
            departments d
        WHERE
            manager_id = 100
    );


SELECT *
FROM employees 
WHERE manager_id > ANY (SELECT e.manager_id 
FROM employees e 
WHERE e.first_name = 'Pat');

SELECT *
FROM employees 
WHERE manager_id = ANY (SELECT e.manager_id 
FROM employees e 
WHERE e.first_name = 'James');

SELECT
    *
FROM
    (
    
        SELECT
            ROWNUM AS num,
            tr.*
        FROM
            (
                SELECT
                    *
                FROM
                    employees e
                ORDER BY
                    e.first_name DESC
            ) tr
    )
WHERE
        num >= 41
    AND num < 50;

