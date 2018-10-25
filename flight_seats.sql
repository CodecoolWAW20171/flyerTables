create table flight_seats
(
  seat_id      bigint not null
    constraint flightseats_pk
    primary key
    constraint flight_seats_seats__fk
    references seats,
  passenger_id bigint
    constraint flight_seats_pesels__fk
    references passengers,
  flight_id    bigint not null
    constraint flight_seats_flights__fk
    references flights
);



