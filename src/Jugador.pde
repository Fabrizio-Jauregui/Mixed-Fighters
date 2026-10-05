// ============================================================
// CLASE JUGADOR
// ============================================================

class Jugador {


  // ----------------------------------------------------------
  // DATOS DEL JUGADOR
  // ----------------------------------------------------------

  int ancho, alto;


  // ----------------------------------------------------------
  // CUERPO FÍSICO
  // ----------------------------------------------------------

  Body cuerpo;


  BodyDef definicionCuerpo = new BodyDef();


  PolygonShape formaPoligonal = new PolygonShape();


  FixtureDef definicionFixture = new FixtureDef();


  // ==========================================================
  // CONSTRUCTOR
  // ==========================================================

  Jugador(int posx, int posy, int ancho, int alto) {


    // El jugador es dinámico.
    definicionCuerpo.type = BodyType.DYNAMIC;


    // --------------------------------------------------------
    // POSICIÓN INICIAL
    // --------------------------------------------------------

    Vec2 posicionInicial = box2d.coordPixelsToWorld(
      posx,
      posy
      );


    this.ancho = ancho;
    this.alto = alto;


    // --------------------------------------------------------
    // FORMA FÍSICA
    // --------------------------------------------------------

    formaPoligonal.setAsBox(ancho/20, alto/20);


    definicionCuerpo.position.set(posicionInicial);


    // --------------------------------------------------------
    // CREAR BODY
    // --------------------------------------------------------

    cuerpo = box2d.world.createBody(definicionCuerpo);


    // --------------------------------------------------------
    // CONFIGURAR FIXTURE
    // --------------------------------------------------------

    definicionFixture.shape = formaPoligonal;

    definicionFixture.density = 1;

    definicionFixture.friction = 0.5;


    // --------------------------------------------------------
    // CREAR FIXTURE
    // --------------------------------------------------------

    cuerpo.createFixture(definicionFixture);
  }


  // ==========================================================
  // MOVIMIENTO
  // ==========================================================

  void mover(boolean izq, boolean der) {

    if (izq)
      cuerpo.setLinearVelocity(new Vec2(-5, 0));


    if (der)
      cuerpo.setLinearVelocity(new Vec2(5, 0));
  }
  void saltar() {

  cuerpo.setLinearVelocity(new Vec2(0, 8));

}


  // ==========================================================
  // DIBUJAR
  // ==========================================================

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
