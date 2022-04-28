SELECT
    d.department_id,
    d.department_name,
    d.manager_id,
    tb.result
FROM
         departments d
    INNER JOIN (
        SELECT
            e.department_id,
            COUNT(e.department_id) AS result
        FROM
            employees e
        GROUP BY
            e.department_id
    ) tb ON d.department_id = tb.department_id;

SELECT
    d.*,
    l.street_address,
    l.postal_code,
    l.city,
    tr.Æò±Õ¿¬ºÀ
FROM
         departments d
    INNER JOIN locations l ON d.location_id = l.location_id
    LEFT OUTER JOIN (
        SELECT
            department_id,
            trunc(AVG(salary)) AS Æò±Õ¿¬ºÀ
        FROM
            employees
        GROUP BY
            department_id
    )         tr ON d.department_id = tr.department_id;