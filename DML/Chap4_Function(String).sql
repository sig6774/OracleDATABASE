-- lower(�ҹ���), initcap(�ձ��ڸ� �빮��), upper(�빮��)
SELECT
    'abcDEF',
    lower('abcDEF'),
    upper('abcDEF')
FROM
    dual;
/*
dual�̶�� ���̺��� sys�� �����ϴ� ����Ŭ�� ǥ�� ���̺�μ�
���� �� �࿡ �� �÷��� ��� �ִ� dummy ���̺� 
�Ͻ����� ��� �����̳� ��¥ ���� ���� �ַ� ���
������ ����� Ȯ���ϱ� ���ؼ��� dual�� ���� Ȯ�� ����
*/

SELECT
    last_name,
    lower(last_name),
    initcap(last_name),
    upper(last_name)
FROM
    employees;

SELECT
    last_name
FROM
    employees
WHERE
    lower(last_name) = 'austin';
--lower�� ������������ ������ ���� �ɾ ���� ���� ��ȸ ����
--�̰ɷ� ��ҹ��ڿ� ���� ���� ���� ���� ��ȸ�� �� ������

SELECT
    'abcdef' AS ex,
    length('abcdef'),
    instr('abcdef', 'd')
FROM
    dual;
--length(����), instr(����, ã�� ���� ����) ������ 0�� ����, �ε��� ������ ����
--instr()�Լ��� ����� �ε��� ���� 0���� ������ �ƴ϶� 1���� �����̳�

SELECT
    first_name,
    length(first_name),
    instr(first_name, 'c')
FROM
    employees;

--SUBSTR(���ڿ�, ���۹���, ������) : ���ڿ� �ڸ���, CONCAT(���ڿ�, ���ڿ�) : ���ڿ� ��ġ��
SELECT
    'abcdef' AS ex,
    substr('abcdef', 1, 4),
    concat('abcdef', 'ghi')
FROM
    dual;

SELECT
    first_name,
    substr(first_name, 1, 4),
    concat(first_name, last_name) AS �̸���
FROM
    employees;

--LPAD, RPAD(��, ���� ���� ���ڿ��� ä��)
SELECT
    lpad('abc', 10, '$$$')
FROM
    dual;

SELECT
    rpad('abc', 10, '$$$')
FROM
    dual;

--LTRIM(����, �����ҹ���), RTRIM(����, �����ҹ���) TRIM(����, �����ҹ���) ��, ��, �翷�� �ִ� Ư�� ���� ����
SELECT
    ltrim('   Lunch    ', ' ')
FROM
    dual;

SELECT
    rtrim('   Lunch    ', ' ')
FROM
    dual;

--REPLACE(���ع��ڿ�, Ư������, �ٲܹ���) ���ڸ� �ٲٴ� �Լ� 
SELECT
    replace('MY DREAM IS AS PRESIDENT', 'PRESIDENT', 'DOCTOR')
FROM
    dual;

SELECT
    replace('MY DREAM IS AS PRESIDENT', ' ', '')
FROM
    dual;
--��������
SELECT
    replace(replace('MY DREAM IS AS PRESIDENT', 'PRESIDENT', 'DOCTOR'), ' ', '')
FROM
    dual;
--president�� doctor�� ��ȯ�� ���� �ٽ� replace�Լ��� ����ؼ� ������ ����

SELECT
    replace(replace(concat('hello ', 'world!'), '!', '?'), ' ', '')
FROM
    dual;
--hello world!�� ��ġ�� !�� ?�� �����ϰ� ���鵵 ����
