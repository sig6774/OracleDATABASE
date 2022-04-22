--�����Լ�
--ROUND(�ݿø�, �ݿø��ϰ� ���� ��ġ) ���ϴ� �ݿø� ��ġ�� �Ű������� ����
SELECT
    round(3.1254, 3),
    round(432.423, 0),
    round(45.923, - 1)
FROM
    dual;
--round�� �Լ����� �ݿø��ϰ� ���� ��ġ�� ������ �Ǹ� �����ڸ��� �ö�

--TRUNC(����, ������ ���� ��ġ) ���ϴ� ��ġ���� ���� �߶�
SELECT
    trunc(23.955, 2),
    trunc(23.955, 1),
    trunc(23.955, - 1)
FROM
    dual;

--ABS(���밪)
SELECT
    abs(23.955),
    abs(- 23.955),
    abs(0)
FROM
    dual;

--CEIL(�ø�), FLOOR(����)
SELECT
    ceil(23.95),
    floor(23.955)
FROM
    dual;

--mod(������)
SELECT
    25 / 2,
    mod(25, 2)
FROM
    dual;

--��¥ �Լ�
--sysdate �ý��ۿ� ������ ��¥�� �������
SELECT
    sysdate
FROM
    dual;

--�ڼ��� �ð� ���
SELECT
    systimestamp
FROM
    dual;

--��¥�� ������ ����
SELECT
    round(sysdate, 'month')
FROM
    dual;
--4�� 22�Ͽ��� ���� �������� ���� 22���̹Ƿ� �ݿø��� �����ؼ� 5�� 1�Ϸ� ���

--�ټ� ������ ���� �� ����(�ø� Ȱ��)
SELECT
    first_name,
    ceil(sysdate - hire_date)
FROM
    employees;

--�ټӿ����� ��, ��, ������ ���� �� ����(�ø� Ȱ��)
SELECT
    first_name,
    ceil(sysdate - hire_date)         AS day,
    ceil((sysdate - hire_date) / 7)   AS week,
    ceil((sysdate - hire_date) / 365) AS year
FROM
    employees;