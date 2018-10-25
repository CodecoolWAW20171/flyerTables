create table seats
(
  seat_id     bigserial not null
    constraint seats_pkey
    primary key,
  seat_number varchar,
  plane_id    bigint,
  standard    varchar
);

alter table seats
  owner to witek;

create unique index seats_seat_id_uindex
  on seats (seat_id);


