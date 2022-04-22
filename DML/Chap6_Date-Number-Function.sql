--숫자함수
--ROUND(반올림, 반올림하고 싶은 위치) 원하는 반올림 위치를 매개값으로 지정
SELECT
    round(3.1254, 3),
    round(432.423, 0),
    round(45.923, - 1)
FROM
    dual;
--round의 함수에서 반올림하고 싶은 위치의 음수가 되면 정수자리로 올라감

--TRUNC(절사, 버리고 싶은 위치) 원하는 위치에서 값을 잘라냄
SELECT
    trunc(23.955, 2),
    trunc(23.955, 1),
    trunc(23.955, - 1)
FROM
    dual;

--ABS(절대값)
SELECT
    abs(23.955),
    abs(- 23.955),
    abs(0)
FROM
    dual;

--CEIL(올림), FLOOR(내림)
SELECT
    ceil(23.95),
    floor(23.955)
FROM
    dual;

--mod(나머지)
SELECT
    25 / 2,
    mod(25, 2)
FROM
    dual;

--날짜 함수
--sysdate 시스템에 설정된 날짜를 출력해줌
SELECT
    sysdate
FROM
    dual;

--자세한 시간 출력
SELECT
    systimestamp
FROM
    dual;

--날짜도 연산이 가능
SELECT
    round(sysdate, 'month')
FROM
    dual;
--4월 22일에서 월을 기준으로 일이 22일이므로 반올림을 진행해서 5월 1일로 출력

--근속 연수를 구할 수 있음(올림 활용)
SELECT
    first_name,
    ceil(sysdate - hire_date)
FROM
    employees;

--근속연수를 일, 주, 년으로 구할 수 있음(올림 활용)
SELECT
    first_name,
    ceil(sysdate - hire_date)         AS day,
    ceil((sysdate - hire_date) / 7)   AS week,
    ceil((sysdate - hire_date) / 365) AS year
FROM
    employees;