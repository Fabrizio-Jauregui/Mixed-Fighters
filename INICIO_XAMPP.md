# Historial de partidas con XAMPP

El juego se conecta directamente desde Processing a MariaDB. No necesita Apache ni archivos PHP.

## Primera ejecucion

1. Abre XAMPP Control Panel y enciende **MySQL**.
2. Abre `Mixed_Fighters_Sin_Box2D.pde` con Processing 4 y pulsa **Run**.
3. Processing crea automaticamente la base `mixed_fighters` y la tabla `peleas` si todavia no existen.

La carpeta `Mixed_Fighters_Sin_Box2D/code` ya incluye MariaDB Connector/J, que permite la conexion Java con la base.

## Usuario y contrasena

Por defecto, el proyecto usa el usuario local `root`, sin contrasena y el puerto `3306` (configuracion habitual de XAMPP). Si tu instalacion tiene otra contrasena, abre `O_Historial.pde` y cambia `contrasenaBD`. Si el puerto es distinto, cambia `3306` en `servidorBD`.

El marcador cuenta las victorias de cada jugador. Los empates tambien se guardan en `peleas`, aunque no suman victorias.

Cada computadora mantiene su propia base de datos local; no se sincronizan entre equipos.
