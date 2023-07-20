create table if not exists characters(
    id serial not null primary key,
    name varchar(244) not null,
    from_where varchar(244) not null
);

copy characters (id, name, from_where)
    from '/database/fixtures/character.csv'
    delimiter ';' csv header;