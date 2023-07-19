create table if not exists characters
(
    id              serial              not null
        constraint pk_character_id primary key,
    name            varchar(256)        not null,
    from_where      varchar(256)        not null,
);