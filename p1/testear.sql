para ver todos los atributos de la tabla estadisticas como se puede ver estan los 100 datos introducidos.
Y lo mismo con todas las tablas.

SELECT * FROM estadisticas;
SELECT * FROM patrocinador;
SELECT * FROM liga;
SELECT * FROM entrenador;
SELECT * FROM equipo;
SELECT * FROM patrocinar;
SELECT * FROM dirigir;
SELECT * FROM jugador;
SELECT * FROM clasificacion;
SELECT * FROM mostrar;
SELECT * FROM analista;
SELECT * FROM caster;
SELECT * FROM comentarios;
SELECT * FROM partido;


Esta linea es para comprobar que funciona el check por el cual un equipo no puede tener mas de 7 jugadores ni menos de 5

insert into equipo(nickequipo,numjugadores,procedencia,fechcreacion,nickentrenador,numdivision,region) values ('PRUEBA',8,'España','03/02/2013','PRUEBAA',1,'Europa');


Esta linea al igual que la anterior es para comprobar otra restricción, en este caso posicion tiene que tener uno de los 5 valores establecidos en la restriccion.
 
insert into jugador(nickjugador,nickequipo,nombre,apellido1,telefono,edad,posicion) values ('PRUEBA2','GIANTS','AlSDFro','SDFSD','623434372',22,'PRUEBA');