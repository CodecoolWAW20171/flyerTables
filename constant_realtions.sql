create table constant_relation
(
  relation_id         bigserial not null
    constraint constantrelation_pkey
    primary key,
  from_airport        varchar   not null
    constraint constantrelation_airports_from__fk
    references airports,
  destination_airport varchar   not null
    constraint constant_relation_dest___fk
    references airports,
  base_price          money,
  distance            integer
);



create unique index constantrelation_relationid_uindex
  on constant_relation (relation_id);


