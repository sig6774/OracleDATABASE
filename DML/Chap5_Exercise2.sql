/* ���� 1
    EMPLOYEES ���̺��� �̸�, �Ի����� �÷��� �����ؼ� �̸������� �������� ����մϴ�.
    ����1) �̸� �÷��� first_name, last_name�� �ٿ��� ����մϴ�.
    ����2) �Ի����� �÷��� xx/xx/xx�� ����Ǿ� �ֽ��ϴ�. xxxxxx���·� �����ؼ� ����մϴ�.
*/
SELECT
    first_name
    || ' '
    || last_name                AS �̸�,
    replace(hire_date, '/', '') AS �Ի�����
FROM
    employees
ORDER BY
    �̸� ASC;

SELECT
    concat(first_name, last_name) AS �̸�,
    replace(hire_date, '/', '')   AS �Ի�����
FROM
    employees
ORDER BY
    �̸� ASC;

/* ���� 2 
    EMPLOYEES ���̺��� phone_number �÷��� ###.###.###���·� ����Ǿ� �ִ�
    ���⼭ ó�� ���ڸ� ���� ��� ���� ������ȣ(02)�� �ٿ� ��ȭ ��ȣ�� ����ϵ��� ������ �ۼ��ϼ���.
*/
SELECT
    replace(phone_number, substr(phone_number, 1, 3), '(02)') AS ��ȭ��ȣ
FROM
    employees;
    
SELECT
    concat('(02)', substr(phone_number, 4, length(phone_number))) AS phone_number
FROM
    employees;

/* ���� 3
    EMPLOYEES ���̺��� JOB_ID�� it_prog�� ����� �̸�(first_name)�� �޿�(salary)�� ����ϼ���
    ����1. ���ϱ� ���� ���� �ҹ��ڷ� �Է�
    ����2. �̸��� �� 3���ڱ��� ����ϰ� �������� *�� ��� �̿��� ��Ī�� name
    ����3. �޿��� ��ü 10�ڸ��� ����ϵ� ������ �ڸ��� *�� ����մϴ�. �̿��� �� ��Ī�� salary�Դϴ�
    */
SELECT
    rpad(substr(first_name, 1, 3), length(first_name), '*') AS name,
    lpad(salary, 10, '*')                                   AS salary
FROM
    employees
WHERE
    lower(job_id) = 'it_prog';