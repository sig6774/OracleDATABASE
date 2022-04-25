/*
조인이란 
- 서로 다른 테이블간에 설저오딘 관계가 결합하여 
  1개 이상의 테이블에서 데이터를 조회하기 위해 사용
- SELECT 컬럼리스트 FROM 조인대상이 되는 테이블 (1개 이상)
  WHERE 조인 조건 (오라클 조인 문법)
*/

--employees 테이블의 부서 id와 일치하는 departments 테이블의 부서 id를 찾아서 
--select 이하에 있는 컬럼들을 출력하는 쿼리

--오라클 조인 문법
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
--한 테이블만으로 원하는 결과를 가져오지 못할때 두 테이블의 공통된 속성을 가지고 연결하여 원하는 결과 추출

--ANSI JOIN(가장 많이 사용)
--INNER JOIN : 연결하는 테이블들 안에 값이 같은 것만 조회
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




--3개 테이블을 이용한 내부 조인(INNER JOIN)
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
--departments 테이블의 부서 이름은 110이후로도 더 많음 그 뜻은 두 테이블의 일치 값만 가져온다는 뜻
--employees와 department, jobs 테이블 3개를 연결
--employees 테이블과 department 테이블을 연결하기 위해 부서 id로 연결하고 employees테이블과 job테이블을 연결하기 위해 job_id로 연결

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
--WHERE 절에 조인 조건과 일반 조건을 같이 작성
--california인 것들을 조회하고 3개의 테이블을 연결해서 select에 있는 컬럼을 최종 조회

/*
1. table명 약어로 생성 
2. loc 테이블의 province가 califonia 조건에 맞는 값을 대상으로 필터링
3. location_id값과 같은 값을 가지는 데이터를 departments에서 찾아서 조인 
4. 위의 결과와 동일한 department_id를 가진 employees 테이블의 데이터를 찾음
5. 위의 결과와 jobs 테이블을 비교하여 조인하고 최종 결과 출력
*/

/*
외부 조인 
- 어느 한 테이블에 공통 값이 없더라도 해당 row들이 조회 결과에 모두 포함되는 조인
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
    e.department_id = d.department_id (+) -- 외부조인
    AND d.location_id = loc.location_id; -- 내부조인 
--(+) : '+가 있는 테이블이 아닌 연결되는 테이블의 데이터가 같지 않아도 모두 가져와라' 라는 뜻
--외부조인은 select에 있는 모든 데이터를 다 가져올 수 있음 
--employees 테이블에는 존재하고, departments 테이블에는 존재하지 않아도 
--(+)가 붙지 않은 테이블을 기준으로 하여 departments 테이블이 조인에 참여하라는 의미를 부여하기 위해 사용
--내부조인과 외부조인을 같이 사용했을때 내부조인이 먼저 수행되므로 외부조인만 사용했을때의 데이터가 사라진 것을 확인

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
외부 조인 진행 시 모든 조건에 (+)를 붙여야 하며 
일반 조건에도 (+)를 붙이지 않으면 데이터가 누락되는 현상 발생
일반조건으로 부서 번호가 80번인 애들만 조회하라고 했는데 outer를 사용했으므로 
select에 정의된 모든 data를 불러오므로 outer에서 일반 조건은 의미가 없으
*/

--셀프조인
--자기 자신의 테이블을 중복으로 join하여 테이블의 정보를 조회
SELECT
    e1.employee_id,
    e1.first_name,
    e1.manager_id,
    e2.first_name,
    e2.employee_id
FROM
         employees e1
    JOIN employees e2 ON e1.manager_id = e2.employee_id;
--특정 직원의 매니저가 누군지 조회