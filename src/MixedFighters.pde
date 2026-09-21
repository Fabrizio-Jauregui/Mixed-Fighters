// ============================================================
// IMPORTACIONES
// ============================================================

// Permite utilizar Box2D desde Processing.
import shiffman.box2d.*;

// Clases relacionadas con cuerpos físicos de Box2D.
import org.jbox2d.dynamics.*;

// Clases relacionadas con vectores, como Vec2.
import org.jbox2d.common.*;

// Clases relacionadas con las formas físicas, como PolygonShape.
import org.jbox2d.collision.shapes.*;


// ============================================================
// BOX2D
// ============================================================

// Objeto que conecta nuestro programa de Processing con Box2D.
// A través de este objeto podemos crear el mundo físico,
// avanzar la simulación y realizar conversiones entre
// coordenadas de Processing y coordenadas de Box2D.
Box2DProcessing box2d;


// ============================================================
// JUGADOR
// ============================================================

// Variable que va a guardar nuestro objeto Jugador.
//
// La primera palabra "Jugador" indica el tipo de objeto.
// La segunda "Jugador" es el nombre de la variable.
//
// Más adelante sería recomendable utilizar un nombre como
// "jugador" para diferenciar el tipo de la variable,
// pero por ahora funciona de esta manera.
Jugador Jugador;


void setup() {

  // Crear una ventana de 800 x 800 píxeles.
  size(800, 800);


  // ----------------------------------------------------------
  // CREAR EL MUNDO DE BOX2D
  // ----------------------------------------------------------

  // Crear el objeto que permite utilizar Box2D.
  box2d = new Box2DProcessing(this);

  // Crear el mundo físico.
  box2d.createWorld();

  // Establecer la gravedad del mundo.
  //
  // El eje Y de Box2D está orientado de una manera diferente
  // al eje Y que utilizamos normalmente en Processing.
  //
  // Por eso, este valor genera una gravedad que hace que
  // los cuerpos caigan hacia abajo en la pantalla.
  box2d.setGravity(0, -10);


  // ----------------------------------------------------------
  // CREAR AL JUGADOR
  // ----------------------------------------------------------

  // Crear un nuevo objeto Jugador.
  //
  // width/2  -> posición X en el centro de la pantalla.
  // height/2 -> posición Y en el centro de la pantalla.
  // 60       -> ancho visual del jugador.
  // 60       -> alto visual del jugador.
  //
  // El constructor de Jugador se encargará de crear
  // su cuerpo físico dentro de Box2D.
  Jugador = new Jugador(width/2, height/2, 60, 60);
}


void draw() {

  // Limpiar la pantalla en cada frame.
  background(200);


  // ----------------------------------------------------------
  // ACTUALIZAR LA FÍSICA
  // ----------------------------------------------------------

  // Avanzar la simulación de Box2D un paso.
  //
  // Acá Box2D calcula cosas como:
  // - gravedad
  // - movimiento
  // - velocidad
  // - colisiones
  // - etc.
  box2d.step();


  // ----------------------------------------------------------
  // ACTUALIZAR EL MOVIMIENTO DEL JUGADOR
  // ----------------------------------------------------------

  // Le indicamos al jugador si se está presionando
  // izquierda (A) o derecha (D).
  //
  // is_a e is_d son variables booleanas que se actualizan
  // mediante keyPressed() y keyReleased().
  Jugador.mover(is_a, is_d);


  // Dibujar al jugador en su posición actual.
  Jugador.dibujar();
}
