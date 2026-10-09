class Jugador {

  int ancho, alto;
  Body cuerpo;
  BodyDef definicionCuerpo = new BodyDef();
  PolygonShape formaPoligonal = new PolygonShape();
  FixtureDef definicionFixture = new FixtureDef();
  
  Jugador(int posx, int posy, int ancho, int alto) {

    definicionCuerpo.type = BodyType.DYNAMIC;
    definicionCuerpo.fixedRotation = true;
    
    Vec2 posicionInicial = box2d.coordPixelsToWorld(
      posx,
      posy
      );

    this.ancho = ancho;
    this.alto = alto;

    formaPoligonal.setAsBox(ancho/20, alto/20);
    definicionCuerpo.position.set(posicionInicial);
    cuerpo = box2d.world.createBody(definicionCuerpo);
    definicionFixture.shape = formaPoligonal;
    definicionFixture.density = 0;
    definicionFixture.friction = 10;
    cuerpo.createFixture(definicionFixture);
  }

  void mover(boolean izq, boolean der) {
    Vec2 velocidadActual = cuerpo.getLinearVelocity();
    if (izq)
      cuerpo.setLinearVelocity(new Vec2(-10, velocidadActual.y));


    if (der)
      cuerpo.setLinearVelocity(new Vec2(10, velocidadActual.y));
  }
void saltar() {
  Vec2 vel = cuerpo.getLinearVelocity();
  if (Math.abs(vel.y) > 0) return;  // está en el aire, no saltar
  cuerpo.setLinearVelocity(new Vec2(vel.x, 11));
}

  void dibujar() {

    Vec2 posicionEnBox2D = cuerpo.getPosition();


    Vec2 posicionEnPixeles =
      box2d.coordWorldToPixels(posicionEnBox2D);


    rectMode(CENTER);


    rect(
      posicionEnPixeles.x,
      posicionEnPixeles.y,
      ancho,
      alto
      );
  }
  
void dibujarHitbox() {

  Fixture fixture = cuerpo.getFixtureList();
  PolygonShape forma = (PolygonShape) fixture.getShape();

  noFill();
  stroke(0, 255, 0);
  strokeWeight(2);

  beginShape();

  for (int i = 0; i < forma.getVertexCount(); i++) {

    Vec2 verticeMundo = cuerpo.getWorldPoint(
      forma.getVertex(i)
    );

    Vec2 verticePixel = box2d.coordWorldToPixels(
      verticeMundo
    );

    vertex(
      verticePixel.x,
      verticePixel.y
    );
  }

  endShape(CLOSE);
}
}
