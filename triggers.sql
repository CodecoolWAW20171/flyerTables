DELETE FROM constant_relation;


CREATE OR REPLACE FUNCTION calculate_base_price() RETURNS TRIGGER AS $$
   BEGIN
      new.base_price := new.distance / 8;
      RETURN NEW;
   END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS price_trigger ON constant_relation;

CREATE TRIGGER price_trigger BEFORE INSERT OR UPDATE ON constant_relation
  FOR EACH ROW EXECUTE PROCEDURE calculate_base_price();

