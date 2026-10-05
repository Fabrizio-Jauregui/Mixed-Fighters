class platf {
  Body body;

  float x;
  float y;

  float ancho;
  float alto;
  PolygonShape formaPoligonal = new PolygonShape();
  FixtureDef definicionFixture = new FixtureDef();
  platf(float x, float y, float ancho, float alto) {

    this.x = x;
    this.y = y;

    this.ancho = ancho;
    this.alto = alto;
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
}
