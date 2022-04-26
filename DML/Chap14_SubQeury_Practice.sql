SELECT
    *
FROM
    employees e
WHERE
    e.salary > (
        SELECT
            AVG(e2.salary)
        FROM
            employees e2
    );

SELECT
    COUNT(*)
FROM
    employees e
WHERE
    e.salary > (
        SELECT
            AVG(e2.salary)
        FROM
            employees e2
    );

SELECT
    *
FROM
    employees e
WHERE
    e.salary > (
        SELECT
            AVG(e2.salary)
        FROM
            employees e2
        WHERE
            e2.job_id = 'IT_PROG'
    );

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

SELECT
    *
FROM
    employees
WHERE
    manager_id > (
        SELECT
            e.manager_id
        FROM
            employees e
        WHERE
            e.first_name = 'Pat'
    );

SELECT
    *
FROM
    employees
WHERE
    manager_id IN (
        SELECT
            e.manager_id
        FROM
            employees e
        WHERE
            e.first_name = 'James'
    );

SELECT
    *
FROM
    (
        SELECT
            ROWNUM AS num,
            tr.first_name
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
    AND num <= 50;

SELECT
    *
FROM
    (
        SELECT
            ROWNUM AS rn,
            tbl.*
        FROM
            (
                SELECT
                    e.employee_id,
                    e.first_name,
                    e.phone_number,
                    e.hire_date
                FROM
                    employees e
                ORDER BY
                    e.hire_date ASC
            ) tbl
    )
WHERE
        rn > 30
    AND rn <= 40;

/*
���� 6 
���� ���̺� �μ� ���̺��� left �����ϼ��� 
- ���� ���̵�, �̸�(��, �̸�), �μ����̵�, �μ��� ��� 
- ���� ���̵� ���� �������� ����
*/

SELECT
    e.employee_id,
    e.first_name || e.last_name,
    d.department_id,
    d.department_name
FROM
    employees   e
    LEFT OUTER JOIN departments d ON e.department_id = d.department_id
ORDER BY
    e.employee_id DESC;

/*
���� 7
���� 6�� ����� ��Į�� ������ �����ϰ� ��ȸ 
*/
SELECT
    e.employee_id,
    e.first_name || e.last_name,
    e.department_id,
    (
        SELECT
            d.department_name
        FROM
            departments d
        WHERE
            e.department_id = d.department_id
    ) AS �μ��̸�
FROM
    employees e
ORDER BY
    e.employee_id DESC;

/*
���� 8
departments ���̺� locations ���̺��� left �����ϼ���
- �μ��ƾƵ�, �μ��̸�, �Ŵ����ƾƵ�, �����̼� ���̵�, ��Ʈ�� ��巹�� ,����Ʈ �ڵ�, ��Ƽ�� ���
- �μ����̵� ���� �������� ����
*/
SELECT
    d.department_id,
    d.department_name,
    d.manager_id,
    d.location_id,
    l.street_address,
    l.postal_code,
    l.city
FROM
    departments d
    LEFT OUTER JOIN locations   l ON d.location_id = l.location_id
ORDER BY
    d.department_id ASC;

/*
���� 9
���� 8�� ����� ��Į�� ������ �����ϰ� ��ȸ 
*/
SELECT
    d.department_id,
    d.department_name,
    d.manager_id,
    d.location_id,
    (
        SELECT
            l.street_address
        FROM
            locations l
        WHERE
            d.location_id = l.location_id
    ) AS �����ּ�,
    (
        SELECT
            l.postal_code
        FROM
            locations l
        WHERE
            d.location_id = l.location_id
    ) AS postal_code,
    (
        SELECT
            l.city
        FROM
            locations l
        WHERE
            d.location_id = l.location_id
    ) AS ����
FROM
    departments d
ORDER BY
    d.department_id ASC;
--������ �ξ� ����

/*
���� 10 
locations ���̺� countries ���̺��� left �����ϼ���
- �����̼� ���̵�, �ּ�, ��Ƽ, ���� ���̵�, ���� �̸��� ��� 
- ���� �̸� ���� �������� ���� 
*/
SELECT
    l.location_id,
    l.street_address,
    l.postal_code,
    l.city,
    c.country_id,
    c.country_name
FROM
    countries c
    LEFT OUTER JOIN locations l ON l.country_id = c.country_id
ORDER BY
    c.country_name;


/*
���� 11
���� 10�� ����� ��Į�� ������ �����ϰ� ��ȸ
*/
SELECT
    l.location_id,
    l.street_address,
    l.postal_code,
    l.city,
    (
        SELECT
            c.country_id
        FROM
            countries c
        WHERE
            l.country_id = c.country_id
    ) AS ������̵�,
    (
        SELECT
            c.country_name
        FROM
            countries c
        WHERE
            l.country_id = c.country_id
    ) AS �����̸�
FROM
    locations l
ORDER BY
    �����̸�;  

--���� 12
SELECT
    *
FROM
    (
        SELECT
            ROWNUM AS num,
            tt.*
        FROM
            (
                SELECT
                    e.employee_id,
                    e.first_name,
                    e.phone_number,
                    e.hire_date,
                    d.department_id,
                    d.department_name
                FROM
                    employees   e
                    LEFT OUTER JOIN departments d ON d.department_id = e.department_id
                ORDER BY
                    e.hire_date ASC
            ) tt
    )
WHERE
        num > 0
    AND num <= 10;   

--���� 13 
SELECT
    e.last_name,
    e.job_id,
    e.department_id,
    d.department_name
FROM
    employees   e
    LEFT OUTER JOIN departments d ON e.department_id = d.department_id
WHERE
    e.job_id = 'SA_MAN';
    
SELECT
    d.department_name,
    tbl.*
FROM
         (
        SELECT
            last_name,
            job_id,
            department_id
        FROM
            employees
        WHERE
            job_id = 'SA_MAN'
    ) tbl
    JOIN departments d ON tbl.department_id = d.department_id;
    
--���� 14
SELECT
    *
FROM
         departments d
    JOIN (
        SELECT
            department_id,
            COUNT(*) AS total
        FROM
            employees
        GROUP BY
            department_id
    ) groupa ON groupa.department_id = d.department_id
ORDER BY
    groupa.total DESC;
--GROUPBY�� ���� ���� �ۼ��ϰ� ���� ������ ���� ���ϴ� ���� ������ groupby �� ���� �ٸ� ���� ��ȸ����

--���� 15
SELECT
    d.*,
    loc.street_address,
    loc.postal_code,
    nvl(groupemp.result, 0)
FROM
         departments d
    INNER JOIN locations loc ON d.location_id = loc.location_id
    LEFT JOIN (
        SELECT
            department_id,
            trunc(AVG(salary)) AS result
        FROM
            employees
        GROUP BY
            department_id
    )         groupemp ON d.department_id = groupemp.department_id;
--�켱 �ȿ� ���� ������������ ���� �ۼ�(���⼭ �׷�ȭ)�ϰ� �����Ͽ� ������ ���� ���
