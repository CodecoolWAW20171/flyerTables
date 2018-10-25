create table customers
(
  customer_id  bigserial   not null
    constraint customers_pkey
    primary key,
  first_name   varchar,
  last_name    varchar     not null,
  password     varchar(16) not null,
  email        varchar(32) not null,
  phone_number bigint,
  country      varchar,
  city         varchar,
  adress       varchar
);

alter table customers
  owner to mariusz;

create unique index customers_customer_id_uindex
  on customers (customer_id);


