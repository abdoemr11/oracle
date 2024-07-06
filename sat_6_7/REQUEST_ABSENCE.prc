/* Formatted on 7/6/2024 12:22:59 PM (QP5 v5.256.13226.35510) */
CREATE OR REPLACE PROCEDURE request_absence (p_emp_id        NUMBER,
                                             p_start_date    DATE,
                                             p_count_days    NUMBER)
IS
   v_emp_hire_date   DATE;
   v_request_num     VARCHAR2 (20);
   v_end_date        DATE := calc_end_date (p_start_date, p_count_days);
   
BEGIN
   SELECT hire_date
     INTO v_emp_hire_date
     FROM employees
    WHERE p_emp_id = employee_id;

   IF (SYSDATE - v_emp_hire_date) < 90
   THEN
      DBMS_OUTPUT.put_line ('This employee can''nt take an absence');
      RETURN;
   END IF;

   SELECT department_name
     INTO v_request_num
     FROM departments
    WHERE department_id = (SELECT department_id
                             FROM employees
                            WHERE employee_id = p_emp_id);

   v_request_num := v_request_num || p_emp_id;

   INSERT INTO absences (ABSENCE_ID,
                         EMPLOYEE_ID,
                         REQUEST_NUMBER,
                         REQUEST_DATE,
                         ABSENCE_TYPE,
                         ABSENCE_PORPOSE,
                         START_DATE,
                         COUNT_DAYS,
                         END_DATE,
                         APPROVAL_STATUS,
                         APPROVAL_DATE)
        VALUES (absence_seq.nextval,
                p_emp_id,
                v_request_num,
                SYSDATE,
                'Annual',
                'anything',
                p_start_date,
                p_count_days,
                v_end_date,
                'new',
                NULL);
END;

SELECT *
  FROM dictionary
 WHERE table_name LIKE '%COL%';

SELECT WM_CONCAT (column_name)
  FROM user_tab_cols
 WHERE table_name = 'ABSENCES';
 
select * from employees ;

exec request_absence(198, sysdate + 2, 7)

select * from absences