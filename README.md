# Mixed Fighters

Juego local para dos personas, desarrollado en Processing. El sketch usa un motor físico propio y el mapa Rooftops.

## Abrir y ejecutar

1. Abre `Mixed_Fighters_Sin_Box2D` en Processing 4.
2. Ejecuta `Mixed_Fighters_Sin_Box2D.pde` con **Run**.

El archivo principal y la carpeta del sketch tienen el mismo nombre. Los recursos gráficos están dentro de `Mixed_Fighters_Sin_Box2D/data`.

## Recorrido recomendado para aprender el código

Sigue el flujo del programa desde el punto de entrada y luego elige una mecánica:

1. `Mixed_Fighters_Sin_Box2D.pde`: prepara recursos y objetos en `setup()`; coordina cada cuadro desde `draw()`.
2. `Mixed_Fighters_Sin_Box2D.pde`: revisa las variables compartidas al inicio del archivo, antes de `setup()`.
3. `B_EstadosJuego.pde`: coordina menú, partida y resultado. Aquí se ve el orden de actualización de cada cuadro.
4. `C_Controles.pde`: convierte pulsaciones y liberaciones en acciones y estados de teclado.
5. `D_Jugador.pde`: datos y acciones del personaje, incluyendo movimiento, combate, armas, vida y dibujo.
6. `F_MotorFisico.pde`, `E_Plataforma.pde` y `G_CrearPlataformas.pde`: movimiento, colisiones y geometrías del escenario.
7. `L_Combate.pde`: parámetros y resolución de golpes cuerpo a cuerpo.
8. `M_Inventario.pde`, `J_Armas.pde`, `N_Proyectiles.pde` y `K_Hud.pde`: tipos de armas, puntos de aparición, balas e indicadores.
9. `K_EscaleraMarinera.pde` y `H_Portales.pde`: zonas de escalada y teletransporte.
10. `O_Historial.pde`: consulta y guarda resultados en MariaDB local.

Para entender una acción, síguela por todas las pestañas. Por ejemplo, un disparo empieza en `C_Controles.pde`, pasa por `Jugador.disparar()` y continúa en `N_Proyectiles.pde`.

## Pestañas y responsabilidades

| Archivo | Responsabilidad |
| --- | --- |
| `Mixed_Fighters_Sin_Box2D.pde` | Punto de entrada y configuración inicial. |
| `B_EstadosJuego.pde` | Menú, actualización de partida y resultado. |
| `C_Controles.pde` | Entrada del teclado y solicitud de acciones. |
| `D_Jugador.pde` | Estado y comportamiento de cada jugador. |
| `E_Plataforma.pde` | Datos y dibujo de una plataforma. |
| `F_MotorFisico.pde` | Gravedad, movimiento, escalada y colisiones. |
| `G_CrearPlataformas.pde` | Geometrías sólidas del mapa. |
| `H_Portales.pde` | Teletransportes entre accesos. |
| `J_Armas.pde` | Puntos de aparición, ciclos y recogida de armas. |
| `K_EscaleraMarinera.pde` | Zona de interacción de la escalera central. |
| `K_Hud.pde` | Dibujo de vida, armas y munición. |
| `L_Combate.pde` | Parámetros y resolución de golpes. |
| `M_Inventario.pde` | Identificadores de armas y parámetros de munición/proyectil. |
| `N_Proyectiles.pde` | Movimiento, colisión y eliminación de balas. |
| `O_Historial.pde` | Persistencia local de resultados mediante JDBC. |

Processing combina las pestañas `.pde` del sketch al compilar. Las funciones pueden comunicarse entre pestañas porque forman parte del mismo programa.

## Controles actuales

- Jugador 1: `A`/`D` mueve, `W` salta, `S` agacha, `1` golpea y `2` dispara.
- Jugador 2: flechas izquierda/derecha mueven, arriba salta, abajo agacha, `N` golpea y `M` dispara.
- En la escalera central, arriba y abajo permiten subir y bajar.
- `Enter` comienza desde el menú y vuelve al menú desde el resultado.
- `P` muestra u oculta las plataformas de depuración; `H` muestra u oculta las hitboxes.

El fusil dispara una bala por pulsación, igual que la pistola, y tiene más munición por cargador. La vida no se regenera. El HUD muestra la vida, las armas equipadas y la munición restante.

## Recursos

- `Mixed_Fighters_Sin_Box2D/data/mapas/`: mapa y pantalla de carga.
- `Mixed_Fighters_Sin_Box2D/data/sprites/`: sprites de personajes.
- `Mixed_Fighters_Sin_Box2D/data/armas/`: imágenes de armas recogibles e iconos.
- `Mixed_Fighters_Sin_Box2D/data/hud/`: bases gráficas del HUD.

## Historial local con XAMPP

El sketch se conecta directamente a MariaDB mediante JDBC; Apache y PHP no son necesarios. Enciende **MySQL** en XAMPP antes de ejecutar el juego. La primera ejecución crea la base `mixed_fighters` y la tabla `peleas`. La conexión local se configura en `Mixed_Fighters_Sin_Box2D/O_Historial.pde`; consulta [INICIO_XAMPP.md](INICIO_XAMPP.md).
