/*
�������� 
- ����� : ()�ȿ� ��� 
  ������������ �������� 1�� ���Ͽ��� ��
- �������� ������ ���� ����� �ݵ�� �ϳ� ���� ��
- �ؼ��� ���� �������������� ���� �ؼ�
*/

--���� �� ��������
--Nancy�� �޿����� ���� ��� �˻�
SELECT
    e.first_name,
    e.salary
FROM
    employees e
WHERE
    e.salary > (
        SELECT
            salary
        FROM
            employees
        WHERE
            first_name = 'Nancy'
    );
    
--employee_id�� 103���� ����� job_id�� ������ ����� �˻�
SELECT
    *
FROM
    employees
WHERE
    job_id = (
        SELECT
            job_id
        FROM
            employees
        WHERE
            employee_id = 103
    );
    
    
    
    
    
--���� �� ��������
SELECT * FROM employees
WHERE job_id = (SELECT job_id
FROM employees
WHERE job_id = 'IT_PROG');
--��ȯ ���� 2�� �̻������� ���� �߻��� 

/* ���� �� ������
IN : ����� � ���� ������ Ȯ��
ANY : ���� ���������� ���� ���ϵ� ������ ���� ���ϸ� �ϳ��� �����ϸ� ��
ALL : ���� ���������� ���� ���ϵ� ������ ���� ���ؼ� ��� �����ؾ���
*/
--IN ������
SELECT
    *
FROM
    employees
WHERE
    job_id IN (
        SELECT
            job_id
        FROM
            employees
        WHERE
            job_id = 'IT_PROG'
    );
--IT_PROG�� ���� ���� ���� �ִ��� Ȯ���Ͽ� ��ȸ

--ANY 
--first_name�� David�� ��� �� ���� ���� ������ �޿��� ū ����� ��ȸ
SELECT
    *
FROM
    employees
WHERE
    salary > ANY (
        SELECT
            salary
        FROM
            employees
        WHERE
            first_name = 'David'
    );
--ANY : ���������� ����� ���� �ε�ȣ�� �ϳ��� �����ϸ� ��� ��ȸ 
--�̷��� �ּҰ��� ã�� �� �ְڳ�

--ALL
SELECT
    salary
FROM
    employees
WHERE
    salary > ALL (
        SELECT
            salary
        FROM
            employees
        WHERE
            first_name = 'David'
    );

--��Į�� ��������
--SELECT ������ ���������� ���� ���̸� LEFT OUTER JOIN�� ������ ���

SELECT
    e.first_name,
    d.department_name
FROM
    employees   e
    LEFT OUTER JOIN departments d ON e.department_id = d.department_id
ORDER BY
    first_name ASC;
    
SELECT
    e.first_name,
    (
        SELECT
            d.department_name
        FROM
            departments d
        WHERE
            d.department_id = e.department_id
    ) AS department_name
FROM
    employees e
ORDER BY
    first_name ASC;
    
--�� �μ��� �Ŵ��� �̸�
--LEFT OUTER JOIN
SELECT
    d.*,
    e.first_name AS �Ŵ������̵�
FROM
    departments d
    LEFT OUTER JOIN employees   e ON d.manager_id = e.employee_id
ORDER BY
    d.manager_id ASC;
    
--scalar sub query
SELECT
    d.*,
    (
        SELECT
            e.first_name
        FROM
            employees e
        WHERE
            d.manager_id = e.employee_id
    ) AS �Ŵ����̸�
FROM
    departments d
ORDER BY
    d.manager_id ASC;
/*
- ��Į�� ���������� ���κ��� ���� ��� : �Լ�ó�� �� ���ڵ�� ��Ȯ�� �ϳ��� ������ ��ȯ�� �� 
- ������ ��Į�� ������������ ���� ��� : ��ȸ�� �����Ͱ� ��뷮�� ���, �ش� �����Ͱ� ����, ���� ���� ����� ���
*/

--�� �μ��� ����� �̱�
SELECT
    d.*,
    (
        SELECT
            COUNT(e.department_id)
        FROM
            employees e
        WHERE
            d.department_id = e.department_id
        GROUP BY
            e.department_id
    ) AS �����
FROM
    departments d;

SELECT
    d.*,
    (
        SELECT
            COUNT(e.department_id)
        FROM
            employees e
        GROUP BY
            e.department_id
        HAVING
            d.department_id = e.department_id
    ) AS �����
FROM
    departments d;
    
--�ζ��� ��(FROM ������ ���������� ���°�)
--������ ���س��� ��ȸ �ڷḦ ������ �����ؼ� ������ ���� ���
SELECT employee_id, first_name, salary
FROM employees
ORDER BY salary DESC;

--ROWNUM�� �̿��Ͽ� ������ ���� �� ����
--salary�� ������ �����ϸ鼭 ROWNUM�� ���̸� ROWNUM�� ���ĵ��� �ʴ� ���� �߻�
--�ذ����� ������ �̸� ����� �ڷῡ ROWNUM�� �ٿ��� �ٽ� ��ȸ�ϴ� ���� ����

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
                    employee_id,
                    first_name,
                    salary
                FROM
                    employees
                ORDER BY
                    salary DESC
            ) tbl
    )tbl2
WHERE
        rn <= 20
    AND rn > 10;
--���� ���� SELECT������ �ʿ��� ���̺� ������ ���� 
--�ٱ��� SELECT ������ ROWNUM�� �ٿ��� �ٽ� ��ȸ 
--���� �ٱ��� SELECT �������� �̹� �پ��ִ� ROWNUM�� ������ �����ؼ� ��ȸ
--������� : FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY

SELECT tt.name, tt.* FROM 
(SELECT TO_CHAR(TO_DATE(test, 'YY/MM/DD'), 'MMDD') as mm, name FROM
(SELECT
    'ȫ�浿'      AS name,
    '20211126' AS test
FROM
    dual
UNION ALL
SELECT
    '��ö��',
    '20210301'
FROM
    dual
UNION ALL
SELECT
    '�ڿ���',
    '20210401'
FROM
    dual
UNION ALL
SELECT
    '��ǻ�',
    '20210501'
FROM
    dual
UNION ALL
SELECT
    '�ڶѶ�',
    '20210601'
FROM
    dual
UNION ALL
SELECT
    '���׽�Ʈ',
    '20210701'
FROM
    dual)) tt
WHERE mm = '0401';