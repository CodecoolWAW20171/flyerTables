create table airports
(
  id           serial  not null
    constraint airports_pkey
    primary key,
  name         varchar not null,
  country      varchar not null,
  localization point
);

alter table airports
  owner to witek;

create unique index airports_id_uindex
  on airports (id);


