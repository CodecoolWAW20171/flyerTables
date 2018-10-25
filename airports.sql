create table airports
(
  airportid bigserial        not null
    constraint airports_pkey
    primary key,
  city      varchar,
  country   varchar,
  longitude double precision not null,
  latitude  double precision not null
);

alter table airports
  owner to witek;

create unique index airports_airportid_uindex
  on airports (airportid);


