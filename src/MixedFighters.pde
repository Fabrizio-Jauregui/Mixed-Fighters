import shiffman.box2d.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.common.*;
import org.jbox2d.collision.shapes.*;

Box2DProcessing box2d;
Body body;

void setup() {
  size(800, 800);

  // Crear el mundo de Box2D
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, -10);

  // Configurar el Body
  BodyDef bd = new BodyDef();
  bd.type = BodyType.DYNAMIC;

  // Convertir posición de píxeles a coordenadas de Box2D
  Vec2 posicion = box2d.coordPixelsToWorld(width/2, height/2);
  bd.position.set(posicion);

  // Crear el Body dentro del mundo
  body = box2d.world.createBody(bd);

  // Crear la forma rectangular
  PolygonShape ps = new PolygonShape();
  ps.setAsBox(1, 1);

  // Configurar el Fixture
  FixtureDef fd = new FixtureDef();
  fd.shape = ps;
  fd.density = 1;
  fd.friction = 0.5;

  // Unir el Fixture al Body
  body.createFixture(fd);
}

void draw() {
  background(200);

  // Actualizar la simulación física
  box2d.step();

  // Obtener la posición actual del Body
  Vec2 posPixel = box2d.coordWorldToPixels(body.getPosition());

  // Dibujar el cuerpo
  rectMode(CENTER);
  rect(posPixel.x, posPixel.y, 60, 60);
}
