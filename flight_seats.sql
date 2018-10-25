create table flight_seats
(
  seat_id      bigint not null,
  passenger_id bigint,
  flight_id    bigint not null,
  constraint flightseats_pk
  primary key (seat_id, flight_id)
);

alter table flight_seats
  owner to witek;


