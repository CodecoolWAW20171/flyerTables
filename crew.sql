create table crew
(
  employee_id bigserial not null
    constraint crew_pkey
    primary key,
  first_name  varchar,
  last_name   varchar   not null,
  function    varchar
);

alter table crew
  owner to mariusz;

create unique index crew_employee_id_uindex
  on crew (employee_id);


