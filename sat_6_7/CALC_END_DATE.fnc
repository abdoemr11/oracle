/* Formatted on 7/6/2024 12:32:39 PM (QP5 v5.256.13226.35510) */
CREATE OR REPLACE FUNCTION calc_end_date (p_start_date    DATE,
                                          p_count_days    NUMBER)
   RETURN DATE
IS
   v_return_date    DATE := p_start_date;
   remaining_days   NUMBER := p_count_days;
BEGIN
   WHILE remaining_days > 0
   LOOP
      IF NOT TO_CHAR (v_return_date, 'd') IN (6, 7)
      THEN
         remaining_days := remaining_days - 1;
      END IF;

      v_return_date := v_return_date + 1;
   END LOOP;

   IF TO_CHAR (v_return_date, 'd') = 6
   THEN
      v_return_date := v_return_date + 2;
   ELSIF TO_CHAR (v_return_date, 'd') = 7
   THEN
      v_return_date := v_return_date + 1;
   END IF;

   RETURN v_return_date;
END;

SELECT calc_end_date (SYSDATE + 1, 5) FROM DUAL