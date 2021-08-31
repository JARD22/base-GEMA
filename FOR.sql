CREATE TABLE TELEFONO(
ID INT,
TELEFONO VARCHAR
)

SELECT * FROM TELEFONOS

DO
$do$
DECLARE
   a json[] := array['{"tel1":"97229237","tel2":"97070587"}','{"tel1":"93820089","tel2":"93820089"}'];
   i integer;
BEGIN
   FOR i IN 1 .. array_upper(a, 1)
   LOOP
    RAISE NOTICE '%', a[i]->>'tel1';  
   END LOOP;
END
$do$;

CREATE OR REPLACE FUNCTION my_function(input jsonb)
  RETURNS jsonb
  LANGUAGE plpgsql AS  -- language declaration required
$func$
DECLARE
   _key   text;
   _value text;
BEGIN
    FOR _key, _value IN
       SELECT * FROM jsonb_each_text($1)
    LOOP
       -- do some math operation on its corresponding value
       RAISE NOTICE '%',  _value;
    END LOOP;

    RETURN input;
END
$func$;

SELECT my_function('{"a":1, "b":2, "c":3}');