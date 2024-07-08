/* Formatted on 7/8/2024 7:45:39 PM (QP5 v5.256.13226.35510) */
CREATE or replace TRIGGER on_approve_trg
   before UPDATE OF approval_status
   ON ABSENCES
   REFERENCING NEW AS New OLD AS Old
   FOR EACH ROW

DECLARE
BEGIN



   IF :New.approval_status = 'approved'
   THEN
      INSERT INTO absence_approval
           VALUES (approval_seq.nextval, :new.absence_id);

        :new.approval_date := sysdate;
   END IF;
END;