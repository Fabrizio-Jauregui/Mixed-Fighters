class Jugador {

  int ancho, alto;
  Body cuerpo;
  BodyDef definicionCuerpo = new BodyDef();
  PolygonShape formaPoligonal = new PolygonShape();
  FixtureDef definicionFixture = new FixtureDef();
  
  Jugador(int posx, int posy, int ancho, int alto) {

    definicionCuerpo.type = BodyType.DYNAMIC;

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
    definicionFixture.density = 1;
    definicionFixture.friction = 0.5;
    cuerpo.createFixture(definicionFixture);
  }

  void mover(boolean izq, boolean der) {

    if (izq)
      cuerpo.setLinearVelocity(new Vec2(-5, 0));


    if (der)
      cuerpo.setLinearVelocity(new Vec2(5, 0));
  }
  void saltar() {

  cuerpo.setLinearVelocity(new Vec2(0, 8));

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
}
