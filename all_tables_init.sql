CREATE TYPE role AS ENUM ('user', 'manager');

create table if not exists users
(
	user_id bigserial not null
		constraint customers_pkey
			primary key,
	first_name varchar,
	last_name varchar not null,
	password varchar(255) not null,
	email varchar(255) not null,
	phone_number varchar,
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
	lastname varchar not null
)
;
create unique index if not exists passengers_passenger_id_uindex
	on passengers (passenger_id)
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

create table if not exists routes
(
	relation_id bigserial not null
		constraint routes_pkey
			primary key,
	from_airport varchar not null
		constraint routes_airports_from__fk
			references airports (airport_id),
	destination_airport varchar not null
		constraint routes_dest___fk
			references airports (airport_id),
	distance integer
)
;
create unique index if not exists routes_relationid_uindex
	on routes (relation_id)
;

create table if not exists flights
(
	flight_id bigserial not null
		constraint flights_pkey
			primary key,
	relation_id bigint not null
		constraint flights_routes__fk
			references routes (relation_id),
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

COPY airports
FROM '/home/witek/komputerowiec/codecool/advanced/flights/flyerTables/csv_files/airports.csv' with csv delimiter ',';

COPY users(first_name, last_name, email, password, phone_number, country, city, adress, role)
FROM '/home/witek/komputerowiec/codecool/advanced/flights/flyerTables/csv_files/users.csv' with csv delimiter ',';

COPY crew(first_name, last_name, function)
FROM '/home/witek/komputerowiec/codecool/advanced/flights/flyerTables/csv_files/crew.csv' with csv delimiter ',';

COPY passengers(firstname, lastname)
FROM '/home/witek/komputerowiec/codecool/advanced/flights/flyerTables/csv_files/passengers.csv' with csv delimiter ',';

COPY planes(seats_amount)
FROM '/home/witek/komputerowiec/codecool/advanced/flights/flyerTables/csv_files/planes.csv' with csv delimiter ',';

COPY routes(from_airport, destination_airport, distance)
FROM '/home/witek/komputerowiec/codecool/advanced/flights/flyerTables/csv_files/routes.csv' with csv delimiter ',';


