# Mixed Fighters

Prototipo de juego local para dos jugadores, inspirado en *Superfighters*. Está desarrollado en Processing y usa un motor de colisiones propio.

## Abrir y ejecutar

1. Instala Processing 4.
2. Abre la carpeta `Mixed_Fighters_Sin_Box2D` desde Processing o abre directamente `Mixed_Fighters_Sin_Box2D.pde` dentro de esa carpeta.
3. Pulsa **Run** para iniciar el sketch.

La carpeta del sketch y el archivo principal tienen el mismo nombre, como espera Processing. Los recursos que carga el juego están dentro de `Mixed_Fighters_Sin_Box2D/data`.

## Mapa del código

Las pestañas `.pde` se mantienen juntas en la carpeta del sketch porque Processing las combina al compilar. El prefijo con letra indica el orden sugerido para recorrerlas:

| Pestaña | Responsabilidad |
| --- | --- |
| `Mixed_Fighters_Sin_Box2D.pde` | Punto de entrada: inicializa el juego y coordina cada cuadro (`setup()` y `draw()`). |
| `A_EstadoDelJuego.pde` | Estado compartido: jugadores, recursos, controles y opciones de depuración. |
| `B_EstadosJuego.pde` | Dibujo y actualización del inicio, la partida y la pantalla de resultado. |
| `C_Controles.pde` | Traduce eventos del teclado a acciones y estados de entrada. |
| `D_Jugador.pde` | Datos y comportamiento propio del jugador, como saltar, reiniciar y dibujarse. |
| `E_Plataforma.pde` | Plataforma y lógica de teletransporte existente. |
| `F_MotorFisico.pde` | Movimiento, gravedad y resolución de colisiones. |
| `G_CrearPlataformas.pde` | Ubicaciones y dimensiones de las plataformas del mapa. |
| `O_Historial.pde` | Guarda resultados y consulta el marcador local directamente en MariaDB con JDBC. |

Para agregar una mecánica, empieza en el grupo responsable de esa mecánica; deja en el archivo principal solo la coordinación general. Para sumar una entidad, crea una pestaña `.pde` con su clase y agrega su creación o actualización al flujo del juego donde corresponda.

## Recursos

- `Mixed_Fighters_Sin_Box2D/data/mapas/`: mapa y pantalla de carga usados por el sketch.
- `Mixed_Fighters_Sin_Box2D/data/sprites/`: archivo de sprites del proyecto.
- `docs/`: roadmap y notas de investigación.
- `docs/libreria/`: JBox2D y Processing Box2D guardados como referencia. El juego actual no los utiliza; la física está implementada en `F_MotorFisico.pde`.

## Controles implementados actualmente

- `A` / `D`: movimiento horizontal del jugador 1.
- `←` / `→`: movimiento horizontal del jugador 2.
- `W`: salto del jugador 1.
- `↑`: salto del jugador 2.
- `Enter`: comenzar desde el menú o reiniciar desde el resultado.
- `P`: mostrar u ocultar las plataformas dibujadas.
- `H`: mostrar u ocultar las hitboxes de los jugadores.

Las mecánicas de combate, armas, granadas, agacharse y habilidades descritas originalmente son ideas para el desarrollo futuro; todavía no están implementadas en el código actual.

## Tecnologías

- Processing 4 / Java mode.
- Física y colisiones implementadas dentro del proyecto.

## Historial local con XAMPP

El juego se conecta directamente desde Processing a MariaDB con JDBC. No necesita Apache ni PHP. Enciende **MySQL** en XAMPP y ejecuta el sketch; Processing crea la base y la tabla si hacen falta. La configuracion (usuario, contrasena y puerto) esta en Mixed_Fighters_Sin_Box2D/O_Historial.pde. Consulta [INICIO_XAMPP.md](INICIO_XAMPP.md).
