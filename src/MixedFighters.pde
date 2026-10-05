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

Box2DProcessing box2d;


// ============================================================
// JUGADOR
// ============================================================

Jugador Jugador;
Jugador Jugador2;


// ============================================================
// MAPA
// ============================================================

PImage map1;


// ============================================================
// PLATAFORMAS
// ============================================================

ArrayList<platf> plataformas;


void setup() {

  fullScreen();

  // ----------------------------------------------------------
  // CARGAR MAPA
  // ----------------------------------------------------------

  map1 = loadImage("mapas/rooftops.jpg");
  map1.resize(width, height);


  // ----------------------------------------------------------
  // CREAR EL MUNDO DE BOX2D
  // ----------------------------------------------------------

  box2d = new Box2DProcessing(this);

  box2d.createWorld();

  box2d.setGravity(0, -10);


  // ----------------------------------------------------------
  // CREAR PLATAFORMAS
  // ----------------------------------------------------------

  plataformas = new ArrayList<platf>();


  // Plataforma superior izquierda
  plataformas.add(new platf(
    width * 0.245,
    height * 0.16,
    width * 0.25,
    20
    ));


  // Plataforma intermedia izquierda
  plataformas.add(new platf(
    width * 0.255,
    height * 0.46,
    width * 0.19,
    20
    ));


  // Plataforma inferior izquierda
  plataformas.add(new platf(
    width * 0.27,
    height * 0.65,
    width * 0.20,
    20
    ));


  // Plataforma superior derecha
  plataformas.add(new platf(
    width * 0.645,
    height * 0.44,
    width * 0.40,
    20
    ));


  // Plataforma inferior derecha
  plataformas.add(new platf(
    width * 0.65,
    height * 0.73,
    width * 0.40,
    20
    ));


  // ----------------------------------------------------------
  // CREAR JUGADOR
  // ----------------------------------------------------------

  Jugador = new Jugador(
    width/2,
    height/2,
    60,
    60
    );
    
      Jugador2 = new Jugador(
    width/4,
    height/8,
    60,
    60
    );
}


void draw() {

  // Dibujar el mapa.
  background(map1);


  // ----------------------------------------------------------
  // ACTUALIZAR FÍSICA
  // ----------------------------------------------------------

  box2d.step();


  // ----------------------------------------------------------
  // MOVIMIENTO DEL JUGADOR
  // ----------------------------------------------------------

  Jugador.mover(is_a, is_d);
  Jugador2.mover(is_LEFT, is_RIGHT);


  // ----------------------------------------------------------
  // DIBUJAR JUGADOR
  // ----------------------------------------------------------

  Jugador.dibujar();
  Jugador2.dibujar();
}
