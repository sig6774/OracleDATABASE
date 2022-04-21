-- ���� �ּ�
/*
������ �ּ� */

/*  employees�� �ִ� ��� �����͸� ����
    SELECT �÷���(������ ����) FROM ���̺� �̸�; */
SELECT * FROM EMPLOYEES;

SELECT employee_id, first_name, last_name FROM employees;
--Ư�� �÷����� �̸��� ���� ���������� ��ȸ����

SELECT
    employee_id,
    first_name,
    last_name,
    salary,
    salary + salary*0.1
FROM employees;
--�÷��� ��ȸ�ϴ� ��ġ���� ��Ģ���� ���� 

SELECT department_id, commission_pct
FROM employees;
--null : '�����Ͱ� ����'�� ���̸� ���� 0�̳� �����̶��� �ٸ� ���̰� '�����Ͱ� ����ִ�'��� ���� ����

SELECT first_name as �̸�, last_name as ��, salary as �޿�
FROM EMPLOYEES;
--alias or as�� ���� ��ȸ�� �� �÷� or ���̺� ��Ī�� �ٸ��̸����� �ٿ��� ��ȸ�� �� ����

/* sql������ ���ڿ��� ������ �� ||�� ����ϸ� 
    '����Ͽ� ���ο� ���ڿ��� �߰��� �� ���� */
    
SELECT 
FIRST_NAME || '' || LAST_NAME || '''s salary is $' || SALARY as �޿�����
FROM EMPLOYEES;

SELECT DISTINCT DEPARTMENT_ID FROM EMPLOYEES;
--DISTINCT : ��ȸ�� �� �ߺ��� �����Ͽ� ���

/*  ROWNUM ROWID
    (�߿�)ROWNUM : Query�� ���� ��ȯ�Ǵ� �� ��ȣ ���
    ROWID : DB���� ���� �ּҰ��� ��ȯ */
SELECT ROWNUM, ROWID, EMPLOYEE_ID
FROM EMPLOYEES;

SELECT SALARY 
FROM employees
WHERE department_id = 80;

SELECT
    job_id,
    SUM(salary),
    AVG(salary)
FROM
    employees
GROUP BY (
    job_id
)
ORDER BY
    AVG(salary) DESC;
-- ctrl + f7�� ������ �ٰ������� �������ִ� SQL���� �ۼ� ���� 


