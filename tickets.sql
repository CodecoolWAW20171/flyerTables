create table tickets
(
  ticket_id    bigserial not null
    constraint tickets_pkey
    primary key,
  flight_id    bigint    not null
    constraint tickets_flights__fk
    references flights,
  seat_id      bigint    not null
    constraint tickets_seats__fk
    references seats,
  customer_id  bigint    not null,
  passenger_id bigint    not null
    constraint tickets_passengers__fk
    references passengers,
  price        money
);



create unique index tickets_ticket_id_uindex
  on tickets (ticket_id);


