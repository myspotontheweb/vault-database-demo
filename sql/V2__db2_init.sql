--
-- Dummy tables
--
CREATE TABLE db2.dummy_table_uno (
    col1 VARCHAR(100) NOT NULL,
    col2 VARCHAR(100) NOT NULL,
    col3 VARCHAR(100) NOT NULL
);

CREATE TABLE db2.dummy_table_dos (
    col1 VARCHAR(100) NOT NULL,
    col2 VARCHAR(100) NOT NULL,
    col3 VARCHAR(100) NOT NULL
);

CREATE TABLE db2.dummy_table_tres (
    col1 VARCHAR(100) NOT NULL,
    col2 VARCHAR(100) NOT NULL,
    col3 VARCHAR(100) NOT NULL
);

--
-- Insert data
--
INSERT INTO db2.dummy_table_uno VALUES ('uno', 'dos', 'tres');
INSERT INTO db2.dummy_table_uno VALUES ('uno', 'dos', 'tres');
INSERT INTO db2.dummy_table_uno VALUES ('uno', 'dos', 'tres');

INSERT INTO db2.dummy_table_dos VALUES ('uno', 'dos', 'tres');
INSERT INTO db2.dummy_table_dos VALUES ('uno', 'dos', 'tres');
INSERT INTO db2.dummy_table_dos VALUES ('uno', 'dos', 'tres');

INSERT INTO db2.dummy_table_tres VALUES ('uno', 'dos', 'tres');
INSERT INTO db2.dummy_table_tres VALUES ('uno', 'dos', 'tres');
INSERT INTO db2.dummy_table_tres VALUES ('uno', 'dos', 'tres');
