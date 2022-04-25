/* ���� 1
��� ���̺��� JOB_ID �� ��� ���� ���ϼ��� 
��� ���̺��� JOB_ID �� ������ ����� ���ϼ���. ������ ��� ������ �������� ���� */

SELECT
    job_id,
    COUNT(job_id),
    AVG(salary)
FROM
    employees
GROUP BY
    job_id
ORDER BY
    AVG(salary);

/* ���� 2
��� ���̺��� �Ի� �⵵ �� ��� ���� ���ϼ��� */

SELECT
    to_char(hire_date, 'YY'),
    COUNT(hire_date)
FROM
    employees
GROUP BY
    to_char(hire_date, 'YY');

/* ���� 3 
�޿��� 8000�̻��� ������� �μ��� ��� �޿��� ����ϼ���. �� �μ� ��� �޿��� 2000�̻��� �μ��� ��� */

SELECT
    department_id,
    trunc(AVG(salary))
FROM
    employees
WHERE
    salary >= 8000
GROUP BY
    department_id
HAVING
    AVG(salary) >= 2000;

/* ����4
��� ���̺��� commission_pct �÷��� null�� �ƴ� ������� �μ���, ���� ��� �հ�, count�� ���� 
����1 ������ ����� Ŀ�̼��� �����Ų ���� 
����2 ����� �Ҽ� 2° �ڸ����� ���� */

SELECT
    department_id,
    TRUNC((AVG(salary +(salary * commission_pct))), 2) AS ���,
    SUM(salary +(salary * commission_pct)) AS ��,
    COUNT(*) AS ��
FROM
    employees
WHERE
    commission_pct IS NOT NULL
GROUP BY
    department_id;