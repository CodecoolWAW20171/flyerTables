create table airports
(
  airport_id varchar          not null
    constraint airports_pkey
    primary key,
  city       varchar,
  country    varchar,
  longitude  double precision not null,
  latitude   double precision not null
);


create unique index airports_airportid_uindex
  on airports (airport_id);
