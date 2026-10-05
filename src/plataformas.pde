// ============================================================
// CLASE PLATAFORMA
// ============================================================

class platf {


  // ----------------------------------------------------------
  // CUERPO FÍSICO
  // ----------------------------------------------------------

  Body body;


  // ----------------------------------------------------------
  // DATOS DE LA PLATAFORMA
  // ----------------------------------------------------------

  float x;
  float y;

  float ancho;
  float alto;


  // ----------------------------------------------------------
  // FORMA FÍSICA
  // ----------------------------------------------------------

  PolygonShape formaPoligonal = new PolygonShape();


  // ----------------------------------------------------------
  // CONFIGURACIÓN DEL FIXTURE
  // ----------------------------------------------------------

  FixtureDef definicionFixture = new FixtureDef();


  // ==========================================================
  // CONSTRUCTOR
  // ==========================================================

  platf(float x, float y, float ancho, float alto) {

    this.x = x;
    this.y = y;

    this.ancho = ancho;
    this.alto = alto;


    // --------------------------------------------------------
    // CREAR BODY
    // --------------------------------------------------------

    BodyDef definicionCuerpo = new BodyDef();


    // La plataforma NO se mueve.
    definicionCuerpo.type = BodyType.STATIC;


    // Convertir la posición de píxeles a Box2D.
    Vec2 posicion = box2d.coordPixelsToWorld(x, y);


    definicionCuerpo.position.set(posicion);


    // Crear el Body.
    body = box2d.world.createBody(definicionCuerpo);


    // --------------------------------------------------------
    // CREAR FORMA
    // --------------------------------------------------------

    formaPoligonal.setAsBox(
      ancho/20,
      alto/20
      );


    // --------------------------------------------------------
    // CREAR FIXTURE
    // --------------------------------------------------------

    definicionFixture.shape = formaPoligonal;

    definicionFixture.friction = 0.5;


    // Crear el Fixture.
    body.createFixture(definicionFixture);
  }
}
