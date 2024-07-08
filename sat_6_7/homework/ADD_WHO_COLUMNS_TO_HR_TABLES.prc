CREATE OR REPLACE PROCEDURE add_who_columns_to_hr_tables IS
    -- Cursor to fetch all table names in the HR schema
    CURSOR table_cursor IS
        SELECT table_name
        FROM all_tables
        WHERE owner = 'HR';
BEGIN
    -- Loop through each table in the HR schema
    FOR table_rec IN table_cursor LOOP
        -- Check and add created_by column if not exists
        IF column_exists(table_rec.table_name, 'CREATED_BY') = 0 THEN
            EXECUTE IMMEDIATE 'ALTER TABLE HR.' || table_rec.table_name || ' ADD CREATED_BY VARCHAR2(50)';
        END IF;

        -- Check and add created_date column if not exists
        IF column_exists(table_rec.table_name, 'CREATED_DATE') = 0 THEN
            EXECUTE IMMEDIATE 'ALTER TABLE HR.' || table_rec.table_name || ' ADD CREATED_DATE DATE DEFAULT SYSDATE';
        END IF;

        -- Check and add updated_by column if not exists
        IF column_exists(table_rec.table_name, 'UPDATED_BY') = 0 THEN
            EXECUTE IMMEDIATE 'ALTER TABLE HR.' || table_rec.table_name || ' ADD UPDATED_BY VARCHAR2(50)';
        END IF;

        -- Check and add updated_date column if not exists
        IF column_exists(table_rec.table_name, 'UPDATED_DATE') = 0 THEN
            EXECUTE IMMEDIATE 'ALTER TABLE HR.' || table_rec.table_name || ' ADD UPDATED_DATE DATE DEFAULT SYSDATE';
        END IF;
    END LOOP;
END add_who_columns_to_hr_tables;
/

exec add_who_columns_to_hr_tables()