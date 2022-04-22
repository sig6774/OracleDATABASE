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
FROM
    employees;
--commission�� �޴� ����� ���� �ʴ� ����� ������ �� ����