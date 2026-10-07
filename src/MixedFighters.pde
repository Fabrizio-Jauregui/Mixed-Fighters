// Permite utilizar Box2D desde Processing.
import shiffman.box2d.*;

// Clases relacionadas con cuerpos físicos de Box2D.
import org.jbox2d.dynamics.*;

// Clases relacionadas con vectores, como Vec2.
import org.jbox2d.common.*;

// Clases relacionadas con las formas físicas, como PolygonShape.
import org.jbox2d.collision.shapes.*;
Box2DProcessing box2d;

Jugador Jugador;
Jugador Jugador2;

PImage map1;

ArrayList<platf> plataformas;


void setup() {

  fullScreen();
  map1 = loadImage("mapas/Rooftops.png");
  map1.resize(width, height);
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, -10);
  plataformas = new ArrayList<platf>();


  // Plataforma superior izquierda
  plataformas.add(new platf(
    width * 0.2265,
    height * 0.254,
    width * 0.210,
    20
    ));


  // Plataforma intermedia izquierda
  plataformas.add(new platf(
    width * 0.4737,
    height * 0.209,
    width * 0.209,
    7
    ));


  // Plataforma inferior izquierda
  plataformas.add(new platf(
    width * 0.217,
    height * 0.81,
    width * 0.23,
    20
    ));


  // Plataforma superior izquierda
  plataformas.add(new platf(
    width * 0.4898,
    height * 0.562,
    width * 0.1131,
    37
    ));
//Plataforma chiquita izquierda del medio
  plataformas.add(new platf(
    width * 0.6025,
    height * 0.55,
    width * 0.0199,
    15
    ));

//Plataforma mediana del medio
  plataformas.add(new platf(
    width * 0.678,
    height * 0.562,
    width * 0.04,
    37
    ));

//Plataforma chiquita de la derecha
  plataformas.add(new platf(
    width * 0.7547,
    height * 0.55,
    width * 0.0199,
    15
    ));
    
//Plataforma abajo de la puerta de arriba a la derecha
  plataformas.add(new platf(
    width * 0.8554,
    height * 0.562,
    width * 0.09,
    37
    ));

  // Plataforma del piso inferior derecho
  plataformas.add(new platf(
    width * 0.723,
    height * 0.882,
    width * 0.313,
    20
    ));

//Plataforma arriba de la escalera
  plataformas.add(new platf(
    width * 0.48175,
    height * 0.828,
    width * 0.0959,
    20
    ));

//Pared puerta derecha abajo
  plataformas.add(new platf(
    width * 0.884,
    height * 0.845,
    width * 0.009,
    95
    ));

//Pared puerta derecha arriba
  plataformas.add(new platf(
    width * 0.884,
    height * 0.5,
    width * 0.009,
    95
    ));

//Pared puerta izquierda arriba
  plataformas.add(new platf(
    width * 0.117,
    height * 0.2,
    width * 0.009,
    95
    ));

//Pared puerta izquierda abajo
  plataformas.add(new platf(
    width * 0.098,
    height * 0.77,
    width * 0.009,
    95
    ));

//pared escalera
  plataformas.add(new platf(
    width * 0.3219,
    height * 0.47,
    width * 0.019,
    470
    ));

  Jugador = new Jugador(
    width/2,
    height/2,
    20,
    40
    );
    
      Jugador2 = new Jugador(
    width/4,
    height/8,
    20,
    40
    );
}


void draw() {

  // Dibujar el mapa.
  background(map1);

  box2d.step();

  Jugador.mover(is_a, is_d);
  Jugador2.mover(is_LEFT, is_RIGHT);

  Jugador.dibujar();
  Jugador2.dibujar();
  
  for (platf plataforma : plataformas) {
    plataforma.dibujar();
  }
  fill(40, 200, 100);
}
