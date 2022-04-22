-- lower(소문자), initcap(앞글자만 대문자), upper(대문자)
SELECT
    'abcDEF',
    lower('abcDEF'),
    upper('abcDEF')
FROM
    dual;
/*
dual이라는 테이블은 sys가 소유하는 오라클의 표준 테이블로서
오직 한 행에 한 컬럼만 담고 있는 dummy 테이블 
일시적인 산술 연산이나 날짜 연산 등을 주로 사용
간단한 결과를 확인하기 위해서는 dual을 통해 확인 가능
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
--lower를 적용했을때의 조건의 값을 걸어서 실제 값을 조회 가능
--이걸로 대소문자에 관계 없이 값을 쉽게 조회할 수 있을듯

SELECT
    'abcdef' AS ex,
    length('abcdef'),
    instr('abcdef', 'd')
FROM
    dual;
--length(길이), instr(문자, 찾고 싶은 문자) 없으면 0값 나옴, 인덱스 값으로 나옴
--instr()함수의 출력은 인덱스 값이 0부터 시작이 아니라 1부터 시작이네

SELECT
    first_name,
    length(first_name),
    instr(first_name, 'c')
FROM
    employees;

--SUBSTR(문자열, 시작범위, 끝범위) : 문자열 자르기, CONCAT(문자열, 문자열) : 문자열 합치기
SELECT
    'abcdef' AS ex,
    substr('abcdef', 1, 4),
    concat('abcdef', 'ghi')
FROM
    dual;

SELECT
    first_name,
    substr(first_name, 1, 4),
    concat(first_name, last_name) AS 이름성
FROM
    employees;

--LPAD, RPAD(좌, 우측 지정 문자열로 채움)
SELECT
    lpad('abc', 10, '$$$')
FROM
    dual;

SELECT
    rpad('abc', 10, '$$$')
FROM
    dual;

--LTRIM(문자, 제거할문자), RTRIM(문자, 제거할문자) TRIM(문자, 제거할문자) 좌, 우, 양옆에 있는 특정 문자 제거
SELECT
    ltrim('   Lunch    ', ' ')
FROM
    dual;

SELECT
    rtrim('   Lunch    ', ' ')
FROM
    dual;

--REPLACE(기준문자열, 특정문자, 바꿀문자) 문자를 바꾸는 함수 
SELECT
    replace('MY DREAM IS AS PRESIDENT', 'PRESIDENT', 'DOCTOR')
FROM
    dual;

SELECT
    replace('MY DREAM IS AS PRESIDENT', ' ', '')
FROM
    dual;
--공백제거
SELECT
    replace(replace('MY DREAM IS AS PRESIDENT', 'PRESIDENT', 'DOCTOR'), ' ', '')
FROM
    dual;
--president를 doctor로 변환한 것을 다시 replace함수를 사용해서 공백을 제거

SELECT
    replace(replace(concat('hello ', 'world!'), '!', '?'), ' ', '')
FROM
    dual;
--hello world!로 합치고 !를 ?로 변경하고 공백도 제거
