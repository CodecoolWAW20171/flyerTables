CREATE TYPE role AS ENUM ('user', 'manager');

create table if not exists users
(
	user_id bigserial not null
		constraint customers_pkey
			primary key,
	first_name varchar,
	last_name varchar not null,
	password varchar(16) not null,
	email varchar(32) not null,
	phone_number bigint,
	country varchar,
	city varchar,
	adress varchar,
  role role
)
;
create unique index if not exists customers_customer_id_uindex
	on users (user_id)
;

create table if not exists crew
(
	employee_id bigserial not null
		constraint crew_pkey
			primary key,
	first_name varchar,
	last_name varchar not null,
	function varchar
)
;
create unique index if not exists crew_employee_id_uindex
	on crew (employee_id)
;

create table if not exists planes
(
	plane_id bigserial not null
		constraint planes_pkey
			primary key,
	seats_amount integer
)
;
create unique index if not exists planes_plane_id_uindex
	on planes (plane_id)
;

create table if not exists passengers
(
	passenger_id bigserial not null
		constraint passengers_pkey
			primary key,
	firstname varchar not null,
	lastname varchar not null,
	email varchar,
	phone_number varchar
)
;
create unique index if not exists passengers_passenger_id_uindex
	on passengers (passenger_id)
;
create unique index if not exists passengers_email_uindex
	on passengers (email)
;

create table if not exists airports
(
	airport_id varchar not null
		constraint airports_pkey
			primary key,
	city varchar,
	country varchar,
	latitude double precision not null,
	longitude double precision not null
)
;
create unique index if not exists airports_airportid_uindex
	on airports (airport_id)
;

create table if not exists seats
(
	seat_id bigserial not null
		constraint seats_pkey
			primary key,
	seat_number varchar,
	plane_id bigint
		constraint planes_planeid_fk
			references planes (plane_id),
	standard varchar
)
;
create unique index if not exists seats_seat_id_uindex
	on seats (seat_id)
;

create table if not exists constant_relation
(
	relation_id bigserial not null
		constraint constantrelation_pkey
			primary key,
	from_airport varchar not null
		constraint constantrelation_airports_from__fk
			references airports (airport_id),
	destination_airport varchar not null
		constraint constantrelation_dest___fk
			references airports (airport_id),
	base_price money,
	distance integer
)
;
create unique index if not exists constantrelation_relationid_uindex
	on constant_relation (relation_id)
;

create table if not exists flights
(
	flight_id bigserial not null
		constraint flights_pkey
			primary key,
	relation_id bigint not null
		constraint flights_constant_relation__fk
			references constant_relation (relation_id),
	plane_id bigint not null,
	price money,
	captain_id bigint
		constraint crew_employeeid_fk
			references crew (employee_id),
	startdate timestamp not null,
	enddate timestamp not null
)
;
create unique index if not exists flights_flight_id_uindex
	on flights (flight_id)
;

create table if not exists flight_seats
(
	seat_id bigint not null
		constraint flightseats_pk
			primary key
		constraint flight_seats_seats__fk
			references seats (seat_id),
	passenger_id bigint
		constraint flight_seats_pesels__fk
			references passengers (passenger_id),
	flight_id bigint not null
		constraint flight_seats_flights__fk
			references flights (flight_id)
)
;

create table if not exists tickets
(
	ticket_id bigserial not null
		constraint tickets_pkey
			primary key,
	flight_id bigint not null
		constraint tickets_flights__fk
			references flights (flight_id),
	seat_id bigint not null
		constraint tickets_seats__fk
			references seats (seat_id),
	user_id bigint not null
    constraint users_userid_fk
      references users (user_id),
	passenger_id bigint not null
		constraint tickets_passengers__fk
			references passengers (passenger_id),
	price money
)
;
create unique index if not exists tickets_ticket_id_uindex
	on tickets (ticket_id)
;
