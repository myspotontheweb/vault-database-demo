--
-- Dummy tables
--
CREATE TABLE db1.dummy_table_one (
    col1 VARCHAR(100) NOT NULL,
    col2 VARCHAR(100) NOT NULL,
    col3 VARCHAR(100) NOT NULL
);

CREATE TABLE db1.dummy_table_two (
    col1 VARCHAR(100) NOT NULL,
    col2 VARCHAR(100) NOT NULL,
    col3 VARCHAR(100) NOT NULL
);

CREATE TABLE db1.dummy_table_three (
    col1 VARCHAR(100) NOT NULL,
    col2 VARCHAR(100) NOT NULL,
    col3 VARCHAR(100) NOT NULL
);

--
-- Insert data
--
INSERT INTO db1.dummy_table_one VALUES ('one', 'two', 'three');
INSERT INTO db1.dummy_table_one VALUES ('one', 'two', 'three');
INSERT INTO db1.dummy_table_one VALUES ('one', 'two', 'three');

INSERT INTO db1.dummy_table_two VALUES ('one', 'two', 'three');
INSERT INTO db1.dummy_table_two VALUES ('one', 'two', 'three');
INSERT INTO db1.dummy_table_two VALUES ('one', 'two', 'three');

INSERT INTO db1.dummy_table_three VALUES ('one', 'two', 'three');
INSERT INTO db1.dummy_table_three VALUES ('one', 'two', 'three');
INSERT INTO db1.dummy_table_three VALUES ('one', 'two', 'three');

