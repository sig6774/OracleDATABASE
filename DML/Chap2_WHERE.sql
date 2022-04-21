SELECT
    salary
FROM
    employees
WHERE
    salary > 5000;

SELECT
    first_name,
    last_name,
    job_id
FROM
    employees
WHERE
    job_id = 'IT_PROG';

SELECT
    *
FROM
    employees
WHERE
    last_name = 'King';

SELECT
    *
FROM
    employees
WHERE
    department_id = 90;

SELECT
    *
FROM
    employees
WHERE
    salary >= 15000;

SELECT
    *
FROM
    employees
WHERE
    hire_date = '04/01/30';

--������ �� ���� (BETWEEN, IN, LIKE)
SELECT
    *
FROM
    employees
WHERE
    salary BETWEEN 15000 AND 20000;

SELECT
    *
FROM
    employees
WHERE
    hire_date BETWEEN '03/01/01' AND '03/12/31';

--IN�������� ��� (Ư�� ����� ���� �� ���)
SELECT
    *
FROM
    employees
WHERE
    manager_id IN ( 100, 101, 102 );

SELECT
    *
FROM
    employees
WHERE
    job_id IN ( 'IT_PROG', 'AD_VP' );
/*LIEK ������ 
%�� ����, _�� �������� ��ġ�� ã�Ƴ� �� */

SELECT
    first_name,
    hire_date
FROM
    employees
WHERE
    hire_date LIKE '03%';
--hire_date�� 03���� �����ϴ� �� ��� �� ��ȸ

SELECT
    first_name,
    hire_date
FROM
    employees
WHERE
    hire_date LIKE '%15';
--hire_date�� 15�� ������ �� ��� �� ��ȸ

SELECT
    first_name,
    hire_date
FROM
    employees
WHERE
    hire_date LIKE '%05%';
--hire_date�� �� �ڰ� 05�� �ִ� ��� �� ��ȸ

SELECT
    first_name,
    hire_date
FROM
    employees
WHERE
    hire_date LIKE '___05%';
--4,5��°���� 05�� �����ϰ� ���� �ڿ��� ��� X, ���⼭�� 5���� �����ϴ� �� ��ȸ

--IS NULL (null���� ã�� ��)
SELECT
    *
FROM
    employees
WHERE
    manager_id IS NULL;
-- manager_id�� null�� ���� ��ȸ

SELECT
    *
FROM
    employees
WHERE
    commission_pct IS NULL;
-- commission_pct�� null�� ���� ��ȸ

SELECT
    *
FROM
    employees
WHERE
    commission_pct IS NOT NULL;
-- commission_pct�� null�� �ƴ� ���� ��ȸ

-- AND, OR 
-- AND�� OR ���� ��������� �켱
SELECT
    *
FROM
    employees
WHERE
    job_id = 'IT_PROG'
    OR job_id = 'FI_MGR'
    AND salary >= 6000;
-- IT_PROG �̰ų� FI_MGR�� ����� ������ 6000�̻��� ����� ��ȸ�ϱ� ������ 6000�̻��� �ƴ� ����� ��ȸ

SELECT
    *
FROM
    employees
WHERE
    ( job_id = 'IT_PROG'
      OR job_id = 'FI_MGR' )
    AND salary >= 6000;
-- ������� : salary�� 6000�̻����� �Ÿ��� job_id�� FI_MGR�̰ų� IT_PROG�̰ų�

-- ������ ���� (SELECT ������ ���� �������� ��ġ)
-- ASC(�������� ����, �⺻��) DESC(�������� ����)

SELECT
    *
FROM
    employees
ORDER BY
    hire_data ASC;

SELECT
    *
FROM
    employees
WHERE
    job_id = 'IT_PROG'
ORDER BY
    first_name ASC;
--�������̵� IT_PROG�� ����� first_name�� A���� ���� ���� ���������� ����

SELECT
    *
FROM
    employees
WHERE
    salary >= 5000
ORDER BY
    employee_id DESC;
--������ 5õ�� �Ѵ� ��� �� �����ȣ�� ū ������ ���������� ����

SELECT
    first_name,
    salary * 12 AS ����
FROM
    employees
ORDER BY
    ���� DESC;