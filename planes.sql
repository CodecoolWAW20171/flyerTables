create table planes
(
  plane_id     bigserial not null
    constraint planes_pkey
    primary key,
  seats_amount integer
);

alter table planes
  owner to mariusz;

create unique index planes_plane_id_uindex
  on planes (plane_id);


