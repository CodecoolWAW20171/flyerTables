create table planes
(
  id                  serial  not null
    constraint planes_pkey
    primary key,
  model               varchar not null,
  passengers_capacity integer,
  aircrew             integer,
  captain_id          integer
);

alter table planes
  owner to witek;

create unique index planes_id_uindex
  on planes (id);


