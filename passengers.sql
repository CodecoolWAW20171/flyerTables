create table passengers
(
  passenger_id bigserial not null
    constraint passengers_pkey
    primary key,
  firstname    varchar   not null,
  lastname     varchar   not null,
  email        varchar,
  phone_number varchar
);



create unique index passengers_passenger_id_uindex
  on passengers (passenger_id);

create unique index passengers_email_uindex
  on passengers (email);


