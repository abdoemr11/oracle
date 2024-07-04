/* Formatted on 7/2/2024 9:29:26 PM (QP5 v5.114.809.3010) */
DECLARE
   v_journal_header_id       NUMBER;
   v_new_journal_header_id   NUMBER := 0;
   v_debit                   NUMBER;
   v_credit                  NUMBER;
   unique_constraint exception;
   PRAGMA EXCEPTION_INIT (unique_constraint, -00001);
BEGIN
   -- Prompt the user to enter the journal_header_id
   v_journal_header_id := &journal_header_id;

   -- get the max journal_header_id
   SELECT   MAX (journal_header_id) + 1
     INTO   v_new_journal_header_id
     FROM   journal_header;

   DBMS_OUTPUT.PUT_LINE (v_new_journal_header_id);

   -- Insert a new record in the journal_header table with the description appended with "Reversed"
   INSERT INTO journal_header (journal_header_id,
                               journal_date,
                               journal_description,
                               period_id)
      SELECT   v_new_journal_header_id journal_header_id,
               sysdate,
               journal_description || ' Reversed',
               to_char(sysdate, 'mm') -- assume monthly period where january = 1 and dec = 12
        FROM   journal_header
       WHERE   journal_header_id = v_journal_header_id;
       
   -- Insert new records in the journal_line table with reversed debit and credit values
   FOR rec IN (SELECT   journal_line_id,
                        GL_id,
                        debit,
                        credit
                 FROM   journal_line
                WHERE   journal_header_id = v_journal_header_id)
   LOOP
      DBMS_OUTPUT.put_line (rec.journal_line_id);

      INSERT INTO journal_line (journal_line_id,
                                journal_header_id,
                                GL_id,
                                debit,
                                credit)
        VALUES   (seq_journal_line_id.NEXTVAL,
                  v_journal_header_id,
                  rec.GL_id,
                  rec.credit,
                  rec.debit);
   END LOOP;

   -- Commit the changes
   COMMIT;

   DBMS_OUTPUT.PUT_LINE('New records added with reversed debit and credit values for journal_header_id: '
                        || v_journal_header_id);
EXCEPTION
   WHEN unique_constraint
   THEN
      DBMS_OUTPUT.PUT_LINE ('An unique constraints occurred: ' || SQLERRM);
   WHEN OTHERS
   THEN
      --      DBMS_OUTPUT.PUT_LINE (v_new_journal_header_id);

      DBMS_OUTPUT.PUT_LINE ('An error occurred: ' || SQLERRM);
      ROLLBACK;
END;
/

--SELECT * FROM v$version