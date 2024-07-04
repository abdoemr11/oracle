
-- Drop tables 
drop table journal_header;
drop table journal_line;
drop table GL;

-- Create journal_header table
CREATE TABLE journal_header (
    journal_header_id NUMBER PRIMARY KEY,
    journal_date DATE,
    journal_description VARCHAR2(255),
    period_id NUMBER
);


-- Create journal_line table
CREATE TABLE journal_line (
    journal_line_id NUMBER PRIMARY KEY,
    journal_header_id NUMBER,
    GL_id NUMBER,
    debit NUMBER,
    credit NUMBER,
    FOREIGN KEY (journal_header_id) REFERENCES journal_header(journal_header_id), 
    FOREIGN KEY (GL_id) REFERENCES GL(GL_id)
);


-- Create GL table
CREATE TABLE GL (
    GL_id NUMBER PRIMARY KEY,
    GL_name VARCHAR2(255)
);

begin
-- Insert sample data into journal_header
INSERT INTO journal_header (journal_header_id, journal_date, journal_description, period_id) VALUES (1, TO_DATE('2024-01-01', 'YYYY-MM-DD'), 'Journal Entry 1', 1);
INSERT INTO journal_header (journal_header_id, journal_date, journal_description, period_id) VALUES (2, TO_DATE('2024-01-02', 'YYYY-MM-DD'), 'Journal Entry 2', 1);

-- Insert sample data into GL
INSERT INTO GL (GL_id, GL_name) VALUES (101, 'FOOD');
INSERT INTO GL (GL_id, GL_name) VALUES (102, 'Gas');
INSERT INTO GL (GL_id, GL_name) VALUES (103, 'Others');
INSERT INTO GL (GL_id, GL_name) VALUES (104, 'Pharmacy');

-- Insert sample data into journal_line
INSERT INTO journal_line (journal_line_id, journal_header_id, GL_id, debit, credit) VALUES (1, 1, 101, 1000, 0);
INSERT INTO journal_line (journal_line_id, journal_header_id, GL_id, debit, credit) VALUES (2, 1, 102, 0, 1000);
INSERT INTO journal_line (journal_line_id, journal_header_id, GL_id, debit, credit) VALUES (3, 2, 103, 500, 0);
INSERT INTO journal_line (journal_line_id, journal_header_id, GL_id, debit, credit) VALUES (4, 2, 104, 0, 500);



end;

