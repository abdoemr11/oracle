/* Formatted on 7/6/2024 12:04:37 PM (QP5 v5.256.13226.35510) */
CREATE TABLE absences
(
   absence_id        NUMBER PRIMARY KEY,
   employee_id       NUMBER,
   request_number    VARCHAR2 (20),
   request_date      DATE,
   absence_type      VARCHAR2 (20),
   absence_porpose   VARCHAR (50),
   start_date        DATE,
   count_days        NUMBER,
   end_date          DATE,
   approval_status   VARCHAR2 (20),
   approval_date     DATE,
   CONSTRAINTS abs_emp_id_fk FOREIGN KEY(employee_id) REFERENCES  employees(employee_id)
)