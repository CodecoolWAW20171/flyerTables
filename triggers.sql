-- base price in constant_relation
-- DELETE FROM constant_relation;

CREATE OR REPLACE FUNCTION calculate_base_price() RETURNS TRIGGER AS $$
   BEGIN
      new.base_price := new.distance / 8;
      RETURN NEW;
   END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS price_trigger ON constant_relation;

CREATE TRIGGER price_trigger BEFORE INSERT OR UPDATE ON constant_relation
  FOR EACH ROW EXECUTE PROCEDURE calculate_base_price();
-- --------------------------------------------
-- creating seats after created plane:

-- DELETE FROM planes;
-- DELETE FROM seats;

CREATE OR REPLACE FUNCTION create_seats() RETURNS TRIGGER AS $$
   DECLARE
     seats integer;
   BEGIN
      seats := new.seats_amount;
     FOR i in 1..seats LOOP
      INSERT INTO seats(seat_number, plane_id, standard)
      VALUES (i, new.plane_id, 'normal');
     END LOOP ;
      RETURN NEW;
   END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS seats_trigger ON planes;

CREATE TRIGGER seats_trigger AFTER INSERT ON planes
  FOR EACH ROW EXECUTE PROCEDURE create_seats();

-- ---------------------------------------------------------
-- fulfill enddate of arrival in flights, calculated by distance from constant_relation:

-- DELETE FROM flight_seats;
-- DELETE FROM flights;

CREATE OR REPLACE FUNCTION flights_time() RETURNS TRIGGER AS $$
   DECLARE
     speed integer := 900;
     dist integer;
     flight_duration interval;
   BEGIN
     SELECT distance INTO dist FROM constant_relation
     WHERE constant_relation.relation_id = new.relation_id;

     flight_duration := make_interval(hours := (dist / speed));
     new.enddate := new.startdate + flight_duration;
     RAISE NOTICE 'DISTANCE: (%)', dist;
     RAISE NOTICE 'DURANCE: (%)', flight_duration;
     RETURN NEW;
   END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS flights_trigger ON flights;

CREATE TRIGGER flights_trigger BEFORE INSERT ON flights
  FOR EACH ROW EXECUTE PROCEDURE flights_time();

-- -----------------------------------------------------------
-- create flight_seats after added flight:

ALTER TABLE public.flight_seats DROP CONSTRAINT IF EXISTS flightseats_pk;
ALTER TABLE public.flight_seats DROP CONSTRAINT IF EXISTS flight_seats_pk;
ALTER TABLE public.flight_seats ADD CONSTRAINT flight_seats_pk PRIMARY KEY (seat_id, flight_id);

CREATE OR REPLACE FUNCTION create_flight_seats() RETURNS TRIGGER AS $$
   DECLARE
     seats_num integer;
     id bigint;
   BEGIN
      SELECT seats_amount INTO seats_num FROM planes
     WHERE planes.plane_id = new.plane_id;
     FOR id in SELECT seats.seat_id FROM seats WHERE seats.plane_id = new.plane_id LOOP
      INSERT INTO flight_seats(seat_id, flight_id)
      VALUES (id, new.flight_id);
     END LOOP ;
      RETURN NEW;
   END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS flight_seats_trigger ON flights;

CREATE TRIGGER flight_seats_trigger AFTER INSERT ON flights
  FOR EACH ROW EXECUTE PROCEDURE create_flight_seats();
-- ------------------------------------------------------------------
-- trigger for creating tickets when passenger appears in flight_seats tabel:
