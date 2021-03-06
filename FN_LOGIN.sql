SELECT * FROM FN_LOGIN('giito16@gmail.com')
CREATE OR REPLACE FUNCTION FN_LOGIN(IN_USUARIO VARCHAR)RETURNS TABLE(
							OUT_ID INT,OUT_PRIMER_INGRESO BOOLEAN,OUT_USUARIO VARCHAR,
							OUT_CONTRASENA VARCHAR,
							OUT_ESTADO INT,OUT_NOMBRE TEXT,OUT_INTENTOS VARCHAR)
AS
$$
BEGIN
RETURN QUERY
SELECT USUARIO.COD_USUARIO,USUARIO.PRIMER_INGRESO,USUARIO.USUARIO,USUARIO.CONTRASENA,
		USUARIO.COD_ESTADO, 
	CONCAT(PERSONA.primer_nombre,' ',PERSONA.primer_apellido)as NOMBRE,
	(SELECT PARAMETROS.VALOR FROM PARAMETROS WHERE PARAMETROS.PARAMETRO='ADMIN_INTENTOS') AS INTENTOS
FROM USUARIO
INNER JOIN PERSONA ON USUARIO.COD_PERSONA = PERSONA.COD_PERSONA
WHERE USUARIO.USUARIO=IN_USUARIO;
END;
$$
LANGUAGE PLPGSQL;

SELECT * FROM usuario
SELECT * FROM ESTADO
SELECT * FROM USUARIO
SELECT * FROM ROLES


INSERT INTO ROLES(NOMBRE,DESCRIPCION,USR_REGISTRO,FEC_REGISTRO)
VALUES('ADMIN_ROLE','ADMINISTRADOR DEL SISTEMA','ADMIN',CURRENT_DATE)

INSERT INTO USUARIO_ROLES(COD_USUARIO,COD_ROL,USR_REGISTRO,FEC_REGISTRO)
			VALUES(1,1,'ADMIN',CURRENT_DATE)
INSERT INTO ESTADO(DESCRIPCION)
VALUES('BLOQUEADO')

INSERT INTO USUARIO(COD_PERSONA,COD_ESTADO,USUARIO,CONTRASENA,PRIMER_INGRESO,USR_REGISTRO,FEC_REGISTRO)
VALUES(15,1,'jorgeaguilera.agz@gmail.com','$2a$13$J.EeNDDxlngPuIQAsOpkF.o4F8z/J8yhdE0ZQA5oXg1L0IWNwxE9y',true,'ADMIN',CURRENT_DATE)

SELECT * FROM PERSONA 15