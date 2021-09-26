-- SP FN CURSOS Y SECCIONES

SELECT * FROM CURSOS
SELECT * FROM SECCIONES

-- LOS NOMBRES DE LOS CURSOS DEBEN SER UNICOS
ALTER TABLE CURSOS ADD CONSTRAINT NOMBRE_UNICO UNIQUE (NOMBRE);

--LISTA DE CURSOS
SELECT * FROM FN_LISTA_CURSOS(0)
CREATE OR REPLACE FUNCTION FN_LISTA_CURSOS(IN_OFFSET INT)RETURNS TABLE(
						   OUT_COD_CURSO INT, OUT_NOMBRE VARCHAR, OUT_ESTADO BOOLEAN, OUT_DESCRIPCION VARCHAR,OUT_TOTAL BIGINT)
AS
$$
BEGIN
RETURN QUERY
SELECT COD_CURSO,NOMBRE,ESTADO,DESCRIPCION,COUNT(COD_CURSO) FROM CURSOS 
GROUP BY COD_CURSO,NOMBRE,ESTADO,DESCRIPCION
LIMIT 10 
OFFSET IN_OFFSET;
END;
$$
LANGUAGE PLPGSQL;


CALL SP_NUEVO_CURSO('BACHILLERATO TÉCNICO PROFESIONAL EN INFORMÁTICA','BACHILLERATO',TRUE,'ADMIN')
CREATE OR REPLACE PROCEDURE SP_NUEVO_CURSO(IN_NOMBRE VARCHAR, IN_DESCRIPCION VARCHAR, IN_ESTADO BOOLEAN, 
										   IN_USR_REGISTRO VARCHAR)
AS
$$
BEGIN
INSERT INTO CURSOS(NOMBRE,DESCRIPCION,ESTADO,USR_REGISTRO,FEC_REGISTRO)
			VALUES(UPPER(IN_NOMBRE),UPPER(IN_DESCRIPCION),IN_ESTADO,IN_USR_REGISTRO,CURRENT_DATE);
			exception 
	   when sqlstate '23505' then 
	      raise exception using hint = 'El curso ingresado ya existe';
END;
$$
LANGUAGE PLPGSQL;

-- ACTUALIZAR UN CURSO
SELECT * FROM CURSOS
CALL SP_ACTUALIZAR_CURSO(3,'BACHILLERATO TÉCNICO PROFESIONAL EN INFORMÁTICA','BTPI',TRUE,'ADMIN')
CREATE OR REPLACE PROCEDURE SP_ACTUALIZAR_CURSO(IN_COD_CURSO INT, IN_NOMBRE_CURSO VARCHAR, IN_DESCRIPCION VARCHAR,
											   IN_ESTADO BOOLEAN, IN_USR_REGISTRO VARCHAR)
											   AS
$$
BEGIN
UPDATE CURSOS SET NOMBRE= UPPER(IN_NOMBRE_CURSO),
				  DESCRIPCION = UPPER(IN_DESCRIPCION),
				  ESTADO= IN_ESTADO,
				  USR_REGISTRO=IN_USR_REGISTRO
				  WHERE COD_CURSO = IN_COD_CURSO;
END;
$$
LANGUAGE PLPGSQL;

-- ELIMINAR CURSO
CALL SP_ELIMINAR_CURSO(3)
CREATE OR REPLACE PROCEDURE SP_ELIMINAR_CURSO(IN_COD_CURSO INT)
AS
$$
BEGIN
UPDATE CURSOS SET ESTADO =FALSE WHERE COD_CURSO =IN_COD_CURSO;
END;
$$
LANGUAGE PLPGSQL;

SELECT * FROM FN_BUSCAR_CURSO('BA%')
CREATE OR REPLACE FUNCTION FN_BUSCAR_CURSO(TERMINO VARCHAR)RETURNS TABLE(
						   OUT_COD_CURSO INT, OUT_NOMBRE VARCHAR, OUT_ESTADO BOOLEAN, OUT_DESCRIPCION VARCHAR,OUT_TOTAL BIGINT)
AS
$$
BEGIN
RETURN QUERY
SELECT COD_CURSO,NOMBRE,ESTADO,DESCRIPCION,COUNT(COD_CURSO) FROM CURSOS 
WHERE NOMBRE LIKE TERMINO
GROUP BY COD_CURSO,NOMBRE,ESTADO,DESCRIPCION
LIMIT 10; 
END;
$$
LANGUAGE PLPGSQL;


UPDATE CURSOS SET NOMBRE = 'BACHILLERATO TÉCNICO PROFESIONAL EN INFORMÁTICA' WHERE COD_CURSO =3

SELECT * FROM SECCIONES
SELECT * FROM CURSOS
SELECT * FROM MATRICULA

ALTER TABLE MATRICULA ADD CONSTRAINT FK_MATRICULA_SECCION FOREIGN KEY (COD_SECCION) REFERENCES SECCIONES(COD_SECCION)

--NUEVA SECCION
CALL SP_NUEVA_SECCION(8,'A',35,true,'12-12-2021','jorgeaguilera.agz@gmail.com')
CREATE OR REPLACE PROCEDURE SP_NUEVA_SECCION(IN_COD_CURSO INT, IN_NOMBRE VARCHAR, IN_ANIO VARCHAR, IN_CUPOS INT,IN_ESTADO BOOLEAN,
											 IN_USR_REGISTRO VARCHAR)
AS
$$
BEGIN
INSERT INTO SECCIONES (COD_CURSO,NOMBRE,CUPOS,ESTADO,ANIO,USR_REGISTRO,FEC_REGISTRO)
VALUES(IN_COD_CURSO,UPPER(IN_NOMBRE),IN_CUPOS,IN_ESTADO,IN_ANIO,IN_USR_REGISTRO,CURRENT_DATE);
END;
$$
LANGUAGE PLPGSQL;

--ACTUALIZAR SECCION
CALL SP_ACTUALIZAR_SECCION(1,'B',30,true)
CREATE OR REPLACE PROCEDURE SP_ACTUALIZAR_SECCION(IN_COD_SECCION INT,IN_NOMBRE VARCHAR,IN_CUPOS INT,
												  IN_ESTADO BOOLEAN,IN_ANIO VARCHAR)
AS
$$
BEGIN
UPDATE SECCIONES SET NOMBRE=UPPER(IN_NOMBRE),
					CUPOS=IN_CUPOS,
					ESTADO=IN_ESTADO,
					ANIO=IN_ANIO
					WHERE COD_SECCION = IN_COD_SECCION;
END;
$$
LANGUAGE PLPGSQL;

ALTER TABLE SECCIONES 
	ALTER COLUMN ANIO  TYPE VARCHAR;
SELECT * FROM SECCIONES

--LISTA DE SECCIONES
SELECT * FROM FN_LISTA_SECCIONES(8,'2021')
CREATE OR REPLACE FUNCTION FN_LISTA_SECCIONES(IN_CURSO INT,IN_ANIO VARCHAR)
RETURNS TABLE(OUT_COD_SECCION INT, OUT_NOMBRE CHAR,OUT_CUPOS INT,OUT_ESTADO BOOLEAN,OUT_ANIO VARCHAR)
AS
$$
BEGIN
RETURN QUERY
SELECT COD_SECCION,NOMBRE,CUPOS,ESTADO,ANIO FROM SECCIONES 
WHERE SECCIONES.COD_CURSO=IN_CURSO AND ANIO = IN_ANIO;
END;
$$
LANGUAGE PLPGSQL;
	
SELECT * FROM SECCIONES
UPDATE SECCIONES SET ANIO = '2021'
WHERE COD_SECCION = 1


