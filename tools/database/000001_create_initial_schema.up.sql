create table if not exists test_table(
    id serial not null primary key,
    name varchar(244) not null
);

copy test_table (id, name)
    from '/database/fixtures/test_table.csv'
    delimiter ';' csv header;