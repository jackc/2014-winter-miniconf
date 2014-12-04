create table rooms(
  name text primary key
);

insert into rooms(name)
values ('101'), ('102'), ('103'), ('104'), ('105');

create table guests(
  name text primary key
);

insert into guests(name) values('George'), ('John'), ('Thomas');

create table reservations(
  id serial primary key,
  room_name text not null references rooms,
  guest_name text not null references guests,
  date_range daterange not null
);

insert into reservations(room_name, guest_name, date_range)
  values('101', 'George', daterange('2014-12-01', '2014-12-05'));

insert into reservations(room_name, guest_name, date_range)
  values('101', 'John', daterange('2014-12-03', '2014-12-07'));

select *
from reservations
where date_range @> '2014-12-02'::date;


delete from reservations;


create extension btree_gist;

alter table reservations add constraint no_overlap exclude using gist (room_name with =, date_range with &&);

insert into reservations(room_name, guest_name, date_range)
  values('101', 'George', daterange('2014-12-01', '2014-12-05'));

insert into reservations(room_name, guest_name, date_range)
  values('101', 'John', daterange('2014-12-03', '2014-12-07'));

insert into reservations(room_name, guest_name, date_range)
  values('102', 'John', daterange('2014-12-03', '2014-12-07'));

insert into reservations(room_name, guest_name, date_range)
  values('101', 'Thomas', daterange('2014-12-05', '2014-12-10'));

table reservations;
