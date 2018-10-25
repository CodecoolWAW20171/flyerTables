create table flights
(
  flight_id   bigserial not null
    constraint flights_pkey
    primary key,
  relation_id bigint    not null
    constraint flights_constant_relation__fk
    references constant_relation,
  plane_id    bigint    not null,
  price       money,
  captain_id  bigint,
  startdate   timestamp not null,
  enddate     timestamp not null
);

create unique index flights_flight_id_uindex
  on flights (flight_id);


