CREATE OR REPLACE FUNCTION column_exists (
    p_table_name IN VARCHAR2,
    p_column_name IN VARCHAR2
) RETURN NUMBER IS
    v_column_exists NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_column_exists
    FROM all_tab_columns
    WHERE owner = 'HR'
      AND table_name = p_table_name
      AND column_name = p_column_name;

    RETURN v_column_exists;
END column_exists;
/