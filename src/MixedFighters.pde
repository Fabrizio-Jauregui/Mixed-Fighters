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

ArrayList<plataforma> plataformas;


void setup() {

  fullScreen();
  map1 = loadImage("mapas/Rooftops.png");
  map1.resize(width, height);
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, -10);
  plataformas = new ArrayList<plataforma>();
  
  CrearPlataformas();
      
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
  
  Jugador.dibujarHitbox();
  Jugador2.dibujarHitbox();
  
  for (plataforma plataforma : plataformas) {
    plataforma.dibujar();
  }
  fill(40, 200, 100);
}
