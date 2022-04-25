/*
�����̶� 
- ���� �ٸ� ���̺��� �������� ���谡 �����Ͽ� 
  1�� �̻��� ���̺��� �����͸� ��ȸ�ϱ� ���� ���
- SELECT �÷�����Ʈ FROM ���δ���� �Ǵ� ���̺� (1�� �̻�)
  WHERE ���� ���� (����Ŭ ���� ����)
*/

--employees ���̺��� �μ� id�� ��ġ�ϴ� departments ���̺��� �μ� id�� ã�Ƽ� 
--select ���Ͽ� �ִ� �÷����� ����ϴ� ����

--����Ŭ ���� ����
SELECT
    e.first_name,
    e.last_name,
    e.hire_date,
    e.salary,
    e.job_id,
    e.department_id,
    d.department_name
FROM
    employees   e,
    departments d
WHERE
    e.department_id = d.department_id;
--�� ���̺����� ���ϴ� ����� �������� ���Ҷ� �� ���̺��� ����� �Ӽ��� ������ �����Ͽ� ���ϴ� ��� ����

--ANSI JOIN(���� ���� ���)
--INNER JOIN : �����ϴ� ���̺�� �ȿ� ���� ���� �͸� ��ȸ
SELECT
    e.first_name,
    e.last_name,
    e.hire_date,
    e.salary,
    e.job_id,
    e.department_id,
    d.department_name
FROM
         employees e
    INNER JOIN departments d ON e.department_id = d.department_id;




--3�� ���̺��� �̿��� ���� ����(INNER JOIN)
SELECT
    e.first_name,
    e.last_name,
    e.department_id,
    d.department_name,
    j.job_title
FROM
    employees   e,
    departments d,
    jobs        j
WHERE
        e.department_id = d.department_id
    AND e.job_id = j.job_id;
--departments ���̺��� �μ� �̸��� 110���ķε� �� ���� �� ���� �� ���̺��� ��ġ ���� �����´ٴ� ��
--employees�� department, jobs ���̺� 3���� ����
--employees ���̺�� department ���̺��� �����ϱ� ���� �μ� id�� �����ϰ� employees���̺�� job���̺��� �����ϱ� ���� job_id�� ����

SELECT
    e.first_name,
    e.last_name,
    e.department_id,
    d.department_name,
    e.job_id,
    j.job_title,
    loc.city
FROM
    employees   e,
    departments d,
    jobs        j,
    locations   loc
WHERE
        e.department_id = d.department_id
    AND e.job_id = j.job_id -- 3,4
    AND d.location_id = loc.location_id -- 2
    AND loc.state_province = 'California'; -- 1
--WHERE ���� ���� ���ǰ� �Ϲ� ������ ���� �ۼ�
--california�� �͵��� ��ȸ�ϰ� 3���� ���̺��� �����ؼ� select�� �ִ� �÷��� ���� ��ȸ

/*
1. table�� ���� ���� 
2. loc ���̺��� province�� califonia ���ǿ� �´� ���� ������� ���͸�
3. location_id���� ���� ���� ������ �����͸� departments���� ã�Ƽ� ���� 
4. ���� ����� ������ department_id�� ���� employees ���̺��� �����͸� ã��
5. ���� ����� jobs ���̺��� ���Ͽ� �����ϰ� ���� ��� ���
*/

/*
�ܺ� ���� 
- ��� �� ���̺� ���� ���� ������ �ش� row���� ��ȸ ����� ��� ���ԵǴ� ����
*/
SELECT
    e.first_name,
    e.last_name,
    e.department_id,
    d.department_name
FROM
    employees   e,
    departments d,
    locations loc
WHERE
    e.department_id = d.department_id (+) -- �ܺ�����
    AND d.location_id = loc.location_id; -- �������� 
--(+) : '+�� �ִ� ���̺��� �ƴ� ����Ǵ� ���̺��� �����Ͱ� ���� �ʾƵ� ��� �����Ͷ�' ��� ��
--�ܺ������� select�� �ִ� ��� �����͸� �� ������ �� ���� 
--employees ���̺��� �����ϰ�, departments ���̺��� �������� �ʾƵ� 
--(+)�� ���� ���� ���̺��� �������� �Ͽ� departments ���̺��� ���ο� �����϶�� �ǹ̸� �ο��ϱ� ���� ���
--�������ΰ� �ܺ������� ���� ��������� ���������� ���� ����ǹǷ� �ܺ����θ� ����������� �����Ͱ� ����� ���� Ȯ��

SELECT
    e.employee_id,
    e.first_name,
    e.department_id,
    j.start_date,
    j.end_date,
    j.job_id
FROM
    employees   e,
    job_history j
WHERE
    e.employee_id = j.employee_id(+)
    AND j.department_id(+) = 80;
/*
�ܺ� ���� ���� �� ��� ���ǿ� (+)�� �ٿ��� �ϸ� 
�Ϲ� ���ǿ��� (+)�� ������ ������ �����Ͱ� �����Ǵ� ���� �߻�
�Ϲ��������� �μ� ��ȣ�� 80���� �ֵ鸸 ��ȸ�϶�� �ߴµ� outer�� ��������Ƿ� 
select�� ���ǵ� ��� data�� �ҷ����Ƿ� outer���� �Ϲ� ������ �ǹ̰� ����
*/

--��������
--�ڱ� �ڽ��� ���̺��� �ߺ����� join�Ͽ� ���̺��� ������ ��ȸ
SELECT
    e1.employee_id,
    e1.first_name,
    e1.manager_id,
    e2.first_name,
    e2.employee_id
FROM
         employees e1
    JOIN employees e2 ON e1.manager_id = e2.employee_id;
--Ư�� ������ �Ŵ����� ������ ��ȸ