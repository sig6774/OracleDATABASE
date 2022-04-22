--�׷��Լ� AVG, MAX, MIN, SUM, COUNT 

SELECT
    COUNT(*)
FROM
    employees
WHERE
    job_id = 'IT_PROG';

SELECT
    job_id,
    round(AVG(salary), 0) AS ��ձ޿�,
    round(MAX(salary), 0),
    round(MIN(salary), 0),
    round(SUM(salary), 0),
    COUNT(salary)
FROM
    employees
WHERE
    salary >= 5000
GROUP BY
    job_id
ORDER BY
    ��ձ޿� DESC;
    
SELECT
    COUNT(*)
FROM
    employees;

SELECT
    COUNT(first_name)
FROM
    employees;

SELECT
    COUNT(commission_pct)
FROM
    employees;
/* commission_pct�� null���� �ִ� �÷��̹Ƿ� 
'null�� ���� ����ִ�'��� ���̹Ƿ� count���� ���� */



SELECT
    COUNT(commission_pct)
FROM
    employees
WHERE
    commission_pct IS NOT NULL;

SELECT
    department_id,
    trunc(AVG(salary)) AS ��ձ޿�
FROM
    employees
GROUP BY
    department_id
ORDER BY
    ��ձ޿� DESC;
/*select�� �׷��Լ��� ����� �÷��� �ƴ� �Ϲ� �÷��� ������ GROUP BY �ؾ� ��ȸ ����
��, �׷��Լ��� �Ϲ� �÷��� ���ÿ� �׳� ����� �� ���� */

SELECT
    job_id,
    department_id,
    trunc(AVG(salary))
FROM
    employees
GROUP BY
    department_id,
    job_id;
--�׷��Լ��� ����� �� ���� �Ϲ� �÷��� 1�� �̻� ���� �Ϲ� �÷��� GROUP BY�� ���� ����� 

--HAVING
SELECT department_id, SUM(salary)
FROM employees
GROUP BY department_id
HAVING SUM(salary) > 100000;
/* WHERE���� group�Լ��� ���� GROUPBY���� ���� ������ �����ϱ� ������ ������ ��
�׷��� ������ HAVING�� �Ἥ �׷�ȭ ���� ������ �ɾ��� */

SELECT
    job_id,
    COUNT(job_id),
    count(*)
FROM
    employees
GROUP BY
    job_id
HAVING
    COUNT(job_id) >= 20;
--job�� �ٹ��ϴ� ���� ���� 20�� �̻� �϶� ��ȸ

--�μ� ���̵� 50�̻��� �͵��� �׷�ȭ ��Ű��, �׷� ���� ��� �� 5000�̻� ��ȸ 
SELECT
    department_id,
    AVG(salary)
FROM
    employees
GROUP BY
    department_id
HAVING department_id >= 50
       AND AVG(salary) >= 5000
ORDER BY
    department_id ASC;
    
SELECT
    department_id,
    AVG(salary)
FROM
    employees
WHERE
    department_id >= 50
GROUP BY
    department_id
HAVING
    AVG(salary) >= 5000
ORDER BY
    department_id ASC;