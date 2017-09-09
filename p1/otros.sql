Create VIEW clasificacion_INFO
AS SELECT nickequipo,puesto
FROM clasificacion
Where region= Europa;

alter user p1bloqueado account lock;

GRANT all ON clasificacion_info to p1entrenador;


CREATE VIEW CONTROLAR_JUGADORES
AS SELECT  nickjugador,nombre,apellido1,telefono,posicion
FROM jugador;

GRANT all ON CONTROLAR_JUGADORES to p1controladorliga;