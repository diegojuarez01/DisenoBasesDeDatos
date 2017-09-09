SET SERVEROUTPUT ON
CREATE OR REPLACE PROCEDURE ESTADISTICAS_MVP (MVP varchar)
IS
CURSOR DATOS (Nick_mvp varchar) IS
SELECT codigopartido, nickequipo1, nickequipo2, equipoganador, nickmvp, numkillsMVP
	FROM estadisticas
	WHERE MVP = nickmvp
	ORDER BY codigopartido;
BEGIN
DBMS_OUTPUT.PUT_LINE ('-----------------------------------');
DBMS_OUTPUT.PUT_LINE ('MVP: ' || MVP);
DBMS_OUTPUT.PUT_LINE ('-----------------------------------');
DBMS_OUTPUT.PUT_LINE ('Cod ' || 'Equipo1 ' || 'Equipo2 ' || 'Ganador ' || 'Kills' );
DBMS_OUTPUT.PUT_LINE ('-----------------------------------');

FOR registro IN datos(MVP) LOOP
  DBMS_OUTPUT.PUT_LINE (registro.codigopartido || ' ' || 
                        registro.nickequipo1 || ' ' || 
                        registro.nickequipo2 || ' ' || 
                        registro.equipoganador || ' ' ||
                        registro.numkillsMVP);
   END LOOP;
END;
/


CREATE OR REPLACE PROCEDURE DATOS_PARTIDO (partido VARCHAR)

IS 

NICKEQUIPOGANADOR estadisticas.equipoganador%TYPE;
NICKMVP estadisticas.nickmvp%TYPE;

BEGIN 

SELECT equipoganador, nickmvp INTO NICKEQUIPOGANADOR, NICKMVP
FROM estadisticas
WHERE codigopartido = partido;
DBMS_OUTPUT.PUT_LINE ('Ganador:' || nickequipoganador || ' MVP:' || nickmvp);

EXCEPTION

      WHEN NO_DATA_FOUND THEN
         DBMS_OUTPUT.PUT_LINE ('Este código de partido ' || partido || ' no existe.');

END;
/

CREATE OR REPLACE
PROCEDURE AUMENTAR_CONTRATO (codigo patrocinar.codpatrocinar%type, Auimporte in number, Aumeses in number)
IS

BEGIN

UPDATE patrocinar
SET importe=importe+Auimporte,
meses=meses+Aumeses
WHERE codpatrocinar = codigo;

END;
/


CREATE OR REPLACE FUNCTION KILLS_MVP (nickjugador estadisticas.nickmvp%type)
RETURN NUMBER
IS
numtotalkills number;
BEGIN
SELECT SUM (numkillsMVP) INTO numtotalkills
FROM estadisticas
WHERE nickmvp=nickjugador;
RETURN numtotalkills;
END;
/


CREATE OR REPLACE FUNCTION PAT_TOTAL (Equipo1 equipo.nickequipo%type)
RETURN NUMBER
IS
TOTAL_PATROCINIO NUMBER :=0;
BEGIN 
SELECT SUM (importe) INTO TOTAL_PATROCINIO
FROM patrocinar
WHERE nickequipo = Equipo1;
RETURN TOTAL_PATROCINIO;
END;
/


CREATE OR REPLACE FUNCTION NUMJUGADORES_LIGAS (region1 equipo.region%type, liga1 equipo.numdivision%type)
RETURN NUMBER
IS
numtotaljugadores number :=0;
BEGIN
SELECT COUNT (*) INTO numtotaljugadores 
FROM equipo
WHERE equipo.region = region1 AND equipo.numdivision = liga1;
RETURN numtotaljugadores;
END;
/

CREATE TRIGGER JUGADORES_MAXIMO
BEFORE UPDATE OF numjugadores ON equipo 
FOR EACH ROW
WHEN (new.numjugadores >7)
BEGIN 
RAISE_APPLICATION_ERROR (-20000,’Numero maximo de jugadores, no se puede realizar el cambio’);
END;
/

