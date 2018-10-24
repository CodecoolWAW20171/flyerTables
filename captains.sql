create table captains
(
  id        serial  not null
    constraint captains_pkey
    primary key,
  firstname varchar not null,
  surname   varchar not null
);


create unique index captains_id_uindex
  on captains (id);


