CREATE OR REPLACE PROCEDURE delete_who_columns IS
    -- Cursor to fetch all table names in the HR schema
    CURSOR table_cursor IS
        SELECT table_name
        FROM all_tables
        WHERE owner = 'HR';
BEGIN
    -- Loop through each table in the HR schema
    FOR table_rec IN table_cursor LOOP
        -- Check and drop created_by column if exists
        IF column_exists(table_rec.table_name, 'CREATED_BY') = 1 THEN
            EXECUTE IMMEDIATE 'ALTER TABLE HR.' || table_rec.table_name || ' DROP COLUMN CREATED_BY';
        END IF;

        -- Check and drop created_date column if exists
        IF column_exists(table_rec.table_name, 'CREATED_DATE') = 1 THEN
            EXECUTE IMMEDIATE 'ALTER TABLE HR.' || table_rec.table_name || ' DROP COLUMN CREATED_DATE';
        END IF;

        -- Check and drop updated_by column if exists
        IF column_exists(table_rec.table_name, 'UPDATED_BY') = 1 THEN
            EXECUTE IMMEDIATE 'ALTER TABLE HR.' || table_rec.table_name || ' DROP COLUMN UPDATED_BY';
        END IF;

        -- Check and drop updated_date column if exists
        IF column_exists(table_rec.table_name, 'UPDATED_DATE') = 1 THEN
            EXECUTE IMMEDIATE 'ALTER TABLE HR.' || table_rec.table_name || ' DROP COLUMN UPDATED_DATE';
        END IF;
    END LOOP;
END delete_who_columns;
/

EXEC delete_who_columns;