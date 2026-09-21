 //<>// //<>//

// ============================================================
// CLASE JUGADOR
// ============================================================

class Jugador {


  // ----------------------------------------------------------
  // DATOS DEL JUGADOR
  // ----------------------------------------------------------

  // Guardan el tamaño visual del jugador.
  //
  // Estos valores pertenecen a cada objeto Jugador.
  int ancho, alto;


  // ----------------------------------------------------------
  // CUERPO FÍSICO
  // ----------------------------------------------------------

  // Body representa el cuerpo físico del jugador dentro
  // del mundo de Box2D.
  //
  // Este objeto es el que realmente tiene una posición,
  // velocidad, gravedad, etc.
  Body cuerpo;


  // BodyDef es la definición que utilizamos para configurar
  // un Body antes de crearlo.
  BodyDef definicionCuerpo = new BodyDef();


  // PolygonShape representa la forma física que tendrá
  // nuestro jugador.
  //
  // En este caso utilizamos un rectángulo.
  PolygonShape formaPoligonal = new PolygonShape();


  // FixtureDef contiene la configuración del Fixture.
  //
  // El Fixture es lo que conecta la forma física con
  // propiedades físicas como densidad y fricción.
  FixtureDef definicionFixture = new FixtureDef();


  // ==========================================================
  // CONSTRUCTOR
  // ==========================================================

  // Este constructor se ejecuta cuando hacemos:
  //
  // new Jugador(posX, posY, ancho, alto)
  //
  // Su trabajo es crear y configurar el cuerpo físico
  // del jugador.
  Jugador(int posx, int posy, int ancho, int alto) {


    // Indicar que el cuerpo será DINÁMICO.
    //
    // Un cuerpo dinámico es afectado por la gravedad
    // y puede moverse mediante la física de Box2D.
    definicionCuerpo.type = BodyType.DYNAMIC;


    // --------------------------------------------------------
    // POSICIÓN INICIAL
    // --------------------------------------------------------

    // Processing trabaja normalmente en píxeles.
    // Box2D utiliza sus propias unidades físicas.
    //
    // Esta función convierte una posición expresada
    // en píxeles a una posición que Box2D pueda utilizar.
    Vec2 posicionInicial = box2d.coordPixelsToWorld(
      posx,
      posy
      );


    // Guardar el ancho y alto recibidos por el constructor
    // dentro del objeto Jugador.
    //
    // "this.ancho" significa el atributo "ancho" de este objeto.
    // "ancho" a la derecha corresponde al parámetro recibido.
    this.ancho = ancho;
    this.alto = alto;


    // --------------------------------------------------------
    // CREAR LA FORMA FÍSICA
    // --------------------------------------------------------

    // Configurar la forma como una caja.
    //
    // setAsBox() recibe la mitad del ancho y la mitad del alto
    // de la forma física.
    //
    // El /20 funciona en este proyecto como una conversión
    // aproximada entre píxeles y unidades de Box2D.
    formaPoligonal.setAsBox(ancho/20, alto/20);


    // Establecer la posición inicial del cuerpo.
    definicionCuerpo.position.set(posicionInicial);


    // --------------------------------------------------------
    // CREAR EL BODY
    // --------------------------------------------------------

    // Crear realmente el Body dentro del mundo de Box2D
    // utilizando la configuración que preparamos.
    cuerpo = box2d.world.createBody(definicionCuerpo);


    // --------------------------------------------------------
    // CONFIGURAR EL FIXTURE
    // --------------------------------------------------------

    // Indicar qué forma física utilizará el Fixture.
    definicionFixture.shape = formaPoligonal;


    // Indicar la densidad del objeto.
    //
    // La densidad influye en propiedades físicas como su masa.
    definicionFixture.density = 1;


    // Indicar la fricción del objeto.
    //
    // Influye en cómo interactúa físicamente con otros cuerpos.
    definicionFixture.friction = 0.5;


    // --------------------------------------------------------
    // UNIR EL FIXTURE AL BODY
    // --------------------------------------------------------

    // Crear el Fixture dentro del Body.
    //
    // En este momento el jugador ya tiene:
    //
    // Body
    //   └── Fixture
    //         └── PolygonShape
    //
    // y por lo tanto ya tiene una representación física
    // dentro del mundo de Box2D.
    cuerpo.createFixture(definicionFixture);
  }


  // ==========================================================
  // MOVIMIENTO
  // ==========================================================

  // Recibe dos valores booleanos:
  //
  // izq  -> indica si se está presionando A.
  // der  -> indica si se está presionando D.
  void mover(boolean izq, boolean der) {


    // Si se está presionando izquierda (A),
    // establecer una velocidad horizontal negativa.
    //
    // X negativa = movimiento hacia la izquierda.
    // Y = 0     = no modificar la velocidad vertical.
    if (izq)
      cuerpo.setLinearVelocity(new Vec2(-5, 0));


    // Si se está presionando derecha (D),
    // establecer una velocidad horizontal positiva.
    //
    // X positiva = movimiento hacia la derecha.
    if (der)
      cuerpo.setLinearVelocity(new Vec2(5, 0));
  }


  // ==========================================================
  // DIBUJAR
  // ==========================================================

  void dibujar() {


    // Obtener la posición actual del Body en las coordenadas
    // internas de Box2D.
    //
    // Esta posición puede haber cambiado debido a la gravedad,
    // movimiento o colisiones.
    Vec2 posicionEnBox2D = cuerpo.getPosition();


    // Convertir la posición de Box2D a píxeles de Processing.
    //
    // Ahora podemos utilizar esa posición para dibujar
    // el jugador en la pantalla.
    Vec2 posicionEnPixeles =
      box2d.coordWorldToPixels(posicionEnBox2D);


    // Indicar que las coordenadas utilizadas por rect()
    // representan el CENTRO del rectángulo.
    rectMode(CENTER);


    // Dibujar visualmente al jugador.
    //
    // Es importante entender que este rectángulo NO es
    // el cuerpo físico de Box2D.
    //
    // Es solamente la representación visual del Body.
    rect(
      posicionEnPixeles.x,
      posicionEnPixeles.y,
      ancho,
      alto
      );
  }
}
