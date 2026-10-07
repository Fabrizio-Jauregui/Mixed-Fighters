class plataforma {
  Body body;

  float x;
  float y;
  color colorplataforma;
  float ancho;
  float alto;
  PolygonShape formaPoligonal = new PolygonShape();
  FixtureDef definicionFixture = new FixtureDef();
  plataforma(float x, float y, float ancho, float alto) {

    this.x = x;
    this.y = y;

    this.ancho = ancho;
    this.alto = alto;
    this.colorplataforma = color(255,0,0);
    BodyDef definicionCuerpo = new BodyDef();


    // La plataforma NO se mueve.
    definicionCuerpo.type = BodyType.STATIC;


    // Convertir la posición de píxeles a Box2D.
    Vec2 posicion = box2d.coordPixelsToWorld(x, y);


    definicionCuerpo.position.set(posicion);


    // Crear el Body.
    body = box2d.world.createBody(definicionCuerpo);

    formaPoligonal.setAsBox(
      ancho/20,
      alto/20
      );

    definicionFixture.shape = formaPoligonal;

    definicionFixture.friction = 0.5;


    // Crear el Fixture.
    body.createFixture(definicionFixture);
  }
  
  void dibujar() {

  Vec2 posicionEnBox2D = body.getPosition();

  Vec2 posicionEnPixeles =
    box2d.coordWorldToPixels(posicionEnBox2D);

  rectMode(CENTER);

  fill(colorplataforma);

  rect(
    posicionEnPixeles.x,
    posicionEnPixeles.y,
    ancho,
    alto
  );
}
}
