-- ���� ������
-- union(������ �ߺ�X), union all(������ �ߺ�O), minus(������), intersect(������)
-- ���ϰ��� �ϴ� table�� ��, �Ʒ� column ������ ��Ȯ�ϰ� ��ġ�ؾ���

SELECT
    employee_id,
    first_name
FROM
    employees
WHERE
    hire_date LIKE '04%'
UNION
SELECT
    employee_id,
    first_name
FROM
    employees
WHERE
    department_id = 20;
--�ΰ��� ��ȸ ������ ���ļ� ��ȸ ����� ������� ������ UNION�� �ߺ��� ����� ������ 

SELECT
    employee_id,
    first_name
FROM
    employees
WHERE
    hire_date LIKE '04%'
UNION ALL
SELECT
    employee_id,
    first_name
FROM
    employees
WHERE
    department_id = 20;
--�ߺ� ���

SELECT
    employee_id,
    first_name
FROM
    employees
    
WHERE
    hire_date LIKE '04%'
INTERSECT
SELECT
    employee_id,
    first_name
FROM
    employees
WHERE
    department_id = 20;
--�� ��ȸ ���� ������� �������� ��ġ�� �κ��� ���

SELECT
    employee_id,
    first_name
FROM
    employees
WHERE
    hire_date LIKE '04%'
MINUS
SELECT
    employee_id,
    first_name
FROM
    employees
WHERE
    department_id = 20;
--���� ��ȸ���� �������� ������ ������ ����