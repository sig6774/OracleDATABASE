/*
���� 1 
employee�� departments ���̺��� INNER, LEFT OUTER, RIGHT OUTER, FULL OUTER �����ϼ���
*/
SELECT
    *
FROM
         employees e
    INNER JOIN departments d ON e.department_id = d.department_id;
-- 106���� ���� ���� 

SELECT
    *
FROM
    employees   e
    LEFT OUTER JOIN departments d ON e.department_id = d.department_id;
-- 107���� ���� ����

SELECT
    *
FROM
    employees   e
    RIGHT OUTER JOIN departments d ON e.department_id = d.department_id;
-- 122���� ���� ����

SELECT
    *
FROM
    employees   e
    FULL OUTER JOIN departments d ON e.department_id = d.department_id;
--123���� ���� ����

/*
����2 
employee, department ���̺��� inner join�ϼ���
����1 employee_id�� 200�� ����� �̸�, department_id��� 
����2 �̸� �÷��� first_name�� last_name�� ���ļ� ��� 
*/
SELECT
    e.first_name || e.last_name,
    d.department_id
FROM
         employees e
    INNER JOIN departments d ON e.department_id = d.department_id
WHERE
    e.employee_id = 200;

/*
����3 
employee, job ���̺��� inner join�ϼ��� 
��� ����� �̸��� �������̵�, ���� Ÿ��Ʋ�� ����ϰ� �̸� �������� �������� ���� 
*/
SELECT
    e.first_name,
    e.job_id,
    j.job_title
FROM
         employees e
    INNER JOIN jobs j ON e.job_id = j.job_id
ORDER BY
    e.first_name ASC;

/*
����4 
job, job_history ���̺��� left outer join�ϼ���
*/
SELECT
    *
FROM
    jobs        j
    LEFT OUTER JOIN job_history jh ON j.job_id = jh.job_id;

/*
����5
Steven King�� �μ����� ����ϼ���
*/
SELECT
    e.first_name || e.last_name,
    d.department_name
FROM
         employees e
    INNER JOIN departments d ON e.department_id = d.department_id
WHERE
        e.first_name = 'Steven'
    AND e.last_name = 'King';

SELECT
    e.first_name || e.last_name,
    d.department_name
FROM
    employees   e
    LEFT OUTER JOIN departments d ON e.department_id = d.department_id
WHERE
        e.first_name = 'Steven'
    AND e.last_name = 'King';

/*
����6 
employee, departments ���̺��� cartesian product(CROSS JOIN)ó���ϼ���
*/
SELECT
    *
FROM
         employees e
    CROSS JOIN departments d;

/*
���� 7 
����� �μ� ���̺��� �μ���ȣ�� �����ϰ� SA_MAN ������� �����ȣ, �̸�, �޿�, �μ���, �״����� ����ϼ���
*/
SELECT
    e.employee_id AS �����ȣ,
    e.first_name AS �̸�,
    e.salary AS �޿�,
    d.department_name AS �μ��̸�,
    d.location_id AS ������ȣ,
    L.state_province AS �����̸�
FROM
    employees   e
    LEFT OUTER JOIN departments d ON e.department_id = d.department_id
    LEFT OUTER JOIN locations L ON d.location_id = l.location_id
WHERE
    e.job_id = 'SA_MAN';
    
/*
����8 
employees, job ���̺��� ���� �����ϰ� job_title�� 'Stock Manager', 'Stock Clerk'�� ���� ������ ����ϼ���
*/
SELECT e.first_name, e.last_name, e.salary, j.job_title
FROM employees e LEFT OUTER JOIN jobs j ON e.job_id = j.job_id
WHERE j.job_title = 'Stock Manager' or j.job_title = 'Stock Clerk';

/*
����9
�μ� ���̺��� ������ ���� �μ��� ã�� ����ϼ���.
*/
--manager_id�� ������ ������ �����Ƿ� manager_id�� ��ȸ
SELECT count(*)
FROM departments d LEFT OUTER JOIN employees e ON d.department_id = e.department_id
WHERE d.manager_id IS NULL;


/*
����10
join�� �̿��ؼ� ����� �̸��� �� ����� �Ŵ��� �̸��� ����ϼ���
*/
SELECT e1.first_name, e2.first_name
FROM employees e1 INNER JOIN employees e2 ON e1.manager_id = e2.employee_id;

/*
����11
���� ���̺��� left join�Ͽ� �Ŵ��� �̸�, �Ŵ��� �޿����� ����ϼ���. 
*/
SELECT DISTINCT e2.first_name, e2.salary
FROM employees e1 LEFT OUTER JOIN employees e2 ON e1.manager_id = e2.employee_id
WHERE e1.manager_id IS NOT NULL
ORDER BY e2.salary DESC;

