PGDMP                         y            gemav2    11.9    13.3 �    f           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            g           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            h           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            i           1262    87911    gemav2    DATABASE     b   CREATE DATABASE gemav2 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Spanish_Spain.1252';
    DROP DATABASE gemav2;
                postgres    false                        1255    88608     fn_alumno_uid(character varying)    FUNCTION     z  CREATE FUNCTION public.fn_alumno_uid(in_uid character varying) RETURNS TABLE(out_cod_tipo_persona integer, out_primer_nombre character varying, out_primer_apellido character varying, out_segundo_nombre character varying, out_segundo_apellido character varying, out_dni character varying, out_nacionalidad character varying, out_fec_nacimiento date, out_sexo character, out_vive_con character, out_enfermedad character varying, out_estado boolean, out_motivo_retiro character varying, out_direccion character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN QUERY
SELECT PERSONA.COD_TIPO_PERSONA,PERSONA.PRIMER_NOMBRE,PERSONA.PRIMER_APELLIDO,PERSONA.SEGUNDO_NOMBRE,PERSONA.SEGUNDO_APELLIDO,
	   PERSONA.DNI,PERSONA.NACIONALIDAD,PERSONA.FEC_NACIMIENTO, PERSONA.SEXO,ALUMNOS.VIVE_CON,ALUMNOS.ENFERMEDAD,
	   ALUMNOS.ESTADO,ALUMNOS.MOTIVO_RETIRO,DIRECCION.DIRECCION
FROM PERSONA
INNER JOIN ALUMNOS ON PERSONA.COD_PERSONA = ALUMNOS.COD_PERSONA
INNER JOIN DIRECCION_PERSONA ON PERSONA.COD_PERSONA = DIRECCION_PERSONA.COD_PERSONA
INNER JOIN DIRECCION  ON DIRECCION_PERSONA.COD_DIRECCION =DIRECCION.COD_DIRECCION
WHERE PERSONA.UID = IN_UID;
END;
$$;
 >   DROP FUNCTION public.fn_alumno_uid(in_uid character varying);
       public          postgres    false                       1255    88606 #   fn_bucar_persona(character varying)    FUNCTION       CREATE FUNCTION public.fn_bucar_persona(termino character varying) RETURNS TABLE(out_nombre text, out_tipo_persona character varying, out_cod_tipo_persona integer, out_uid character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN QUERY
SELECT CONCAT(PERSONA.PRIMER_NOMBRE,' ',PERSONA.PRIMER_APELLIDO)AS NOMBRE, TIPO_PERSONA.NOMBRE AS TIPO,
TIPO_PERSONA.COD_TIPO_PERSONA,PERSONA.UID  FROM PERSONA
INNER JOIN TIPO_PERSONA ON PERSONA.COD_TIPO_PERSONA = TIPO_PERSONA.COD_TIPO_PERSONA
WHERE PERSONA.DNI LIKE TERMINO

LIMIT 10;
END;
$$;
 B   DROP FUNCTION public.fn_bucar_persona(termino character varying);
       public          postgres    false                       1255    88647 "   fn_buscar_curso(character varying)    FUNCTION     �  CREATE FUNCTION public.fn_buscar_curso(termino character varying) RETURNS TABLE(out_cod_curso integer, out_nombre character varying, out_estado boolean, out_descripcion character varying, out_total bigint)
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN QUERY
SELECT COD_CURSO,NOMBRE,ESTADO,DESCRIPCION,COUNT(COD_CURSO) FROM CURSOS 
WHERE NOMBRE LIKE TERMINO
GROUP BY COD_CURSO,NOMBRE,ESTADO,DESCRIPCION
LIMIT 10; 
END;
$$;
 A   DROP FUNCTION public.fn_buscar_curso(termino character varying);
       public          postgres    false                       1255    88611    fn_lista_contratos(integer)    FUNCTION       CREATE FUNCTION public.fn_lista_contratos(in_offset integer) RETURNS TABLE(out_nombre character varying, out_estado boolean, out_cod_contrato integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN QUERY
SELECT NOMBRE,ESTADO,COD_CONTRATO FROM CONTRATOS
LIMIT 10
OFFSET IN_OFFSET;
END;
$$;
 <   DROP FUNCTION public.fn_lista_contratos(in_offset integer);
       public          postgres    false                       1255    88645    fn_lista_cursos(integer)    FUNCTION     �  CREATE FUNCTION public.fn_lista_cursos(in_offset integer) RETURNS TABLE(out_cod_curso integer, out_nombre character varying, out_estado boolean, out_descripcion character varying, out_total bigint)
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN QUERY
SELECT COD_CURSO,NOMBRE,ESTADO,DESCRIPCION,COUNT(COD_CURSO) FROM CURSOS 
GROUP BY COD_CURSO,NOMBRE,ESTADO,DESCRIPCION
LIMIT 10 
OFFSET IN_OFFSET;
END;
$$;
 9   DROP FUNCTION public.fn_lista_cursos(in_offset integer);
       public          postgres    false                       1255    88585    fn_lista_personas(integer)    FUNCTION     A  CREATE FUNCTION public.fn_lista_personas(in_offset integer) RETURNS TABLE(out_nombre text, out_tipo_persona character varying, out_cod_tipo_persona integer, out_uid character varying, total bigint)
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN QUERY
SELECT CONCAT(PERSONA.PRIMER_NOMBRE,' ',PERSONA.PRIMER_APELLIDO)AS NOMBRE, TIPO_PERSONA.NOMBRE AS TIPO,
TIPO_PERSONA.COD_TIPO_PERSONA,PERSONA.UID, (SELECT COUNT(COD_PERSONA)AS TOTAL FROM PERSONA) FROM PERSONA
INNER JOIN TIPO_PERSONA ON PERSONA.COD_TIPO_PERSONA = TIPO_PERSONA.COD_TIPO_PERSONA
OFFSET IN_OFFSET
LIMIT 10;
END;
$$;
 ;   DROP FUNCTION public.fn_lista_personas(in_offset integer);
       public          postgres    false                       1255    88521    fn_lista_tipo_persona()    FUNCTION     �   CREATE FUNCTION public.fn_lista_tipo_persona() RETURNS TABLE(out_id integer, out_nombre character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN QUERY
SELECT COD_TIPO_PERSONA, NOMBRE FROM TIPO_PERSONA
ORDER BY COD_TIPO_PERSONA;
END;
$$;
 .   DROP FUNCTION public.fn_lista_tipo_persona();
       public          postgres    false                       1255    88557    fn_lista_usuarios(integer)    FUNCTION     w  CREATE FUNCTION public.fn_lista_usuarios(in_offset integer) RETURNS TABLE(out_id integer, out_nombre text, out_rol character varying, estado character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN

RETURN QUERY
SELECT USUARIO.COD_USUARIO,CONCAT(PERSONA.PRIMER_NOMBRE,' ',PERSONA.PRIMER_APELLIDO),ROLES.NOMBRE,ESTADO.DESCRIPCION
FROM USUARIO
INNER JOIN ESTADO ON USUARIO.COD_ESTADO= ESTADO.COD_ESTADO
INNER JOIN PERSONA ON USUARIO.COD_PERSONA = PERSONA.COD_PERSONA
INNER JOIN USUARIO_ROLES ON USUARIO.COD_USUARIO =USUARIO_ROLES.COD_USUARIO
INNER JOIN ROLES ON USUARIO_ROLES.COD_ROL =ROLES.COD_ROL
OFFSET IN_OFFSET
LIMIT 8;
END;
$$;
 ;   DROP FUNCTION public.fn_lista_usuarios(in_offset integer);
       public          postgres    false                       1255    88573    fn_login(character varying)    FUNCTION     g  CREATE FUNCTION public.fn_login(in_usuario character varying) RETURNS TABLE(out_id integer, out_primer_ingreso boolean, out_usuario character varying, out_contrasena character varying, out_estado integer, out_rol character varying, out_nombre text, out_intentos character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN QUERY
SELECT USUARIO.COD_USUARIO,USUARIO.PRIMER_INGRESO,USUARIO.USUARIO,USUARIO.CONTRASENA,USUARIO.COD_ESTADO,ROLES.NOMBRE, 
	CONCAT(PERSONA.primer_nombre,' ',PERSONA.primer_apellido)as NOMBRE,
	(SELECT PARAMETROS.VALOR FROM PARAMETROS WHERE PARAMETROS.PARAMETRO='ADMIN_INTENTOS') AS INTENTOS
FROM USUARIO
INNER JOIN USUARIO_ROLES ON USUARIO.COD_USUARIO = USUARIO_ROLES.COD_USUARIO
INNER JOIN ROLES ON USUARIO_ROLES.COD_ROL =ROLES.COD_ROL
INNER JOIN PERSONA ON USUARIO.COD_PERSONA = PERSONA.COD_PERSONA
WHERE USUARIO.USUARIO=IN_USUARIO;
END;
$$;
 =   DROP FUNCTION public.fn_login(in_usuario character varying);
       public          postgres    false                       1255    88590 !   fn_persona_uid(character varying)    FUNCTION     �  CREATE FUNCTION public.fn_persona_uid(in_uid character varying) RETURNS TABLE(out_cod_tipo_persona integer, out_primer_nombre character varying, out_segundo_nombre character varying, out_primer_apellido character varying, out_segundo_apellido character varying, out_dni character varying, out_fec_nacimiento date, out_nacionalidad character varying, out_sexo character, out_direccion character varying, out_encargado boolean, out_ocupacion character varying, out_lugar_trabajo character varying, out_escolaridad character varying, out_telefonos json)
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN QUERY
SELECT PERSONA.COD_TIPO_PERSONA,PERSONA.PRIMER_NOMBRE,PERSONA.SEGUNDO_NOMBRE,PERSONA.PRIMER_APELLIDO,PERSONA.SEGUNDO_APELLIDO,
	   PERSONA.DNI,PERSONA.FEC_NACIMIENTO,PERSONA.NACIONALIDAD,PERSONA.SEXO,DIRECCION.DIRECCION,FAMILIARES.ENCARGADO,
	   FAMILIARES.OCUPACION,FAMILIARES.LUGAR_TRABAJO,FAMILIARES.ESCOLARIDAD,
			 JSON_AGG(JSON_BUILD_OBJECT(
				 	'cod_telefono',TELEFONO.COD_TELEFONO,
				    'telefono',TELEFONO.TELEFONO,
		   			'cod_tipo_telefono',TELEFONO.COD_TIPO_TELEFONO,
		   			'whatsapp',TELEFONO.WHATSAPP,
		   		    'emergencia',TELEFONO.EMERGENCIA))  
	   FROM PERSONA
	   INNER JOIN DIRECCION_PERSONA ON PERSONA.COD_PERSONA = DIRECCION_PERSONA.COD_PERSONA
	   INNER JOIN DIRECCION ON DIRECCION_PERSONA.COD_DIRECCION = DIRECCION.COD_DIRECCION
	   INNER JOIN TELEFONO_PERSONA ON PERSONA.COD_PERSONA = TELEFONO_PERSONA.COD_PERSONA
	   INNER JOIN TELEFONO ON TELEFONO_PERSONA.COD_TELEFONO = TELEFONO.COD_TELEFONO
	   INNER JOIN FAMILIARES ON PERSONA.COD_PERSONA = FAMILIARES.COD_PERSONA
	   WHERE PERSONA.UID =IN_UID AND TELEFONO.ESTADO = TRUE
	   GROUP BY PERSONA.COD_TIPO_PERSONA,PERSONA.PRIMER_NOMBRE,PERSONA.SEGUNDO_NOMBRE,PERSONA.PRIMER_APELLIDO,PERSONA.SEGUNDO_APELLIDO,
	     PERSONA.DNI,PERSONA.FEC_NACIMIENTO,PERSONA.NACIONALIDAD,DIRECCION.DIRECCION,FAMILIARES.ENCARGADO,PERSONA.SEXO,FAMILIARES.OCUPACION,
		 FAMILIARES.LUGAR_TRABAJO,FAMILIARES.ESCOLARIDAD;
END;
$$;
 ?   DROP FUNCTION public.fn_persona_uid(in_uid character varying);
       public          postgres    false                       1255    88609 �   sp_actualizar_alumno(character varying, character varying, character varying, character varying, character, date, character varying, character varying, character varying, character varying, boolean, character varying, character varying, character varying) 	   PROCEDURE     �  CREATE PROCEDURE public.sp_actualizar_alumno(in_dni character varying, in_primer_nombre character varying, in_primer_apellido character varying, in_nacionalidad character varying, in_sexo character, in_fec_nacimiento date, in_enfermedad character varying, in_vive_con character varying, in_direccion character varying, in_uid character varying, in_estado boolean, in_motivo_retiro character varying DEFAULT ''::character varying, in_segundo_nombre character varying DEFAULT ''::character varying, in_segundo_apellido character varying DEFAULT ''::character varying)
    LANGUAGE plpgsql
    AS $$
DECLARE
CODIGO_PERSONA INT;
CODIGO_DIRECCION INT;
BEGIN
IF NOT EXISTS(SELECT PERSONA.UID FROM PERSONA WHERE UID=IN_UID)THEN
RAISE EXCEPTION USING HINT ='Identificador manipulado';
RETURN;
END IF;

CODIGO_PERSONA :=(SELECT COD_PERSONA FROM PERSONA WHERE UID=IN_UID);

IF (SELECT PERSONA.UID FROM PERSONA WHERE PERSONA.DNI=IN_DNI)<>IN_UID THEN
RAISE EXCEPTION USING HINT = 'Número de identidad ya se encuentra registrado';
END IF;

UPDATE PERSONA 
	   SET 
	   DNI=IN_DNI,
	   PRIMER_NOMBRE=IN_PRIMER_NOMBRE,
	   SEGUNDO_NOMBRE=IN_SEGUNDO_NOMBRE,
	   PRIMER_APELLIDO=IN_PRIMER_APELLIDO,
	   SEGUNDO_APELLIDO=IN_SEGUNDO_APELLIDO,
	   NACIONALIDAD=IN_NACIONALIDAD,
	   SEXO=IN_SEXO,
	   FEC_NACIMIENTO=IN_FEC_NACIMIENTO
	   WHERE PERSONA.UID=IN_UID;


UPDATE ALUMNOS SET
ENFERMEDAD = IN_ENFERMEDAD,
VIVE_CON= IN_VIVE_CON,
MOTIVO_RETIRO=IN_MOTIVO_RETIRO,
ESTADO = IN_ESTADO
WHERE COD_PERSONA = CODIGO_PERSONA;

--DIRECCION
CODIGO_DIRECCION :=(SELECT COD_DIRECCION FROM DIRECCION_PERSONA WHERE DIRECCION_PERSONA.COD_PERSONA= CODIGO_PERSONA);
UPDATE DIRECCION SET DIRECCION = IN_DIRECCION WHERE COD_DIRECCION = CODIGO_DIRECCION;

END;
$$;
 �  DROP PROCEDURE public.sp_actualizar_alumno(in_dni character varying, in_primer_nombre character varying, in_primer_apellido character varying, in_nacionalidad character varying, in_sexo character, in_fec_nacimiento date, in_enfermedad character varying, in_vive_con character varying, in_direccion character varying, in_uid character varying, in_estado boolean, in_motivo_retiro character varying, in_segundo_nombre character varying, in_segundo_apellido character varying);
       public          postgres    false                       1255    88643 ^   sp_actualizar_curso(integer, character varying, character varying, boolean, character varying) 	   PROCEDURE     �  CREATE PROCEDURE public.sp_actualizar_curso(in_cod_curso integer, in_nombre_curso character varying, in_descripcion character varying, in_estado boolean, in_usr_registro character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
UPDATE CURSOS SET NOMBRE= UPPER(IN_NOMBRE_CURSO),
				  DESCRIPCION = UPPER(IN_DESCRIPCION),
				  ESTADO= IN_ESTADO,
				  USR_REGISTRO=IN_USR_REGISTRO
				  WHERE COD_CURSO = IN_COD_CURSO;
END;
$$;
 �   DROP PROCEDURE public.sp_actualizar_curso(in_cod_curso integer, in_nombre_curso character varying, in_descripcion character varying, in_estado boolean, in_usr_registro character varying);
       public          postgres    false                       1255    88602 7   sp_actualizar_dni(character varying, character varying) 	   PROCEDURE       CREATE PROCEDURE public.sp_actualizar_dni(in_dni character varying, in_uid character varying)
    LANGUAGE plpgsql
    AS $$
DECLARE
IDENTIDAD VARCHAR;
BEGIN
IF (SELECT PERSONA.DNI FROM PERSONA WHERE PERSONA.UID=IN_UID)=IN_DNI THEN
UPDATE PERSONA SET DNI = IN_DNI WHERE PERSONA.UID=IN_UID;
ELSEIF (SELECT PERSONA.UID FROM PERSONA WHERE PERSONA.DNI=IN_DNI)<>IN_UID THEN
RAISE EXCEPTION USING HINT = 'Número de identidad ya se encuentra registrado';
ELSE 
UPDATE PERSONA SET DNI = IN_DNI WHERE PERSONA.UID=IN_UID;
END IF;
END;
$$;
 ]   DROP PROCEDURE public.sp_actualizar_dni(in_dni character varying, in_uid character varying);
       public          postgres    false                       1255    88601   sp_actualizar_familiar(character varying, character varying, character varying, character varying, character, date, character varying, character varying, json, character varying, character varying, boolean, character varying, character varying, character varying, character varying) 	   PROCEDURE       CREATE PROCEDURE public.sp_actualizar_familiar(in_dni character varying, in_primer_nombre character varying, in_primer_apellido character varying, in_nacionalidad character varying, in_sexo character, in_fec_nacimiento date, in_usr_registro character varying, in_direccion character varying, in_telefonos json, in_lugar_trabajo character varying, in_ocupacion character varying, in_encargado boolean, in_escolaridad character varying, in_uid character varying, in_segundo_nombre character varying DEFAULT ''::character varying, in_segundo_apellido character varying DEFAULT ''::character varying)
    LANGUAGE plpgsql
    AS $$
DECLARE CODIGO_PERSONA INT;
		CODIGO_DIRECCION INT;
		CODIGO_TELEFONO INT;	
		i JSON;
	

BEGIN
--PERSONA
IF NOT EXISTS(SELECT PERSONA.UID FROM PERSONA WHERE UID=IN_UID)THEN
RAISE EXCEPTION USING HINT ='Identificador manipulado';
RETURN;
END IF;

CODIGO_PERSONA :=(SELECT COD_PERSONA FROM PERSONA WHERE UID=IN_UID);

IF (SELECT PERSONA.UID FROM PERSONA WHERE PERSONA.DNI=IN_DNI)<>IN_UID THEN
RAISE EXCEPTION USING HINT = 'Número de identidad ya se encuentra registrado';
END IF;


UPDATE PERSONA 
	   SET 
	   DNI=IN_DNI,
	   PRIMER_NOMBRE=IN_PRIMER_NOMBRE,
	   SEGUNDO_NOMBRE=IN_SEGUNDO_NOMBRE,
	   PRIMER_APELLIDO=IN_PRIMER_APELLIDO,
	   SEGUNDO_APELLIDO=IN_SEGUNDO_APELLIDO,
	   NACIONALIDAD=IN_NACIONALIDAD,
	   SEXO=IN_SEXO,
	   FEC_NACIMIENTO=IN_FEC_NACIMIENTO
	   WHERE PERSONA.UID=IN_UID;
	   
UPDATE FAMILIARES SET
	   LUGAR_TRABAJO = IN_LUGAR_TRABAJO,
	   OCUPACION= IN_OCUPACION,
	   ENCARGADO= IN_ENCARGADO,
	   ESCOLARIDAD= IN_ESCOLARIDAD 
	   WHERE COD_PERSONA = CODIGO_PERSONA;
		
--DIRECCION
CODIGO_DIRECCION :=(SELECT COD_DIRECCION FROM DIRECCION_PERSONA WHERE DIRECCION_PERSONA.COD_PERSONA= CODIGO_PERSONA);

UPDATE DIRECCION SET DIRECCION = IN_DIRECCION WHERE COD_DIRECCION = CODIGO_DIRECCION;


--NUMEROS DE TELEFONO
   FOR i IN SELECT * FROM json_array_elements(IN_TELEFONOS)
   LOOP
    
	IF EXISTS(SELECT COD_TELEFONO FROM TELEFONO WHERE COD_TELEFONO = CAST(i->>'cod_telefono' AS INT))THEN
	UPDATE TELEFONO SET TELEFONO = i->>'telefono',
						EMERGENCIA =CAST(i->>'emergencia' AS BOOLEAN),
						WHATSAPP =  CAST(i->>'whatsapp'AS BOOLEAN),
						COD_TIPO_TELEFONO= CAST(i->>'cod_tipo_telefono' AS INT)
						WHERE COD_TELEFONO= CAST(i->>'cod_telefono' AS INT);
	ELSE
	INSERT INTO TELEFONO(TELEFONO,COD_TIPO_TELEFONO,WHATSAPP,EMERGENCIA,USR_REGISTRO,FEC_REGISTRO)
	VALUES(i->>'telefono',CAST(i->>'cod_tipo_telefono' AS INT),
		   				  CAST(i->>'whatsapp'AS BOOLEAN),CAST(i->>'emergencia' AS BOOLEAN),
		   				  IN_USR_REGISTRO,CURRENT_DATE);
	
	CODIGO_TELEFONO:=(SELECT MAX(COD_TELEFONO) FROM TELEFONO);
	
	--TELEFONO-PERSONA
	INSERT INTO TELEFONO_PERSONA(COD_TELEFONO,COD_PERSONA)
	VALUES(CODIGO_TELEFONO,CODIGO_PERSONA);
	END IF;	
   END LOOP;
	COMMIT;
END;
$$;
   DROP PROCEDURE public.sp_actualizar_familiar(in_dni character varying, in_primer_nombre character varying, in_primer_apellido character varying, in_nacionalidad character varying, in_sexo character, in_fec_nacimiento date, in_usr_registro character varying, in_direccion character varying, in_telefonos json, in_lugar_trabajo character varying, in_ocupacion character varying, in_encargado boolean, in_escolaridad character varying, in_uid character varying, in_segundo_nombre character varying, in_segundo_apellido character varying);
       public          postgres    false                       1255    88644    sp_eliminar_curso(integer) 	   PROCEDURE     �   CREATE PROCEDURE public.sp_eliminar_curso(in_cod_curso integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
UPDATE CURSOS SET ESTADO =FALSE WHERE COD_CURSO =IN_COD_CURSO;
END;
$$;
 ?   DROP PROCEDURE public.sp_eliminar_curso(in_cod_curso integer);
       public          postgres    false                       1255    88604    sp_eliminar_telefono(integer) 	   PROCEDURE     �   CREATE PROCEDURE public.sp_eliminar_telefono(in_id integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
UPDATE TELEFONO SET ESTADO = FALSE WHERE COD_TELEFONO = IN_ID;
END;
$$;
 ;   DROP PROCEDURE public.sp_eliminar_telefono(in_id integer);
       public          postgres    false                       1255    88640 P   sp_nuevo_curso(character varying, character varying, boolean, character varying) 	   PROCEDURE     �  CREATE PROCEDURE public.sp_nuevo_curso(in_nombre character varying, in_descripcion character varying, in_estado boolean, in_usr_registro character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO CURSOS(NOMBRE,DESCRIPCION,ESTADO,USR_REGISTRO,FEC_REGISTRO)
			VALUES(UPPER(IN_NOMBRE),UPPER(IN_DESCRIPCION),IN_ESTADO,IN_USR_REGISTRO,CURRENT_DATE);
			exception 
	   when sqlstate '23505' then 
	      raise exception using hint = 'El curso ingresado ya existe';
END;
$$;
 �   DROP PROCEDURE public.sp_nuevo_curso(in_nombre character varying, in_descripcion character varying, in_estado boolean, in_usr_registro character varying);
       public          postgres    false                       1255    88581   sp_persona_alumno(integer, character varying, character varying, character varying, character varying, character, date, character varying, character varying, character varying, character, character varying, character varying, character varying, character varying) 	   PROCEDURE     1  CREATE PROCEDURE public.sp_persona_alumno(in_cod_tipo_persona integer, in_dni character varying, in_primer_nombre character varying, in_primer_apellido character varying, in_nacionalidad character varying, in_sexo character, in_fec_nacimiento date, in_usr_registro character varying, in_direccion character varying, in_enfermedad character varying, in_vive character, in_uid character varying, in_grupo character varying, in_segundo_nombre character varying DEFAULT ''::character varying, in_segundo_apellido character varying DEFAULT ''::character varying)
    LANGUAGE plpgsql
    AS $$
DECLARE CODIGO_PERSONA INT;
		CODIGO_DIRECCION INT;
		CODIGO_ALUMNO INT;
BEGIN
--PERSONA

IF EXISTS(SELECT PERSONA.DNI FROM PERSONA WHERE PERSONA.DNI=IN_DNI) THEN
RAISE EXCEPTION USING HINT ='Esta persona ya se encuentra registrada';
RETURN;
END IF;

INSERT INTO PERSONA(COD_TIPO_PERSONA,DNI,PRIMER_NOMBRE,SEGUNDO_NOMBRE,PRIMER_APELLIDO,SEGUNDO_APELLIDO,
					NACIONALIDAD,SEXO,FEC_NACIMIENTO,UID,USR_REGISTRO,FEC_REGISTRO)
VALUES(IN_COD_TIPO_PERSONA,IN_DNI,IN_PRIMER_NOMBRE,IN_SEGUNDO_NOMBRE,IN_PRIMER_APELLIDO,IN_SEGUNDO_APELLIDO,
	   IN_NACIONALIDAD,IN_SEXO,IN_FEC_NACIMIENTO,IN_UID,IN_USR_REGISTRO,CURRENT_DATE);				
					
CODIGO_PERSONA:= (SELECT MAX(COD_PERSONA) FROM PERSONA);


--DIRECCION

INSERT INTO DIRECCION(DIRECCION,USR_REGISTRO,FEC_REGISTRO)
VALUES(IN_DIRECCION,IN_USR_REGISTRO,CURRENT_DATE);

CODIGO_DIRECCION:=(SELECT MAX(COD_DIRECCION) FROM DIRECCION);

--DIRECCION-PERSONA
INSERT INTO DIRECCION_PERSONA(COD_PERSONA,COD_DIRECCION)
VALUES (CODIGO_PERSONA,CODIGO_DIRECCION);
   
 --ALUMNO
 INSERT INTO ALUMNOS(COD_PERSONA,ENFERMEDAD,VIVE_CON)
 VALUES(CODIGO_PERSONA,IN_ENFERMEDAD,IN_VIVE);
 
 CODIGO_ALUMNO:= (SELECT MAX(COD_ALUMNO) FROM ALUMNOS);
 
IF NOT EXISTS(SELECT GRUPO_FAMILIAR.NOMBRE FROM GRUPO_FAMILIAR WHERE NOMBRE = IN_GRUPO)THEN
ROLLBACK;
RAISE EXCEPTION USING HINT ='No existe el grupo familiar ingresado';
ELSE 
UPDATE ALUMNOS SET COD_GRUPO=(SELECT GRUPO_FAMILIAR.COD_GRUPO FROM GRUPO_FAMILIAR WHERE NOMBRE =IN_GRUPO)
WHERE COD_ALUMNO =CODIGO_ALUMNO;
END IF;
COMMIT;
END;
$$;
 �  DROP PROCEDURE public.sp_persona_alumno(in_cod_tipo_persona integer, in_dni character varying, in_primer_nombre character varying, in_primer_apellido character varying, in_nacionalidad character varying, in_sexo character, in_fec_nacimiento date, in_usr_registro character varying, in_direccion character varying, in_enfermedad character varying, in_vive character, in_uid character varying, in_grupo character varying, in_segundo_nombre character varying, in_segundo_apellido character varying);
       public          postgres    false                       1255    88582 <  sp_persona_familiar(integer, character varying, character varying, character varying, character varying, character, date, character varying, character varying, json, character varying, character varying, boolean, character varying, character varying, boolean, character varying, character varying, character varying) 	   PROCEDURE     �  CREATE PROCEDURE public.sp_persona_familiar(in_cod_tipo_persona integer, in_dni character varying, in_primer_nombre character varying, in_primer_apellido character varying, in_nacionalidad character varying, in_sexo character, in_fec_nacimiento date, in_usr_registro character varying, in_direccion character varying, in_telefonos json, in_lugar_trabajo character varying, in_ocupacion character varying, in_encargado boolean, in_escolaridad character varying, in_uid character varying, in_crear_grupo boolean, in_grupo character varying DEFAULT ''::character varying, in_segundo_nombre character varying DEFAULT ''::character varying, in_segundo_apellido character varying DEFAULT ''::character varying)
    LANGUAGE plpgsql
    AS $$
DECLARE CODIGO_PERSONA INT;
		CODIGO_DIRECCION INT;
		CODIGO_TELEFONO INT;	
		i JSON;
	

BEGIN
--PERSONA

IF EXISTS(SELECT PERSONA.DNI FROM PERSONA WHERE PERSONA.DNI=IN_DNI) THEN
RAISE EXCEPTION USING HINT ='Esta persona ya se encuentra registrada';
RETURN;
END IF;

INSERT INTO PERSONA(COD_TIPO_PERSONA,DNI,PRIMER_NOMBRE,SEGUNDO_NOMBRE,PRIMER_APELLIDO,SEGUNDO_APELLIDO,
					NACIONALIDAD,SEXO,FEC_NACIMIENTO,UID,USR_REGISTRO,FEC_REGISTRO)
VALUES(IN_COD_TIPO_PERSONA,IN_DNI,IN_PRIMER_NOMBRE,IN_SEGUNDO_NOMBRE,IN_PRIMER_APELLIDO,IN_SEGUNDO_APELLIDO,
	   IN_NACIONALIDAD,IN_SEXO,IN_FEC_NACIMIENTO,IN_UID,IN_USR_REGISTRO,CURRENT_DATE);				
					
CODIGO_PERSONA:= (SELECT MAX(COD_PERSONA) FROM PERSONA);


--DIRECCION

INSERT INTO DIRECCION(DIRECCION,USR_REGISTRO,FEC_REGISTRO)
VALUES(IN_DIRECCION,IN_USR_REGISTRO,CURRENT_DATE);

CODIGO_DIRECCION:=(SELECT MAX(COD_DIRECCION) FROM DIRECCION);

--DIRECCION-PERSONA
INSERT INTO DIRECCION_PERSONA(COD_PERSONA,COD_DIRECCION)
VALUES (CODIGO_PERSONA,CODIGO_DIRECCION);

--NUMEROS DE TELEFONO
   FOR i IN SELECT * FROM json_array_elements(IN_TELEFONOS)
   LOOP
    INSERT INTO TELEFONO(TELEFONO,COD_TIPO_TELEFONO,WHATSAPP,EMERGENCIA,USR_REGISTRO,FEC_REGISTRO)
	VALUES(i->>'telefono',CAST(i->>'cod_tipo_telefono' AS INT),
		   				  CAST(i->>'whatsapp'AS BOOLEAN),CAST(i->>'emergencia' AS BOOLEAN),
		   				  IN_USR_REGISTRO,CURRENT_DATE);
	
	CODIGO_TELEFONO:=(SELECT MAX(COD_TELEFONO) FROM TELEFONO);
	
	--TELEFONO-PERSONA
	INSERT INTO TELEFONO_PERSONA(COD_TELEFONO,COD_PERSONA)
	VALUES(CODIGO_TELEFONO,CODIGO_PERSONA);
   END LOOP;

IF IN_CREAR_GRUPO=TRUE THEN
	INSERT INTO GRUPO_FAMILIAR(NOMBRE,USR_REGISTRO,FEC_REGISTRO)
	VALUES (IN_DNI,IN_USR_REGISTRO,CURRENT_DATE);

--AGREGAR EL GRUPO FAMILIAR CREADO
	INSERT INTO FAMILIARES(COD_PERSONA,COD_GRUPO,LUGAR_TRABAJO,ENCARGADO,OCUPACION,ESCOLARIDAD)
	VALUES(CODIGO_PERSONA,(SELECT GRUPO_FAMILIAR.COD_GRUPO FROM GRUPO_FAMILIAR WHERE NOMBRE = IN_DNI),
	IN_LUGAR_TRABAJO,IN_ENCARGADO, IN_OCUPACION,IN_ESCOLARIDAD);
	
ELSEIF CHARACTER_LENGTH(IN_GRUPO)>=13  AND EXISTS (SELECT GRUPO_FAMILIAR.NOMBRE FROM GRUPO_FAMILIAR WHERE NOMBRE=IN_GRUPO) THEN
	INSERT INTO FAMILIARES(COD_PERSONA,COD_GRUPO,LUGAR_TRABAJO,ENCARGADO,OCUPACION,ESCOLARIDAD)
	VALUES(CODIGO_PERSONA,(SELECT GRUPO_FAMILIAR.COD_GRUPO FROM GRUPO_FAMILIAR WHERE NOMBRE = IN_GRUPO),
	IN_LUGAR_TRABAJO,IN_ENCARGADO, IN_OCUPACION,IN_ESCOLARIDAD);
	
ELSE
	ROLLBACK;
	RAISE EXCEPTION USING HINT = 'No existe el grupo familiar ingresado';	
END IF;
	COMMIT;
END;
$$;
 f  DROP PROCEDURE public.sp_persona_familiar(in_cod_tipo_persona integer, in_dni character varying, in_primer_nombre character varying, in_primer_apellido character varying, in_nacionalidad character varying, in_sexo character, in_fec_nacimiento date, in_usr_registro character varying, in_direccion character varying, in_telefonos json, in_lugar_trabajo character varying, in_ocupacion character varying, in_encargado boolean, in_escolaridad character varying, in_uid character varying, in_crear_grupo boolean, in_grupo character varying, in_segundo_nombre character varying, in_segundo_apellido character varying);
       public          postgres    false                       1255    88575 �   sp_persona_usuario(integer, character varying, character varying, character varying, character varying, character, date, character varying, character varying, character varying, json, character varying, character varying, character varying) 	   PROCEDURE     �	  CREATE PROCEDURE public.sp_persona_usuario(in_cod_tipo_persona integer, in_dni character varying, in_primer_nombre character varying, in_primer_apellido character varying, in_nacionalidad character varying, in_sexo character, in_fec_nacimiento date, in_usr_registro character varying, in_correo character varying, in_direccion character varying, in_telefonos json, in_uid character varying, in_segundo_nombre character varying DEFAULT ''::character varying, in_segundo_apellido character varying DEFAULT ''::character varying)
    LANGUAGE plpgsql
    AS $$
DECLARE CODIGO_PERSONA INT;
		CODIGO_DIRECCION INT;
		CODIGO_TELEFONO INT;
		CODIGO_CORREO INT;
		i JSON;
	

BEGIN
--PERSONA

IF EXISTS(SELECT PERSONA.DNI FROM PERSONA WHERE PERSONA.DNI=IN_DNI) THEN
RAISE EXCEPTION USING HINT ='DNI ya está registrado';
RETURN;
END IF;

INSERT INTO PERSONA(COD_TIPO_PERSONA,DNI,PRIMER_NOMBRE,SEGUNDO_NOMBRE,PRIMER_APELLIDO,SEGUNDO_APELLIDO,
					NACIONALIDAD,SEXO,FEC_NACIMIENTO,USR_REGISTRO,FEC_REGISTRO,UID)
VALUES(IN_COD_TIPO_PERSONA,IN_DNI,IN_PRIMER_NOMBRE,IN_SEGUNDO_NOMBRE,IN_PRIMER_APELLIDO,IN_SEGUNDO_APELLIDO,
	   IN_NACIONALIDAD,IN_SEXO,IN_FEC_NACIMIENTO,IN_USR_REGISTRO,CURRENT_DATE,IN_UID);				
					
CODIGO_PERSONA:= (SELECT MAX(COD_PERSONA) FROM PERSONA);

--CORREO
IF EXISTS(SELECT CORREO.CORREO FROM CORREO WHERE CORREO.CORREO = IN_CORREO)THEN
RAISE EXCEPTION USING HINT = 'Correo ya está registrado';
RETURN;
END IF;

INSERT INTO CORREO(CORREO,USR_REGISTRO,FEC_REGISTRO)
VALUES(IN_CORREO,IN_USR_REGISTRO,CURRENT_DATE);

CODIGO_CORREO:= (SELECT MAX(COD_CORREO) FROM CORREO);

--CORREO-PERSONA
INSERT INTO CORREO_PERSONA(COD_PERSONA,COD_CORREO)
VALUES(CODIGO_PERSONA,CODIGO_CORREO);

--DIRECCION

INSERT INTO DIRECCION(DIRECCION,USR_REGISTRO,FEC_REGISTRO)
VALUES(IN_DIRECCION,IN_USR_REGISTRO,CURRENT_DATE);

CODIGO_DIRECCION:=(SELECT MAX(COD_DIRECCION) FROM DIRECCION);

--DIRECCION-PERSONA
INSERT INTO DIRECCION_PERSONA(COD_PERSONA,COD_DIRECCION)
VALUES (CODIGO_PERSONA,CODIGO_DIRECCION);

--NUMEROS DE TELEFONO
   FOR i IN SELECT * FROM json_array_elements(IN_TELEFONOS)
   LOOP
    INSERT INTO TELEFONO(TELEFONO,COD_TIPO_TELEFONO,WHATSAPP,EMERGENCIA,USR_REGISTRO,FEC_REGISTRO)
	VALUES(i->>'telefono',CAST(i->>'cod_tipo_telefono' AS INT),'false','false',IN_USR_REGISTRO,CURRENT_DATE);
	
	CODIGO_TELEFONO:=(SELECT MAX(COD_TELEFONO) FROM TELEFONO);
	
	--TELEFONO-PERSONA
	INSERT INTO TELEFONO_PERSONA(COD_TELEFONO,COD_PERSONA)
	VALUES(CODIGO_TELEFONO,CODIGO_PERSONA);
   END LOOP;

END;
$$;
 �  DROP PROCEDURE public.sp_persona_usuario(in_cod_tipo_persona integer, in_dni character varying, in_primer_nombre character varying, in_primer_apellido character varying, in_nacionalidad character varying, in_sexo character, in_fec_nacimiento date, in_usr_registro character varying, in_correo character varying, in_direccion character varying, in_telefonos json, in_uid character varying, in_segundo_nombre character varying, in_segundo_apellido character varying);
       public          postgres    false                       1255    88594 ,   sp_update_telefonos(json, character varying) 	   PROCEDURE     �  CREATE PROCEDURE public.sp_update_telefonos(in_telefonos json, in_usr_registro character varying)
    LANGUAGE plpgsql
    AS $$
DECLARE 
 i json;
 CODIGO_TELEFONO INT;
 CODIGO_PERSONA INT;

BEGIN

CODIGO_PERSONA=1;
--NUMEROS DE TELEFONO
   FOR i IN SELECT * FROM json_array_elements(IN_TELEFONOS)
   LOOP
    
	IF EXISTS(SELECT COD_TELEFONO FROM TELEFONO WHERE COD_TELEFONO = CAST(i->>'cod_telefono'AS INT))THEN

	UPDATE TELEFONO SET TELEFONO = i->>'telefono' WHERE COD_TELEFONO= CAST(i->>'cod_telefono'AS INT);
	ELSE
	INSERT INTO TELEFONO(TELEFONO,COD_TIPO_TELEFONO,WHATSAPP,EMERGENCIA,USR_REGISTRO,FEC_REGISTRO)
	VALUES(i->>'telefono',CAST(i->>'cod_tipo_telefono' AS INT),
		   				  CAST(i->>'whatsapp'AS BOOLEAN),CAST(i->>'emergencia' AS BOOLEAN),
		   				  IN_USR_REGISTRO,CURRENT_DATE);
	
	CODIGO_TELEFONO:=(SELECT MAX(COD_TELEFONO) FROM TELEFONO);
	
	--TELEFONO-PERSONA
	INSERT INTO TELEFONO_PERSONA(COD_TELEFONO,COD_PERSONA)
	VALUES(CODIGO_TELEFONO,CODIGO_PERSONA);
	END IF;	
   END LOOP;
END;
$$;
 a   DROP PROCEDURE public.sp_update_telefonos(in_telefonos json, in_usr_registro character varying);
       public          postgres    false            �            1259    88291    alumnos    TABLE     �   CREATE TABLE public.alumnos (
    cod_alumno integer NOT NULL,
    cod_persona integer NOT NULL,
    cod_grupo integer,
    enfermedad character varying(300),
    vive_con character(1),
    motivo_retiro character varying(200),
    estado boolean
);
    DROP TABLE public.alumnos;
       public            postgres    false            �            1259    88289    alumnos_cod_alumno_seq    SEQUENCE     �   ALTER TABLE public.alumnos ALTER COLUMN cod_alumno ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.alumnos_cod_alumno_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    223            �            1259    88500    bitacora    TABLE     
  CREATE TABLE public.bitacora (
    cod_registro integer NOT NULL,
    accion character varying(20),
    valor_anterior character varying(300),
    valor_actual character varying(300),
    usr_registro character varying(50),
    fec_registro character varying(50)
);
    DROP TABLE public.bitacora;
       public            postgres    false            �            1259    88498    bitacora_cod_registro_seq    SEQUENCE     �   ALTER TABLE public.bitacora ALTER COLUMN cod_registro ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.bitacora_cod_registro_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    248            �            1259    88626 	   clausulas    TABLE     �   CREATE TABLE public.clausulas (
    cod_clausula integer NOT NULL,
    cod_contrato integer NOT NULL,
    nombre character varying(40),
    contenido character varying(300),
    usr_registro character varying(50),
    fec_registro date
);
    DROP TABLE public.clausulas;
       public            postgres    false            �            1259    88624    clausulas_cod_clausula_seq    SEQUENCE     �   ALTER TABLE public.clausulas ALTER COLUMN cod_clausula ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.clausulas_cod_clausula_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    255            �            1259    88170    colegio    TABLE     �   CREATE TABLE public.colegio (
    cod_colegio integer NOT NULL,
    nombre character varying(200) NOT NULL,
    estado boolean DEFAULT true NOT NULL,
    usr_registro character varying(50) NOT NULL,
    fec_registro date NOT NULL
);
    DROP TABLE public.colegio;
       public            postgres    false            �            1259    88168    colegio_cod_colegio_seq    SEQUENCE     �   ALTER TABLE public.colegio ALTER COLUMN cod_colegio ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.colegio_cod_colegio_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    201            �            1259    88614 	   contratos    TABLE     ?  CREATE TABLE public.contratos (
    cod_contrato integer NOT NULL,
    cod_curso integer,
    nombre character varying(100) NOT NULL,
    descripcion character varying(100) NOT NULL,
    anio date NOT NULL,
    estado boolean NOT NULL,
    usr_registro character varying(50) NOT NULL,
    fec_registro date NOT NULL
);
    DROP TABLE public.contratos;
       public            postgres    false            �            1259    88612    contratos_cod_contrato_seq    SEQUENCE     �   ALTER TABLE public.contratos ALTER COLUMN cod_contrato ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.contratos_cod_contrato_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    253            �            1259    88199    correo    TABLE     �   CREATE TABLE public.correo (
    cod_correo integer NOT NULL,
    correo character varying(100),
    usr_registro character varying(50) NOT NULL,
    fec_registro date
);
    DROP TABLE public.correo;
       public            postgres    false            �            1259    88197    correo_cod_correo_seq    SEQUENCE     �   ALTER TABLE public.correo ALTER COLUMN cod_correo ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.correo_cod_correo_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    207            �            1259    88206    correo_persona    TABLE     �   CREATE TABLE public.correo_persona (
    cod_cor_per integer NOT NULL,
    cod_persona integer NOT NULL,
    cod_correo integer NOT NULL
);
 "   DROP TABLE public.correo_persona;
       public            postgres    false            �            1259    88204    correo_persona_cod_cor_per_seq    SEQUENCE     �   ALTER TABLE public.correo_persona ALTER COLUMN cod_cor_per ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.correo_persona_cod_cor_per_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    209            �            1259    88156    cursos    TABLE     #  CREATE TABLE public.cursos (
    cod_curso integer NOT NULL,
    cod_seccion integer,
    nombre character varying(100) NOT NULL,
    descripcion character varying(200) NOT NULL,
    estado boolean NOT NULL,
    usr_registro character varying(50) NOT NULL,
    fec_registro date NOT NULL
);
    DROP TABLE public.cursos;
       public            postgres    false            �            1259    88154    cursos_cod_curso_seq    SEQUENCE     �   ALTER TABLE public.cursos ALTER COLUMN cod_curso ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.cursos_cod_curso_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    199            �            1259    88223 	   direccion    TABLE     �   CREATE TABLE public.direccion (
    cod_direccion integer NOT NULL,
    direccion character varying(300) NOT NULL,
    usr_registro character varying(50) NOT NULL,
    fec_registro date NOT NULL
);
    DROP TABLE public.direccion;
       public            postgres    false            �            1259    88221    direccion_cod_direccion_seq    SEQUENCE     �   ALTER TABLE public.direccion ALTER COLUMN cod_direccion ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.direccion_cod_direccion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    211            �            1259    88230    direccion_persona    TABLE     �   CREATE TABLE public.direccion_persona (
    cod_dir_per integer NOT NULL,
    cod_persona integer NOT NULL,
    cod_direccion integer NOT NULL
);
 %   DROP TABLE public.direccion_persona;
       public            postgres    false            �            1259    88228 !   direccion_persona_cod_dir_per_seq    SEQUENCE     �   ALTER TABLE public.direccion_persona ALTER COLUMN cod_dir_per ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.direccion_persona_cod_dir_per_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    213            �            1259    88408    estado    TABLE     p   CREATE TABLE public.estado (
    cod_estado integer NOT NULL,
    descripcion character varying(20) NOT NULL
);
    DROP TABLE public.estado;
       public            postgres    false            �            1259    88406    estado_cod_estado_seq    SEQUENCE     �   ALTER TABLE public.estado ALTER COLUMN cod_estado ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.estado_cod_estado_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    239            �            1259    88364 
   expediente    TABLE       CREATE TABLE public.expediente (
    cod_expediente integer NOT NULL,
    cod_alumno integer NOT NULL,
    cod_colegio integer NOT NULL,
    cod_curso integer NOT NULL,
    anio date NOT NULL,
    usr_registro character varying(50) NOT NULL,
    fec_registro date NOT NULL
);
    DROP TABLE public.expediente;
       public            postgres    false            �            1259    88362    expediente_cod_expediente_seq    SEQUENCE     �   ALTER TABLE public.expediente ALTER COLUMN cod_expediente ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.expediente_cod_expediente_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    231            �            1259    88308 
   familiares    TABLE       CREATE TABLE public.familiares (
    cod_familiar integer NOT NULL,
    cod_persona integer NOT NULL,
    cod_grupo integer,
    lugar_trabajo character varying(100),
    ocupacion character varying(100),
    escolaridad character varying(100),
    encargado boolean
);
    DROP TABLE public.familiares;
       public            postgres    false            �            1259    88306    familiares_cod_familiar_seq    SEQUENCE     �   ALTER TABLE public.familiares ALTER COLUMN cod_familiar ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.familiares_cod_familiar_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    225            �            1259    88284    grupo_familiar    TABLE     �   CREATE TABLE public.grupo_familiar (
    cod_grupo integer NOT NULL,
    nombre character varying(75) NOT NULL,
    usr_registro character varying(50) NOT NULL,
    fec_registro date NOT NULL
);
 "   DROP TABLE public.grupo_familiar;
       public            postgres    false            �            1259    88282    grupo_familiar_cod_grupo_seq    SEQUENCE     �   ALTER TABLE public.grupo_familiar ALTER COLUMN cod_grupo ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.grupo_familiar_cod_grupo_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    221            �            1259    88474    historial_contrasena    TABLE     �   CREATE TABLE public.historial_contrasena (
    cod_hist integer NOT NULL,
    cod_usuario integer NOT NULL,
    contrasena character varying(100) NOT NULL,
    usr_registro character varying(50) NOT NULL,
    fec_registro date NOT NULL
);
 (   DROP TABLE public.historial_contrasena;
       public            postgres    false            �            1259    88472 !   historial_contrasena_cod_hist_seq    SEQUENCE     �   ALTER TABLE public.historial_contrasena ALTER COLUMN cod_hist ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.historial_contrasena_cod_hist_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    246            �            1259    88332 	   matricula    TABLE     [  CREATE TABLE public.matricula (
    cod_matricula integer NOT NULL,
    cod_tipo_matricula integer NOT NULL,
    cod_alumno integer NOT NULL,
    cod_curso integer NOT NULL,
    cod_seccion integer NOT NULL,
    cod_grupo integer NOT NULL,
    anio date NOT NULL,
    usr_registro character varying(50) NOT NULL,
    fec_registro date NOT NULL
);
    DROP TABLE public.matricula;
       public            postgres    false            �            1259    88330    matricula_cod_matricula_seq    SEQUENCE     �   ALTER TABLE public.matricula ALTER COLUMN cod_matricula ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.matricula_cod_matricula_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    229            �            1259    88386 	   pantallas    TABLE     F  CREATE TABLE public.pantallas (
    cod_pantalla integer NOT NULL,
    nombre character varying(75) NOT NULL,
    url character varying(35) NOT NULL,
    check_pantalla character varying(35) NOT NULL,
    estado boolean DEFAULT true NOT NULL,
    usr_registro character varying(50) NOT NULL,
    fec_registro date NOT NULL
);
    DROP TABLE public.pantallas;
       public            postgres    false            �            1259    88384    pantallas_cod_pantalla_seq    SEQUENCE     �   ALTER TABLE public.pantallas ALTER COLUMN cod_pantalla ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.pantallas_cod_pantalla_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    233            �            1259    88510 
   parametros    TABLE     �   CREATE TABLE public.parametros (
    cod_parametro integer NOT NULL,
    parametro character varying(40),
    valor character varying(100),
    usr_registro character varying(50),
    fec_registro date
);
    DROP TABLE public.parametros;
       public            postgres    false            �            1259    88508    parametros_cod_parametro_seq    SEQUENCE     �   ALTER TABLE public.parametros ALTER COLUMN cod_parametro ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.parametros_cod_parametro_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    250            �            1259    88452    permiso_pantalla_rol    TABLE       CREATE TABLE public.permiso_pantalla_rol (
    cod_pan_rol integer NOT NULL,
    cod_pantalla integer NOT NULL,
    cod_permiso integer NOT NULL,
    cod_rol integer NOT NULL,
    estado boolean,
    usr_registro character varying(50) NOT NULL,
    fec_registro date NOT NULL
);
 (   DROP TABLE public.permiso_pantalla_rol;
       public            postgres    false            �            1259    88450 $   permiso_pantalla_rol_cod_pan_rol_seq    SEQUENCE     �   ALTER TABLE public.permiso_pantalla_rol ALTER COLUMN cod_pan_rol ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.permiso_pantalla_rol_cod_pan_rol_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    244            �            1259    88401    permisos    TABLE     n   CREATE TABLE public.permisos (
    cod_permiso integer NOT NULL,
    nombre character varying(20) NOT NULL
);
    DROP TABLE public.permisos;
       public            postgres    false            �            1259    88399    permisos_cod_permiso_seq    SEQUENCE     �   ALTER TABLE public.permisos ALTER COLUMN cod_permiso ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.permisos_cod_permiso_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    237            �            1259    88187    persona    TABLE     '  CREATE TABLE public.persona (
    cod_persona integer NOT NULL,
    cod_tipo_persona integer NOT NULL,
    uid character varying(50),
    dni character varying(30) NOT NULL,
    primer_nombre character varying(50) NOT NULL,
    segundo_nombre character varying(50),
    primer_apellido character varying(50) NOT NULL,
    segundo_apellido character varying(50),
    sexo character(1) NOT NULL,
    fec_nacimiento date NOT NULL,
    usr_registro character varying(50) NOT NULL,
    fec_registro date NOT NULL,
    nacionalidad character varying(50)
);
    DROP TABLE public.persona;
       public            postgres    false            �            1259    88185    persona_cod_persona_seq    SEQUENCE     �   ALTER TABLE public.persona ALTER COLUMN cod_persona ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.persona_cod_persona_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    205            �            1259    88544    prueba    TABLE     ;   CREATE TABLE public.prueba (
    dato character varying
);
    DROP TABLE public.prueba;
       public            postgres    false            �            1259    88394    roles    TABLE     �   CREATE TABLE public.roles (
    cod_rol integer NOT NULL,
    nombre character varying(20) NOT NULL,
    descripcion character varying(250) NOT NULL,
    usr_registro character varying(50) NOT NULL,
    fec_registro date NOT NULL
);
    DROP TABLE public.roles;
       public            postgres    false            �            1259    88392    roles_cod_rol_seq    SEQUENCE     �   ALTER TABLE public.roles ALTER COLUMN cod_rol ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.roles_cod_rol_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    235            �            1259    88146 	   secciones    TABLE       CREATE TABLE public.secciones (
    cod_seccion integer NOT NULL,
    nombre character(1) NOT NULL,
    cupos integer NOT NULL,
    estado boolean DEFAULT true NOT NULL,
    anio date NOT NULL,
    usr_registro character varying(50) NOT NULL,
    fec_registro date NOT NULL
);
    DROP TABLE public.secciones;
       public            postgres    false            �            1259    88144    secciones_cod_seccion_seq    SEQUENCE     �   ALTER TABLE public.secciones ALTER COLUMN cod_seccion ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.secciones_cod_seccion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    197            �            1259    88254    telefono    TABLE     P  CREATE TABLE public.telefono (
    cod_telefono integer NOT NULL,
    cod_tipo_telefono integer NOT NULL,
    telefono character varying(20) NOT NULL,
    whatsapp boolean DEFAULT false NOT NULL,
    usr_registro character varying(50) NOT NULL,
    fec_registro date NOT NULL,
    emergencia boolean,
    estado boolean DEFAULT true
);
    DROP TABLE public.telefono;
       public            postgres    false            �            1259    88252    telefono_cod_telefono_seq    SEQUENCE     �   ALTER TABLE public.telefono ALTER COLUMN cod_telefono ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.telefono_cod_telefono_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    217            �            1259    88267    telefono_persona    TABLE     �   CREATE TABLE public.telefono_persona (
    cod_tel_per integer NOT NULL,
    cod_telefono integer NOT NULL,
    cod_persona integer NOT NULL
);
 $   DROP TABLE public.telefono_persona;
       public            postgres    false            �            1259    88265     telefono_persona_cod_tel_per_seq    SEQUENCE     �   ALTER TABLE public.telefono_persona ALTER COLUMN cod_tel_per ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.telefono_persona_cod_tel_per_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    219            �            1259    88325    tipo_matricula    TABLE     �   CREATE TABLE public.tipo_matricula (
    cod_tipo_matricula integer NOT NULL,
    nombre character varying(75),
    usr_registro character varying(50),
    fec_registro date
);
 "   DROP TABLE public.tipo_matricula;
       public            postgres    false            �            1259    88323 %   tipo_matricula_cod_tipo_matricula_seq    SEQUENCE     �   ALTER TABLE public.tipo_matricula ALTER COLUMN cod_tipo_matricula ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.tipo_matricula_cod_tipo_matricula_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    227            �            1259    88180    tipo_persona    TABLE     �   CREATE TABLE public.tipo_persona (
    cod_tipo_persona integer NOT NULL,
    nombre character varying(50) NOT NULL,
    usr_registro character varying(50) NOT NULL,
    fec_registro date NOT NULL
);
     DROP TABLE public.tipo_persona;
       public            postgres    false            �            1259    88178 !   tipo_persona_cod_tipo_persona_seq    SEQUENCE     �   ALTER TABLE public.tipo_persona ALTER COLUMN cod_tipo_persona ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.tipo_persona_cod_tipo_persona_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    203            �            1259    88247    tipo_telefono    TABLE     �   CREATE TABLE public.tipo_telefono (
    cod_tipo_telefono integer NOT NULL,
    nombre character varying(100) NOT NULL,
    descripcion character varying(200) NOT NULL,
    usr_registro character varying(50) NOT NULL,
    fec_registro date NOT NULL
);
 !   DROP TABLE public.tipo_telefono;
       public            postgres    false            �            1259    88245 #   tipo_telefono_cod_tipo_telefono_seq    SEQUENCE     �   ALTER TABLE public.tipo_telefono ALTER COLUMN cod_tipo_telefono ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.tipo_telefono_cod_tipo_telefono_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    215            �            1259    88415    usuario    TABLE     �  CREATE TABLE public.usuario (
    cod_usuario integer NOT NULL,
    cod_persona integer NOT NULL,
    cod_estado integer NOT NULL,
    usuario character varying(50) NOT NULL,
    contrasena character varying(100) NOT NULL,
    primer_ingreso boolean DEFAULT false,
    tfa boolean DEFAULT false,
    secret character varying(50),
    qr text,
    usr_registro character varying(50) NOT NULL,
    fec_registro date NOT NULL
);
    DROP TABLE public.usuario;
       public            postgres    false            �            1259    88413    usuario_cod_usuario_seq    SEQUENCE     �   ALTER TABLE public.usuario ALTER COLUMN cod_usuario ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.usuario_cod_usuario_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    241            �            1259    88435    usuario_roles    TABLE     �   CREATE TABLE public.usuario_roles (
    cod_usuario integer NOT NULL,
    cod_rol integer NOT NULL,
    usr_registro character varying(50) NOT NULL,
    fec_registro date NOT NULL
);
 !   DROP TABLE public.usuario_roles;
       public            postgres    false            C          0    88291    alumnos 
   TABLE DATA           r   COPY public.alumnos (cod_alumno, cod_persona, cod_grupo, enfermedad, vive_con, motivo_retiro, estado) FROM stdin;
    public          postgres    false    223   �l      \          0    88500    bitacora 
   TABLE DATA           r   COPY public.bitacora (cod_registro, accion, valor_anterior, valor_actual, usr_registro, fec_registro) FROM stdin;
    public          postgres    false    248    m      c          0    88626 	   clausulas 
   TABLE DATA           n   COPY public.clausulas (cod_clausula, cod_contrato, nombre, contenido, usr_registro, fec_registro) FROM stdin;
    public          postgres    false    255   m      -          0    88170    colegio 
   TABLE DATA           Z   COPY public.colegio (cod_colegio, nombre, estado, usr_registro, fec_registro) FROM stdin;
    public          postgres    false    201   :m      a          0    88614 	   contratos 
   TABLE DATA           {   COPY public.contratos (cod_contrato, cod_curso, nombre, descripcion, anio, estado, usr_registro, fec_registro) FROM stdin;
    public          postgres    false    253   Wm      3          0    88199    correo 
   TABLE DATA           P   COPY public.correo (cod_correo, correo, usr_registro, fec_registro) FROM stdin;
    public          postgres    false    207   tm      5          0    88206    correo_persona 
   TABLE DATA           N   COPY public.correo_persona (cod_cor_per, cod_persona, cod_correo) FROM stdin;
    public          postgres    false    209   �m      +          0    88156    cursos 
   TABLE DATA           q   COPY public.cursos (cod_curso, cod_seccion, nombre, descripcion, estado, usr_registro, fec_registro) FROM stdin;
    public          postgres    false    199   &n      7          0    88223 	   direccion 
   TABLE DATA           Y   COPY public.direccion (cod_direccion, direccion, usr_registro, fec_registro) FROM stdin;
    public          postgres    false    211   o      9          0    88230    direccion_persona 
   TABLE DATA           T   COPY public.direccion_persona (cod_dir_per, cod_persona, cod_direccion) FROM stdin;
    public          postgres    false    213   Lp      S          0    88408    estado 
   TABLE DATA           9   COPY public.estado (cod_estado, descripcion) FROM stdin;
    public          postgres    false    239   �p      K          0    88364 
   expediente 
   TABLE DATA           z   COPY public.expediente (cod_expediente, cod_alumno, cod_colegio, cod_curso, anio, usr_registro, fec_registro) FROM stdin;
    public          postgres    false    231   �p      E          0    88308 
   familiares 
   TABLE DATA           |   COPY public.familiares (cod_familiar, cod_persona, cod_grupo, lugar_trabajo, ocupacion, escolaridad, encargado) FROM stdin;
    public          postgres    false    225   q      A          0    88284    grupo_familiar 
   TABLE DATA           W   COPY public.grupo_familiar (cod_grupo, nombre, usr_registro, fec_registro) FROM stdin;
    public          postgres    false    221   ,r      Z          0    88474    historial_contrasena 
   TABLE DATA           m   COPY public.historial_contrasena (cod_hist, cod_usuario, contrasena, usr_registro, fec_registro) FROM stdin;
    public          postgres    false    246   �r      I          0    88332 	   matricula 
   TABLE DATA           �   COPY public.matricula (cod_matricula, cod_tipo_matricula, cod_alumno, cod_curso, cod_seccion, cod_grupo, anio, usr_registro, fec_registro) FROM stdin;
    public          postgres    false    229   �r      M          0    88386 	   pantallas 
   TABLE DATA           r   COPY public.pantallas (cod_pantalla, nombre, url, check_pantalla, estado, usr_registro, fec_registro) FROM stdin;
    public          postgres    false    233   �r      ^          0    88510 
   parametros 
   TABLE DATA           a   COPY public.parametros (cod_parametro, parametro, valor, usr_registro, fec_registro) FROM stdin;
    public          postgres    false    250   �r      X          0    88452    permiso_pantalla_rol 
   TABLE DATA           �   COPY public.permiso_pantalla_rol (cod_pan_rol, cod_pantalla, cod_permiso, cod_rol, estado, usr_registro, fec_registro) FROM stdin;
    public          postgres    false    244   :s      Q          0    88401    permisos 
   TABLE DATA           7   COPY public.permisos (cod_permiso, nombre) FROM stdin;
    public          postgres    false    237   Ws      1          0    88187    persona 
   TABLE DATA           �   COPY public.persona (cod_persona, cod_tipo_persona, uid, dni, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, sexo, fec_nacimiento, usr_registro, fec_registro, nacionalidad) FROM stdin;
    public          postgres    false    205   ts      _          0    88544    prueba 
   TABLE DATA           &   COPY public.prueba (dato) FROM stdin;
    public          postgres    false    251   gw      O          0    88394    roles 
   TABLE DATA           Y   COPY public.roles (cod_rol, nombre, descripcion, usr_registro, fec_registro) FROM stdin;
    public          postgres    false    235   �w      )          0    88146 	   secciones 
   TABLE DATA           i   COPY public.secciones (cod_seccion, nombre, cupos, estado, anio, usr_registro, fec_registro) FROM stdin;
    public          postgres    false    197   �w      =          0    88254    telefono 
   TABLE DATA           �   COPY public.telefono (cod_telefono, cod_tipo_telefono, telefono, whatsapp, usr_registro, fec_registro, emergencia, estado) FROM stdin;
    public          postgres    false    217   x      ?          0    88267    telefono_persona 
   TABLE DATA           R   COPY public.telefono_persona (cod_tel_per, cod_telefono, cod_persona) FROM stdin;
    public          postgres    false    219   2y      G          0    88325    tipo_matricula 
   TABLE DATA           `   COPY public.tipo_matricula (cod_tipo_matricula, nombre, usr_registro, fec_registro) FROM stdin;
    public          postgres    false    227   �y      /          0    88180    tipo_persona 
   TABLE DATA           \   COPY public.tipo_persona (cod_tipo_persona, nombre, usr_registro, fec_registro) FROM stdin;
    public          postgres    false    203   �y      ;          0    88247    tipo_telefono 
   TABLE DATA           k   COPY public.tipo_telefono (cod_tipo_telefono, nombre, descripcion, usr_registro, fec_registro) FROM stdin;
    public          postgres    false    215   0z      U          0    88415    usuario 
   TABLE DATA           �   COPY public.usuario (cod_usuario, cod_persona, cod_estado, usuario, contrasena, primer_ingreso, tfa, secret, qr, usr_registro, fec_registro) FROM stdin;
    public          postgres    false    241   z      V          0    88435    usuario_roles 
   TABLE DATA           Y   COPY public.usuario_roles (cod_usuario, cod_rol, usr_registro, fec_registro) FROM stdin;
    public          postgres    false    242   {      j           0    0    alumnos_cod_alumno_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.alumnos_cod_alumno_seq', 12, true);
          public          postgres    false    222            k           0    0    bitacora_cod_registro_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.bitacora_cod_registro_seq', 1, false);
          public          postgres    false    247            l           0    0    clausulas_cod_clausula_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.clausulas_cod_clausula_seq', 1, false);
          public          postgres    false    254            m           0    0    colegio_cod_colegio_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.colegio_cod_colegio_seq', 1, false);
          public          postgres    false    200            n           0    0    contratos_cod_contrato_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.contratos_cod_contrato_seq', 1, false);
          public          postgres    false    252            o           0    0    correo_cod_correo_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.correo_cod_correo_seq', 14, true);
          public          postgres    false    206            p           0    0    correo_persona_cod_cor_per_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.correo_persona_cod_cor_per_seq', 13, true);
          public          postgres    false    208            q           0    0    cursos_cod_curso_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.cursos_cod_curso_seq', 13, true);
          public          postgres    false    198            r           0    0    direccion_cod_direccion_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.direccion_cod_direccion_seq', 46, true);
          public          postgres    false    210            s           0    0 !   direccion_persona_cod_dir_per_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.direccion_persona_cod_dir_per_seq', 46, true);
          public          postgres    false    212            t           0    0    estado_cod_estado_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.estado_cod_estado_seq', 3, true);
          public          postgres    false    238            u           0    0    expediente_cod_expediente_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.expediente_cod_expediente_seq', 1, false);
          public          postgres    false    230            v           0    0    familiares_cod_familiar_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.familiares_cod_familiar_seq', 11, true);
          public          postgres    false    224            w           0    0    grupo_familiar_cod_grupo_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.grupo_familiar_cod_grupo_seq', 10, true);
          public          postgres    false    220            x           0    0 !   historial_contrasena_cod_hist_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.historial_contrasena_cod_hist_seq', 1, false);
          public          postgres    false    245            y           0    0    matricula_cod_matricula_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.matricula_cod_matricula_seq', 1, false);
          public          postgres    false    228            z           0    0    pantallas_cod_pantalla_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.pantallas_cod_pantalla_seq', 1, false);
          public          postgres    false    232            {           0    0    parametros_cod_parametro_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.parametros_cod_parametro_seq', 1, true);
          public          postgres    false    249            |           0    0 $   permiso_pantalla_rol_cod_pan_rol_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('public.permiso_pantalla_rol_cod_pan_rol_seq', 1, false);
          public          postgres    false    243            }           0    0    permisos_cod_permiso_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.permisos_cod_permiso_seq', 1, false);
          public          postgres    false    236            ~           0    0    persona_cod_persona_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.persona_cod_persona_seq', 50, true);
          public          postgres    false    204                       0    0    roles_cod_rol_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.roles_cod_rol_seq', 1, true);
          public          postgres    false    234            �           0    0    secciones_cod_seccion_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.secciones_cod_seccion_seq', 1, false);
          public          postgres    false    196            �           0    0    telefono_cod_telefono_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.telefono_cod_telefono_seq', 42, true);
          public          postgres    false    216            �           0    0     telefono_persona_cod_tel_per_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.telefono_persona_cod_tel_per_seq', 41, true);
          public          postgres    false    218            �           0    0 %   tipo_matricula_cod_tipo_matricula_seq    SEQUENCE SET     T   SELECT pg_catalog.setval('public.tipo_matricula_cod_tipo_matricula_seq', 1, false);
          public          postgres    false    226            �           0    0 !   tipo_persona_cod_tipo_persona_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.tipo_persona_cod_tipo_persona_seq', 5, true);
          public          postgres    false    202            �           0    0 #   tipo_telefono_cod_tipo_telefono_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.tipo_telefono_cod_tipo_telefono_seq', 2, true);
          public          postgres    false    214            �           0    0    usuario_cod_usuario_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.usuario_cod_usuario_seq', 1, true);
          public          postgres    false    240            p           2606    88295    alumnos alumnos_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.alumnos
    ADD CONSTRAINT alumnos_pkey PRIMARY KEY (cod_alumno);
 >   ALTER TABLE ONLY public.alumnos DROP CONSTRAINT alumnos_pkey;
       public            postgres    false    223            �           2606    88507    bitacora bitacora_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.bitacora
    ADD CONSTRAINT bitacora_pkey PRIMARY KEY (cod_registro);
 @   ALTER TABLE ONLY public.bitacora DROP CONSTRAINT bitacora_pkey;
       public            postgres    false    248            �           2606    88630    clausulas clausulas_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.clausulas
    ADD CONSTRAINT clausulas_pkey PRIMARY KEY (cod_clausula);
 B   ALTER TABLE ONLY public.clausulas DROP CONSTRAINT clausulas_pkey;
       public            postgres    false    255            X           2606    88177    colegio colegio_nombre_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.colegio
    ADD CONSTRAINT colegio_nombre_key UNIQUE (nombre);
 D   ALTER TABLE ONLY public.colegio DROP CONSTRAINT colegio_nombre_key;
       public            postgres    false    201            Z           2606    88175    colegio colegio_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.colegio
    ADD CONSTRAINT colegio_pkey PRIMARY KEY (cod_colegio);
 >   ALTER TABLE ONLY public.colegio DROP CONSTRAINT colegio_pkey;
       public            postgres    false    201            �           2606    88618    contratos contratos_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.contratos
    ADD CONSTRAINT contratos_pkey PRIMARY KEY (cod_contrato);
 B   ALTER TABLE ONLY public.contratos DROP CONSTRAINT contratos_pkey;
       public            postgres    false    253            b           2606    88210 "   correo_persona correo_persona_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.correo_persona
    ADD CONSTRAINT correo_persona_pkey PRIMARY KEY (cod_cor_per);
 L   ALTER TABLE ONLY public.correo_persona DROP CONSTRAINT correo_persona_pkey;
       public            postgres    false    209            `           2606    88203    correo correo_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.correo
    ADD CONSTRAINT correo_pkey PRIMARY KEY (cod_correo);
 <   ALTER TABLE ONLY public.correo DROP CONSTRAINT correo_pkey;
       public            postgres    false    207            R           2606    88162    cursos cursos_nombre_key 
   CONSTRAINT     U   ALTER TABLE ONLY public.cursos
    ADD CONSTRAINT cursos_nombre_key UNIQUE (nombre);
 B   ALTER TABLE ONLY public.cursos DROP CONSTRAINT cursos_nombre_key;
       public            postgres    false    199            T           2606    88160    cursos cursos_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.cursos
    ADD CONSTRAINT cursos_pkey PRIMARY KEY (cod_curso);
 <   ALTER TABLE ONLY public.cursos DROP CONSTRAINT cursos_pkey;
       public            postgres    false    199            f           2606    88234 (   direccion_persona direccion_persona_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY public.direccion_persona
    ADD CONSTRAINT direccion_persona_pkey PRIMARY KEY (cod_dir_per);
 R   ALTER TABLE ONLY public.direccion_persona DROP CONSTRAINT direccion_persona_pkey;
       public            postgres    false    213            d           2606    88227    direccion direccion_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public.direccion
    ADD CONSTRAINT direccion_pkey PRIMARY KEY (cod_direccion);
 B   ALTER TABLE ONLY public.direccion DROP CONSTRAINT direccion_pkey;
       public            postgres    false    211            �           2606    88412    estado estado_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.estado
    ADD CONSTRAINT estado_pkey PRIMARY KEY (cod_estado);
 <   ALTER TABLE ONLY public.estado DROP CONSTRAINT estado_pkey;
       public            postgres    false    239            x           2606    88368    expediente expediente_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.expediente
    ADD CONSTRAINT expediente_pkey PRIMARY KEY (cod_expediente);
 D   ALTER TABLE ONLY public.expediente DROP CONSTRAINT expediente_pkey;
       public            postgres    false    231            r           2606    88312    familiares familiares_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.familiares
    ADD CONSTRAINT familiares_pkey PRIMARY KEY (cod_familiar);
 D   ALTER TABLE ONLY public.familiares DROP CONSTRAINT familiares_pkey;
       public            postgres    false    225            n           2606    88288 "   grupo_familiar grupo_familiar_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY public.grupo_familiar
    ADD CONSTRAINT grupo_familiar_pkey PRIMARY KEY (cod_grupo);
 L   ALTER TABLE ONLY public.grupo_familiar DROP CONSTRAINT grupo_familiar_pkey;
       public            postgres    false    221            �           2606    88478 .   historial_contrasena historial_contrasena_pkey 
   CONSTRAINT     r   ALTER TABLE ONLY public.historial_contrasena
    ADD CONSTRAINT historial_contrasena_pkey PRIMARY KEY (cod_hist);
 X   ALTER TABLE ONLY public.historial_contrasena DROP CONSTRAINT historial_contrasena_pkey;
       public            postgres    false    246            v           2606    88336    matricula matricula_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public.matricula
    ADD CONSTRAINT matricula_pkey PRIMARY KEY (cod_matricula);
 B   ALTER TABLE ONLY public.matricula DROP CONSTRAINT matricula_pkey;
       public            postgres    false    229            V           2606    88638    cursos nombre_unico 
   CONSTRAINT     P   ALTER TABLE ONLY public.cursos
    ADD CONSTRAINT nombre_unico UNIQUE (nombre);
 =   ALTER TABLE ONLY public.cursos DROP CONSTRAINT nombre_unico;
       public            postgres    false    199            z           2606    88391    pantallas pantallas_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.pantallas
    ADD CONSTRAINT pantallas_pkey PRIMARY KEY (cod_pantalla);
 B   ALTER TABLE ONLY public.pantallas DROP CONSTRAINT pantallas_pkey;
       public            postgres    false    233            �           2606    88514    parametros parametros_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.parametros
    ADD CONSTRAINT parametros_pkey PRIMARY KEY (cod_parametro);
 D   ALTER TABLE ONLY public.parametros DROP CONSTRAINT parametros_pkey;
       public            postgres    false    250            �           2606    88456 .   permiso_pantalla_rol permiso_pantalla_rol_pkey 
   CONSTRAINT     u   ALTER TABLE ONLY public.permiso_pantalla_rol
    ADD CONSTRAINT permiso_pantalla_rol_pkey PRIMARY KEY (cod_pan_rol);
 X   ALTER TABLE ONLY public.permiso_pantalla_rol DROP CONSTRAINT permiso_pantalla_rol_pkey;
       public            postgres    false    244            ~           2606    88405    permisos permisos_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.permisos
    ADD CONSTRAINT permisos_pkey PRIMARY KEY (cod_permiso);
 @   ALTER TABLE ONLY public.permisos DROP CONSTRAINT permisos_pkey;
       public            postgres    false    237            ^           2606    88191    persona persona_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.persona
    ADD CONSTRAINT persona_pkey PRIMARY KEY (cod_persona);
 >   ALTER TABLE ONLY public.persona DROP CONSTRAINT persona_pkey;
       public            postgres    false    205            |           2606    88398    roles roles_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (cod_rol);
 :   ALTER TABLE ONLY public.roles DROP CONSTRAINT roles_pkey;
       public            postgres    false    235            N           2606    88153    secciones secciones_nombre_key 
   CONSTRAINT     [   ALTER TABLE ONLY public.secciones
    ADD CONSTRAINT secciones_nombre_key UNIQUE (nombre);
 H   ALTER TABLE ONLY public.secciones DROP CONSTRAINT secciones_nombre_key;
       public            postgres    false    197            P           2606    88151    secciones secciones_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.secciones
    ADD CONSTRAINT secciones_pkey PRIMARY KEY (cod_seccion);
 B   ALTER TABLE ONLY public.secciones DROP CONSTRAINT secciones_pkey;
       public            postgres    false    197            l           2606    88271 &   telefono_persona telefono_persona_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY public.telefono_persona
    ADD CONSTRAINT telefono_persona_pkey PRIMARY KEY (cod_tel_per);
 P   ALTER TABLE ONLY public.telefono_persona DROP CONSTRAINT telefono_persona_pkey;
       public            postgres    false    219            j           2606    88259    telefono telefono_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.telefono
    ADD CONSTRAINT telefono_pkey PRIMARY KEY (cod_telefono);
 @   ALTER TABLE ONLY public.telefono DROP CONSTRAINT telefono_pkey;
       public            postgres    false    217            t           2606    88329 "   tipo_matricula tipo_matricula_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.tipo_matricula
    ADD CONSTRAINT tipo_matricula_pkey PRIMARY KEY (cod_tipo_matricula);
 L   ALTER TABLE ONLY public.tipo_matricula DROP CONSTRAINT tipo_matricula_pkey;
       public            postgres    false    227            \           2606    88184    tipo_persona tipo_persona_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.tipo_persona
    ADD CONSTRAINT tipo_persona_pkey PRIMARY KEY (cod_tipo_persona);
 H   ALTER TABLE ONLY public.tipo_persona DROP CONSTRAINT tipo_persona_pkey;
       public            postgres    false    203            h           2606    88251     tipo_telefono tipo_telefono_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY public.tipo_telefono
    ADD CONSTRAINT tipo_telefono_pkey PRIMARY KEY (cod_tipo_telefono);
 J   ALTER TABLE ONLY public.tipo_telefono DROP CONSTRAINT tipo_telefono_pkey;
       public            postgres    false    215            �           2606    88424    usuario usuario_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (cod_usuario);
 >   ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuario_pkey;
       public            postgres    false    241            �           2606    88439     usuario_roles usuario_roles_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.usuario_roles
    ADD CONSTRAINT usuario_roles_pkey PRIMARY KEY (cod_usuario, cod_rol);
 J   ALTER TABLE ONLY public.usuario_roles DROP CONSTRAINT usuario_roles_pkey;
       public            postgres    false    242    242            �           2606    88296    alumnos fk_alumnos_personas    FK CONSTRAINT     �   ALTER TABLE ONLY public.alumnos
    ADD CONSTRAINT fk_alumnos_personas FOREIGN KEY (cod_persona) REFERENCES public.persona(cod_persona);
 E   ALTER TABLE ONLY public.alumnos DROP CONSTRAINT fk_alumnos_personas;
       public          postgres    false    2910    223    205            �           2606    88192 (   persona fk_cod_tipo_persona_tipo_persona    FK CONSTRAINT     �   ALTER TABLE ONLY public.persona
    ADD CONSTRAINT fk_cod_tipo_persona_tipo_persona FOREIGN KEY (cod_tipo_persona) REFERENCES public.tipo_persona(cod_tipo_persona);
 R   ALTER TABLE ONLY public.persona DROP CONSTRAINT fk_cod_tipo_persona_tipo_persona;
       public          postgres    false    203    205    2908            �           2606    88631     clausulas fk_contratos_clausulas    FK CONSTRAINT     �   ALTER TABLE ONLY public.clausulas
    ADD CONSTRAINT fk_contratos_clausulas FOREIGN KEY (cod_contrato) REFERENCES public.contratos(cod_contrato);
 J   ALTER TABLE ONLY public.clausulas DROP CONSTRAINT fk_contratos_clausulas;
       public          postgres    false    255    253    2958            �           2606    88216 '   correo_persona fk_correo_persona_correo    FK CONSTRAINT     �   ALTER TABLE ONLY public.correo_persona
    ADD CONSTRAINT fk_correo_persona_correo FOREIGN KEY (cod_correo) REFERENCES public.correo(cod_correo);
 Q   ALTER TABLE ONLY public.correo_persona DROP CONSTRAINT fk_correo_persona_correo;
       public          postgres    false    209    2912    207            �           2606    88211 (   correo_persona fk_correo_persona_persona    FK CONSTRAINT     �   ALTER TABLE ONLY public.correo_persona
    ADD CONSTRAINT fk_correo_persona_persona FOREIGN KEY (cod_persona) REFERENCES public.persona(cod_persona);
 R   ALTER TABLE ONLY public.correo_persona DROP CONSTRAINT fk_correo_persona_persona;
       public          postgres    false    209    2910    205            �           2606    88619    contratos fk_cursos_contrato    FK CONSTRAINT     �   ALTER TABLE ONLY public.contratos
    ADD CONSTRAINT fk_cursos_contrato FOREIGN KEY (cod_curso) REFERENCES public.cursos(cod_curso);
 F   ALTER TABLE ONLY public.contratos DROP CONSTRAINT fk_cursos_contrato;
       public          postgres    false    199    2900    253            �           2606    88163    cursos fk_cursos_secciones    FK CONSTRAINT     �   ALTER TABLE ONLY public.cursos
    ADD CONSTRAINT fk_cursos_secciones FOREIGN KEY (cod_seccion) REFERENCES public.secciones(cod_seccion);
 D   ALTER TABLE ONLY public.cursos DROP CONSTRAINT fk_cursos_secciones;
       public          postgres    false    199    197    2896            �           2606    88240 0   direccion_persona fk_direccion_persona_direccion    FK CONSTRAINT     �   ALTER TABLE ONLY public.direccion_persona
    ADD CONSTRAINT fk_direccion_persona_direccion FOREIGN KEY (cod_direccion) REFERENCES public.direccion(cod_direccion);
 Z   ALTER TABLE ONLY public.direccion_persona DROP CONSTRAINT fk_direccion_persona_direccion;
       public          postgres    false    2916    211    213            �           2606    88235 .   direccion_persona fk_direccion_persona_persona    FK CONSTRAINT     �   ALTER TABLE ONLY public.direccion_persona
    ADD CONSTRAINT fk_direccion_persona_persona FOREIGN KEY (cod_persona) REFERENCES public.persona(cod_persona);
 X   ALTER TABLE ONLY public.direccion_persona DROP CONSTRAINT fk_direccion_persona_persona;
       public          postgres    false    213    2910    205            �           2606    88369     expediente fk_expediente_alumnos    FK CONSTRAINT     �   ALTER TABLE ONLY public.expediente
    ADD CONSTRAINT fk_expediente_alumnos FOREIGN KEY (cod_alumno) REFERENCES public.alumnos(cod_alumno);
 J   ALTER TABLE ONLY public.expediente DROP CONSTRAINT fk_expediente_alumnos;
       public          postgres    false    223    2928    231            �           2606    88374     expediente fk_expediente_colegio    FK CONSTRAINT     �   ALTER TABLE ONLY public.expediente
    ADD CONSTRAINT fk_expediente_colegio FOREIGN KEY (cod_colegio) REFERENCES public.colegio(cod_colegio);
 J   ALTER TABLE ONLY public.expediente DROP CONSTRAINT fk_expediente_colegio;
       public          postgres    false    201    2906    231            �           2606    88379    expediente fk_expediente_cursos    FK CONSTRAINT     �   ALTER TABLE ONLY public.expediente
    ADD CONSTRAINT fk_expediente_cursos FOREIGN KEY (cod_curso) REFERENCES public.cursos(cod_curso);
 I   ALTER TABLE ONLY public.expediente DROP CONSTRAINT fk_expediente_cursos;
       public          postgres    false    2900    199    231            �           2606    88313 !   familiares fk_familiares_personas    FK CONSTRAINT     �   ALTER TABLE ONLY public.familiares
    ADD CONSTRAINT fk_familiares_personas FOREIGN KEY (cod_persona) REFERENCES public.persona(cod_persona);
 K   ALTER TABLE ONLY public.familiares DROP CONSTRAINT fk_familiares_personas;
       public          postgres    false    2910    205    225            �           2606    88301    alumnos fk_grupo_grupo_familiar    FK CONSTRAINT     �   ALTER TABLE ONLY public.alumnos
    ADD CONSTRAINT fk_grupo_grupo_familiar FOREIGN KEY (cod_grupo) REFERENCES public.grupo_familiar(cod_grupo);
 I   ALTER TABLE ONLY public.alumnos DROP CONSTRAINT fk_grupo_grupo_familiar;
       public          postgres    false    221    2926    223            �           2606    88318 "   familiares fk_grupo_grupo_familiar    FK CONSTRAINT     �   ALTER TABLE ONLY public.familiares
    ADD CONSTRAINT fk_grupo_grupo_familiar FOREIGN KEY (cod_grupo) REFERENCES public.grupo_familiar(cod_grupo);
 L   ALTER TABLE ONLY public.familiares DROP CONSTRAINT fk_grupo_grupo_familiar;
       public          postgres    false    2926    221    225            �           2606    88357 !   matricula fk_grupo_grupo_familiar    FK CONSTRAINT     �   ALTER TABLE ONLY public.matricula
    ADD CONSTRAINT fk_grupo_grupo_familiar FOREIGN KEY (cod_grupo) REFERENCES public.grupo_familiar(cod_grupo);
 K   ALTER TABLE ONLY public.matricula DROP CONSTRAINT fk_grupo_grupo_familiar;
       public          postgres    false    2926    229    221            �           2606    88342    matricula fk_matricula_alumnos    FK CONSTRAINT     �   ALTER TABLE ONLY public.matricula
    ADD CONSTRAINT fk_matricula_alumnos FOREIGN KEY (cod_alumno) REFERENCES public.alumnos(cod_alumno);
 H   ALTER TABLE ONLY public.matricula DROP CONSTRAINT fk_matricula_alumnos;
       public          postgres    false    223    2928    229            �           2606    88347    matricula fk_matricula_curso    FK CONSTRAINT     �   ALTER TABLE ONLY public.matricula
    ADD CONSTRAINT fk_matricula_curso FOREIGN KEY (cod_curso) REFERENCES public.cursos(cod_curso);
 F   ALTER TABLE ONLY public.matricula DROP CONSTRAINT fk_matricula_curso;
       public          postgres    false    199    229    2900            �           2606    88352    matricula fk_matricula_seccion    FK CONSTRAINT     �   ALTER TABLE ONLY public.matricula
    ADD CONSTRAINT fk_matricula_seccion FOREIGN KEY (cod_seccion) REFERENCES public.secciones(cod_seccion);
 H   ALTER TABLE ONLY public.matricula DROP CONSTRAINT fk_matricula_seccion;
       public          postgres    false    2896    197    229            �           2606    88337 %   matricula fk_matricula_tipo_matricula    FK CONSTRAINT     �   ALTER TABLE ONLY public.matricula
    ADD CONSTRAINT fk_matricula_tipo_matricula FOREIGN KEY (cod_tipo_matricula) REFERENCES public.tipo_matricula(cod_tipo_matricula);
 O   ALTER TABLE ONLY public.matricula DROP CONSTRAINT fk_matricula_tipo_matricula;
       public          postgres    false    229    227    2932            �           2606    88457 6   permiso_pantalla_rol fk_permiso_pantalla_rol_pantallas    FK CONSTRAINT     �   ALTER TABLE ONLY public.permiso_pantalla_rol
    ADD CONSTRAINT fk_permiso_pantalla_rol_pantallas FOREIGN KEY (cod_pantalla) REFERENCES public.pantallas(cod_pantalla);
 `   ALTER TABLE ONLY public.permiso_pantalla_rol DROP CONSTRAINT fk_permiso_pantalla_rol_pantallas;
       public          postgres    false    233    2938    244            �           2606    88462 5   permiso_pantalla_rol fk_permiso_pantalla_rol_permisos    FK CONSTRAINT     �   ALTER TABLE ONLY public.permiso_pantalla_rol
    ADD CONSTRAINT fk_permiso_pantalla_rol_permisos FOREIGN KEY (cod_permiso) REFERENCES public.permisos(cod_permiso);
 _   ALTER TABLE ONLY public.permiso_pantalla_rol DROP CONSTRAINT fk_permiso_pantalla_rol_permisos;
       public          postgres    false    244    237    2942            �           2606    88467 2   permiso_pantalla_rol fk_permiso_pantalla_rol_roles    FK CONSTRAINT     �   ALTER TABLE ONLY public.permiso_pantalla_rol
    ADD CONSTRAINT fk_permiso_pantalla_rol_roles FOREIGN KEY (cod_rol) REFERENCES public.roles(cod_rol);
 \   ALTER TABLE ONLY public.permiso_pantalla_rol DROP CONSTRAINT fk_permiso_pantalla_rol_roles;
       public          postgres    false    244    2940    235            �           2606    88277 ,   telefono_persona fk_telefono_persona_persona    FK CONSTRAINT     �   ALTER TABLE ONLY public.telefono_persona
    ADD CONSTRAINT fk_telefono_persona_persona FOREIGN KEY (cod_persona) REFERENCES public.persona(cod_persona);
 V   ALTER TABLE ONLY public.telefono_persona DROP CONSTRAINT fk_telefono_persona_persona;
       public          postgres    false    205    2910    219            �           2606    88272 -   telefono_persona fk_telefono_persona_telefono    FK CONSTRAINT     �   ALTER TABLE ONLY public.telefono_persona
    ADD CONSTRAINT fk_telefono_persona_telefono FOREIGN KEY (cod_telefono) REFERENCES public.telefono(cod_telefono);
 W   ALTER TABLE ONLY public.telefono_persona DROP CONSTRAINT fk_telefono_persona_telefono;
       public          postgres    false    217    2922    219            �           2606    88260 "   telefono fk_telefono_tipo_telefono    FK CONSTRAINT     �   ALTER TABLE ONLY public.telefono
    ADD CONSTRAINT fk_telefono_tipo_telefono FOREIGN KEY (cod_tipo_telefono) REFERENCES public.tipo_telefono(cod_tipo_telefono);
 L   ALTER TABLE ONLY public.telefono DROP CONSTRAINT fk_telefono_tipo_telefono;
       public          postgres    false    215    2920    217            �           2606    88430    usuario fk_usuario_estado    FK CONSTRAINT     �   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT fk_usuario_estado FOREIGN KEY (cod_estado) REFERENCES public.estado(cod_estado);
 C   ALTER TABLE ONLY public.usuario DROP CONSTRAINT fk_usuario_estado;
       public          postgres    false    239    241    2944            �           2606    88425    usuario fk_usuario_persona    FK CONSTRAINT     �   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT fk_usuario_persona FOREIGN KEY (cod_persona) REFERENCES public.persona(cod_persona);
 D   ALTER TABLE ONLY public.usuario DROP CONSTRAINT fk_usuario_persona;
       public          postgres    false    2910    205    241            �           2606    88440 $   usuario_roles fk_usuario_roles_roles    FK CONSTRAINT     �   ALTER TABLE ONLY public.usuario_roles
    ADD CONSTRAINT fk_usuario_roles_roles FOREIGN KEY (cod_rol) REFERENCES public.roles(cod_rol);
 N   ALTER TABLE ONLY public.usuario_roles DROP CONSTRAINT fk_usuario_roles_roles;
       public          postgres    false    235    2940    242            �           2606    88445 &   usuario_roles fk_usuario_roles_usuario    FK CONSTRAINT     �   ALTER TABLE ONLY public.usuario_roles
    ADD CONSTRAINT fk_usuario_roles_usuario FOREIGN KEY (cod_usuario) REFERENCES public.usuario(cod_usuario);
 P   ALTER TABLE ONLY public.usuario_roles DROP CONSTRAINT fk_usuario_roles_usuario;
       public          postgres    false    242    2946    241            C   p   x�3�42�4��O*N-*KL���K-Vp�)����t���,��46�4Ǯ��Ē�Āӂ�/3/�4/�3 "jh�ib�	$�<��C�a�F�F& K�*�N���*_��=... 8�3f      \      x������ � �      c      x������ � �      -      x������ � �      a      x������ � �      3   j   x�34���/JOML/��I-J�KL�rH�M���K���tt����4202�5��52�24�,(*MMJ,�/.�M�s(I-.+�g� cC.CN��4CRtZ��r��qqq �:7�      5   (   x�34�44�44�24�4��44�24�41�44����� M��      +   �   x����j�@D뻯���N.�.��	-H�B:b܈��q�t)�]���
�"�U����yQV9`Eu�:�b��@&�vR����6�
{(������x��}���P���t����x�q�~�.�霼_/ʮm�ZoW6��u�L���_��� S�[�X�{x��4����zj��� ����ć�f�9��D���	�K���B�<-���` � 5�ol�ՇDk��j��      7   #  x���Kn�0���� ?dWTB
%t�r�E� G&t�;��X+Em\̂f3����Yq�O�(-r�Y�[׊]�l7���Fc�0�'Ȅ��7�=ey�Da��s* x�Q��� w�Y��yt��X(^�B�,U�YoR�����bk/m�D�Բ��	d�٬��A��'9�{6��Up[��J��uk� ������\P�^w(���V��*�Hv���ܻI�f�(��P%o��S�Ϗ�_�N$���&���0�w	_Y/:��ϻ�����ML���� |j�      9   f   x����0�7��.�p.�?�'CW�&�X=P��щ���Dv��6�<����dhP-�y�I�&6��Em��� �Xa����tǋ�Ǜ�C���      S   '   x�3�tt���2���2�9�|�C]]��b���� ��7      K      x������ � �      E     x����n�0��O�'X,�/�BRR�+o��L�����l��hv��|�������Zh���E�*BA�"2Q�E�c
E��c�M"�6y�� �����y��yK`��~ig��8� )�r��Z�>���V��?0J�WN�lw�⨐���d�e��i4�=Bn����κ�i�tø��-�AEk>kۛ
+� ��r�X���	-,�#y��?GU�g,M�^�(bڲk��0�?!������F=<y��*_�H      A   j   x�3�4@F��.��~�FF���F\F(
�1��(0�T`���� S�%�ά�������̜ԢD���*��������\�6cC.�Q��̈�g�k`����� ��7�      Z      x������ � �      I      x������ � �      M      x������ � �      ^   -   x�3�tt�����q���4�p�X�Yr��qqq Υ�      X      x������ � �      Q      x������ � �      1   �  x���]Nk7ǟ�*�#�=�zkZ�MJ��J��Q����K��Pu	l��I����c�::��f�c��� cqM*kQ"F��k�
��]�*	����|t4�MOgbt>�LN�ξ�슩�J�\]�g���+H��Og�������сF��ي�@��$t2dW%��)(H.�.<���r:;���D���"dEr
��d�MK�+2��d�L�bM6�)�1��m1BٱP��Ւl碑h�$��>�&�E�p����o��#EaE�1�� .���'�$1��͖X�" q���fbJwò�����/�W��>_��%�՗�n���0/n�)�R�baJ-@:k���*i�S�H�[h�ʤ;
�ї��8���u�&q�X.뽘<��G���2r�>�Y�R�+S�l��tcJVf)x�9�^+fg������׋cؖ�v�x0J~���"wm�e�+��m��S�ճX�ZY��\�ָV;.��?��W`z]ț�q?��ƚ1��WF����,Yg�@�\�В˄.{m:.�s�W\�#\q��-�l����&+n=G����qõ��[����1vi\�K,����c���4!'Wl �aK�w`�[���T3�����l��*di����JwTJ����'c1]N����t2����l��;:��V��H)���T�2��%'�j	��5��^���M�)O�υ���6	�4I>i�Τގ�Ɔ�v����۱�Z��s�3;���TA3�0����-�����t3��#?m�Y��TV�A�C�Yԉ-�0�?U�����6"</��/$X�D�0����q%�bX%~�����i9��[���7+-GU.�d�a� .A�$�Miٻ�m� ;W �-�S����)(���;�;�~q�Z��g$;�ʫ��M�b �8R�������N���ݗǿnd���~��	h�k�2�y8�a�Ù
MsFB�j}^zy\z�i������W���      _   '   x�KK�)N�*��/��J���M�+ᲄ (m����� %      O   ;   x�3�tt�����q�0=�C�]��\\}��<W_G�����������%W� �Y      )      x������ � �      =     x��S�j�0<K��ɒn-��C������@p/��j�vI�C%�M̌gGk
�L��������! �Aܑ\͖z�'<�ĕ��=%�1S���D�(���"1U�p���X��:_��0}�������t���|�S2�$��6)�D��*iځW)縄�F��IIQ+�$����J�TE���$�9@L�R�2+��61拻M{�y��e-ݼ�&�����RQ*-�-�Ǎ^��s��-���^����y'ј��s	��S%-��¥��ѧ�"��Gg���8s      ?   v   x���0��0U�I�����(�9NFX�)����/^��XP�1�1l���'��Ȇ��eQg�@~,�2Xt�T��b��6�Y�F&��"7ݵ�Cw-��!Wo�1RT������� �      G      x������ � �      /   K   x�3�pt	r�tt����4202�5��52�2���.a���������)i�����EƔ348�1��T� �f      ;   ?   x�3�tvv�q�qu���W �]|=�8��u,t�̸�8�]}B}��B0���qqq rdP      U   �   x���
�  ���sx��5p�8�ک�]��V.c5�����ǀ������]��{G\�סsm$����%���V�1>�~0�|�^���U)�E%��E�S-�tlC��~G]L��+4�_����)g/PCB?�$�      V   "   x�3�4�tt����4202�5��5������ A?�     