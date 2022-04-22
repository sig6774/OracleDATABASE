-- �� ��ȯ
-- TO_CHAR(), TO_NUMBER(), TO_DATE()

--��¥�� ���ڷ� TO_CHAR(��, ����)
SELECT
    to_char(sysdate)
FROM
    dual;

SELECT
    to_char(sysdate, 'dd/mm/yy')
FROM
    dual;

SELECT
    to_char(sysdate, 'YYYY-MM-DD HH:MI:SS')
FROM
    dual;

SELECT
    to_char(sysdate, 'YY-MM-DD HH24:MI:ss')
FROM
    dual;
--TO_CHAR�� ���ؼ� ��¥�� ���ڿ��� ��ȯ�ϰ� ���� ���ϴ� ���Ĵ�� �ٲ� �� ����

SELECT
    first_name,
    to_char(hire_date, 'YY"��"-MM"��"-DD"��"')
FROM
    employees;
--TO_CHAR()�� ���� ���Ĺ��ڿ� ""�� ���� ���� ������ �� ����

--���ڸ� ���ڷ� ��ȯ
SELECT
    to_char(3094, '99999')
FROM
    dual;
    
--���ڸ� �ڸ���(9~~)�� �°� ���ڿ��� ��ȯ 
SELECT
    to_char(3094.34, '99999.999')
FROM
    dual;
    
--�Ǽ��� ���� 
SELECT
    to_char(3094, '9,999')
FROM
    dual;
--���ϴ� ��Ĵ�� ���� ����

SELECT
    to_char(salary, 'L99,999') AS salary
FROM
    employees;

--���ڸ� ���ڷ� TO_NUMBER(��, ����) 
SELECT
    '2000' + 2000
FROM
    dual; -- �ڵ� �� ��ȯ 
--�ڵ����� ����ȯ�� �����Ͽ� 4000�� ���

SELECT
    to_number('2000') + 2000
FROM
    dual; -- ����� �� ��ȯ 

SELECT
    to_number('$3,300', '$9,999') + 2000
FROM
    dual;
--���ڷ� ��ȯ�� �� ���� ���ڴ� ���Ŀ� �����Ͽ� �־��ָ� ���ڷ� ��ȯ ����

--���ڸ� ��¥�� ��ȯ�ϴ� �Լ� TO_DATE(��, ����)
SELECT
    to_date('2021-11-25')
FROM
    dual;

--DATE�� ������ ���������� ���ڸ� ��¥�� ��ȯ�ؼ� ������ ���� ����
SELECT
    ceil(sysdate - to_date('2021-11-25'))
FROM
    dual;

--���ڿ��� ������ ��¥�� ���ϴ� DATE�������� ��ȯ����
--�־��� ���ڿ��� ��� ��ȯ�ؾ� ��
SELECT
    TO_DATE('2020/12/25', 'YY-MM-DD')
FROM
    dual;

SELECT
    TO_DATE('2021-03-31 12:23', 'YYYY-MM-DD HH:MI')
FROM
    dual;

/* xxxx�� xx�� xx�� ���ڿ� �������� ��ȯ�� ������.
��ȸ �÷����� dateInfo�� �ϰڽ��ϴ�. */
SELECT
    TO_CHAR(TO_DATE('20050102', 'YYYY MM DD'), 'YYYY"��" MM"��" DD"��"') AS datainfo
FROM
    dual;

--null ���� �Լ� NVL(�÷�, ��ȯ�� ��)
SELECT
    first_name,
    nvl(commission_pct, 0)
FROM
    employees;
--commission_pct�� �ִ� null���� 0���� ��ȯ 

SELECT
    first_name,
    nvl(to_char(commission_pct), '�ǳ��� ������')
FROM
    employees;
-- NVL()�� ���� �÷��� ���� ���ڸ� ��ȯ�� ���� �����̰� �÷��� ���� ���ڸ� ��ȯ ���� ���ڷ� �������

--null �����Լ� NVL2(�÷�, null�� �ƴ� ��� ��, null�� ��� ��)
SELECT
    first_name,
    nvl2(to_char(commission_pct), '��~ �ǳ��� ����', '�ǳ��� ������~')
FROM
    employees;
SELECT
    first_name,
    nvl2(commission_pct, 'TRUE', 'FALSE')
--    ���� ������(exp ? a : b)�� ����
FROM
    employees;
--commission�� �޴� ����� ���� �ʴ� ����� ������ �� ����
SELECT
    first_name,
    commission_pct,
    nvl2(commission_pct, salary +(salary * commission_pct), salary) AS real_salary
FROM
    employees
ORDER BY REAL_SALARY DESC;
--commission_pct�� null�� �ƴ� ����� commission�� ������ salary�� �����ְ� null�̸� �׳� salary������



--DECODE(�÷� Ȥ�� ǥ����, �׸�1, ���1, �׸�2, ���2, ... default)
SELECT DECODE('A', 'A', 'A�Դϴ�.', 'B', 'B�Դϴ�', '�𸣰ھ��')
FROM dual;

SELECT
    job_id,
    salary,
    decode(job_id, 'IT_PROG', salary * 1.1, 'FI_MGR', salary * 1.2,
           'AD_VP', salary * 1.3, salary) AS result
FROM
    employees;
    
--CASE WHEN THEN END
SELECT
    first_name,
    job_id,
    salary,
    (
        CASE job_id
            WHEN 'IT_PROG'    THEN
                salary * 1.1
            WHEN 'FI_MGR'     THEN
                salary * 1.2
            WHEN 'FI_ACCOUNT' THEN
                salary * 1.3
            WHEN 'AD_VP'      THEN
                salary * 1.4
            ELSE
                salary
        END
    ) AS result
FROM
    employees
ORDER BY
    result DESC;
    
    
    
/* ����1
�������ڸ� �������� EMPLOYEE���̺��� �Ի����ڸ� �����ؼ� �ټӳ���� 15�� �λ��� ����� 
������ ���� ������ ����� ����ϵ��� ������ �ۼ��ϼ���.
���� 1) �ټӳ���� ���� ��� ������� ����� �������� �մϴ�.
*/
SELECT
    employee_id                        AS �����ȣ,
    concat(first_name, last_name)      AS �����,
    hire_date                          AS �Ի�����,
    trunc((sysdate - hire_date) / 365) AS �ټӳ��
FROM
    employees
WHERE
    ( sysdate - hire_date ) / 365 >= 15
ORDER BY
    �ټӳ�� DESC;
--WHERE�� ALISA���� ������ ��ȸ�� �ȵ� 
--�ֳ��ϸ� SQL�� ������ FROM -> WHERE�� ����Ǳ� ������ SELECT���� ALISA�� ���� �ν����� ����
--ORDER BY���� ������ ������ �� �������� ����Ǳ� ����(SELECT����)

/* ����2
EMPLOYEE ���̺��� manager_id �÷��� Ȯ���Ͽ� first_name, manager_id, ������ ����մϴ�. 
department_id�� 50�� ������� ������θ� ��ȸ�մϴ�.
*/
SELECT
    first_name,
    manager_id,
    (
        CASE manager_id
            WHEN 100 THEN
                '���'
            WHEN 120 THEN
                '����'
            WHEN 121 THEN
                '�븮'
            WHEN 122 THEN
                '����'
            ELSE
                '�ӿ�'
        END
    ) AS ����
FROM
    employees
WHERE
    department_id = 50;
    
SELECT
    first_name,
    manager_id,
    decode(manager_id, 100, '���', 120, '����',
           121, '�븮', 122, '����', '�ӿ�') AS ����
FROM
    employees
WHERE
    department_id = 50;
