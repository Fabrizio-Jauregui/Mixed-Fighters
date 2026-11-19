# Historial de partidas en XAMPP

Instala esto una vez por computadora. Cada equipo mantiene su propia base MariaDB local.

## Paso 1: crear la base desde XAMPP

Inicia MySQL en XAMPP Control Panel y abre XAMPP Shell. Ejecuta:

    mysql -u root

Si root tiene contraseña, usa `mysql -u root -p`. En el prompt de MariaDB, pega:

    CREATE DATABASE IF NOT EXISTS mixed_fighters
      CHARACTER SET utf8mb4
      COLLATE utf8mb4_unicode_ci;
    USE mixed_fighters;
    CREATE TABLE IF NOT EXISTS peleas (
      id INT AUTO_INCREMENT PRIMARY KEY,
      resultado ENUM('JUGADOR_1', 'JUGADOR_2', 'EMPATE') NOT NULL,
      fecha TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    );
    SHOW TABLES;

Debe aparecer la tabla `peleas`. Sal de MariaDB con `exit`. No hace falta llevar ni importar el archivo SQL.

## Paso 2: instalar el puente PHP

Inicia Apache en XAMPP. Copia `conexion.php`, `guardar.php` y `marcador.php` de `xampp/mixedfighters` a:

    C:\xampp\htdocs\mixedfighters

Si esa carpeta no existe, créala. Los tres archivos deben quedar directamente ahí.

## Paso 3: configurar MariaDB

Abre `C:\xampp\htdocs\mixedfighters\conexion.php`. El valor por defecto es usuario `root`, contraseña vacía y base `mixed_fighters`. Si tu XAMPP usa una contraseña, cambia `$contrasena` en ese archivo.

## Paso 4: conectar Processing

`Mixed_Fighters_Sin_Box2D/O_Historial.pde` ya usa estas rutas locales:

    http://127.0.0.1/mixedfighters/guardar.php
    http://127.0.0.1/mixedfighters/marcador.php

No cambies nada con la configuración normal de Apache. Si usa otro puerto, agrega ese puerto a las dos rutas.

Processing envía el ganador a `guardar.php`. PHP lo inserta en MariaDB. Al entrar al menú, Processing pide los totales a `marcador.php`.

## Paso 5: iniciar el juego

Inicia Apache y MySQL, abre `Mixed_Fighters_Sin_Box2D/Mixed_Fighters_Sin_Box2D.pde` en Processing y pulsa Run. El menú muestra las victorias de ambos.

Si algún servicio, la conexión, la base o la tabla falla, el sketch se detiene con un error. No hay reintentos ni modo sin historial.

Repite los pasos en cada PC. Las bases quedan locales y no se sincronizan entre computadoras.
