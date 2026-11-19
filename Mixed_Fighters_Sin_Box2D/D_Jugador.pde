class Jugador {
  PVector pos;
  PVector vel;
  PVector acel;
  
  int vida = vidaInicial;
  int ultimaVezDanada = 0;
  int ultimaActualizacionRegeneracion = 0;
  float progresoRegeneracion = 0;
  boolean caidaEnCurso = false;
  float alturaMasAltaCaida = 0;
  
  float ancho;
  float alto;
  float gravedad = height * 0.0005;
  float velocidad = width * 0.003;
  float fuerzaSalto = height * 0.01;
  boolean enSuelo = false;
  boolean escalando = false;
  boolean atacando = false;
  boolean mirandoDerechaAlAtacar = true;
  int armaCuerpoACuerpoAlAtacar = TIPO_PUNOS;
  boolean golpeYaImpacto = false;
  int cuadroGolpe = 0;
  int inicioCuadroGolpe = 0;
  boolean retrocesoActivo = false;
  int inicioRetroceso = 0;
  float distanciaRetrocesoX = 0;
  float retrocesoAplicadoX = 0;
  boolean invertirX = false;
  boolean mirandoDerecha = true;
  color c;
  int armaCuerpoACuerpo = TIPO_PUNOS;
  int armaDeFuego = TIPO_PISTOLA;
  PImage spriteQuieto;
  PImage[] spritesCaminar;
  PImage[] spritesGolpe;
  PImage[] spritesGolpeHacha;
  int cuadroCaminar = 0;
  int ultimoCambioSprite = 0;
  int municionArma = capacidadMunicionPistola;
  PImage spriteDisparoPistola;
  PImage spriteDisparoFusil;
  PImage spriteDisparoActual;
  int inicioPoseDisparo = 0;
  boolean mirandoDerechaAlDisparar = true;
  int balasRafagaPendientes = 0;
  int momentoProximaBalaRafaga = 0;
  float xSalidaRafaga;
  float ySalidaRafaga;
  float direccionRafaga = 1;
  int danioRafaga;

  Jugador(float x, float y, float ancho, float alto, color c) {
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    acel = new PVector(0, 0);

    this.ancho = ancho;
    this.alto = alto;
    this.c = c;
  }

  void cargarSprites(String carpeta) {
    spriteQuieto = loadImage("sprites/" + carpeta + "/quieto_1.png");
    spritesCaminar = new PImage[4];

    for (int i = 0; i < spritesCaminar.length; i++) {
      spritesCaminar[i] = loadImage("sprites/" + carpeta + "/caminar_" + (i + 1) + ".png");
    }

    spritesGolpe = new PImage[] {
      loadImage("sprites/" + carpeta + "/ataque_fisico_2.png"),
      loadImage("sprites/" + carpeta + "/ataque_fisico_3.png"),
      loadImage("sprites/" + carpeta + "/ataque_fisico_5.png"),
      loadImage("sprites/" + carpeta + "/ataque_fisico_6.png")
    };
    spritesGolpeHacha = new PImage[] {
      loadImage("sprites/" + carpeta + "/ataque_arma_11.png"),
      loadImage("sprites/" + carpeta + "/ataque_arma_14.png"),
      loadImage("sprites/" + carpeta + "/ataque_arma_15.png")
    };
    spriteDisparoPistola = loadImage("sprites/" + carpeta + "/ataque_arma_25.png");
    spriteDisparoFusil = loadImage("sprites/" + carpeta + "/ataque_arma_29.png");
  }

  void reiniciar(float x, float y) {
    pos.set(x, y);
    vel.set(0, 0);
    acel.set(0, 0);
    enSuelo = false;
    escalando = false;
    atacando = false;
    golpeYaImpacto = false;
    armaCuerpoACuerpoAlAtacar = TIPO_PUNOS;
    cuadroGolpe = 0;
    inicioCuadroGolpe = 0;
    vida = vidaInicial;
    ultimaVezDanada = millis();
    ultimaActualizacionRegeneracion = ultimaVezDanada;
    progresoRegeneracion = 0;
    cancelarSeguimientoCaida();
    retrocesoActivo = false;
    inicioRetroceso = 0;
    distanciaRetrocesoX = 0;
    retrocesoAplicadoX = 0;
    invertirX = false;
    mirandoDerecha = true;
    cuadroCaminar = 0;
    municionArma = capacidadMunicionPistola;
    spriteDisparoActual = null;
    inicioPoseDisparo = 0;
    mirandoDerechaAlDisparar = true;
    balasRafagaPendientes = 0;
    momentoProximaBalaRafaga = 0;
    armaCuerpoACuerpo = TIPO_PUNOS;
    armaDeFuego = TIPO_PISTOLA;
  }

  void saltar() {
    if (enSuelo && !escalando && !atacando) {
      vel.y = -fuerzaSalto;
      enSuelo = false;
    }
  }

  void golpear() {
    if (!enSuelo || escalando || atacando || disparoActivo()) {
      return;
    }

    atacando = true;
    mirandoDerechaAlAtacar = mirandoDerecha;
    armaCuerpoACuerpoAlAtacar = armaCuerpoACuerpo;
    golpeYaImpacto = false;
    cuadroGolpe = 0;
    inicioCuadroGolpe = millis();
    vel.x = 0;
    acel.set(0, 0);
  }

  boolean puedeGolpear(Jugador objetivo) {
    if (!atacando || golpeYaImpacto || objetivo.vida <= 0) {
      return false;
    }

    int tiempoGolpe = millis() - inicioCuadroGolpe;
    if (tiempoGolpe < inicioVentanaGolpe || tiempoGolpe >= finVentanaGolpe) {
      return false;
    }

    float anchoGolpe = anchoHitboxGolpeActual();
    float altoGolpe = alto * altoProporcionHitboxGolpe;
    float direccion = mirandoDerechaAlAtacar ? 1 : -1;
    float centroGolpeX = pos.x + direccion * (ancho/2 + anchoGolpe/2);

    boolean tocaX =
      centroGolpeX + anchoGolpe/2 > objetivo.pos.x - objetivo.ancho/2 &&
      centroGolpeX - anchoGolpe/2 < objetivo.pos.x + objetivo.ancho/2;
    boolean tocaY =
      pos.y + altoGolpe/2 > objetivo.pos.y - objetivo.alto/2 &&
      pos.y - altoGolpe/2 < objetivo.pos.y + objetivo.alto/2;

    return tocaX && tocaY;
  }

  float anchoHitboxGolpeActual() {
    if (armaCuerpoACuerpoAlAtacar == TIPO_HACHA) {
      return ancho * proporcionAnchoHitboxHacha;
    }

    return ancho;
  }

  int danioGolpeActual() {
    if (armaCuerpoACuerpoAlAtacar == TIPO_HACHA) {
      return danioHacha;
    }

    return danioPunetazo;
  }

  void recibirGolpe(int danio, float direccion) {
    recibirDanio(danio);

    if (vida <= 0) {
      return;
    }

    retrocesoActivo = true;
    inicioRetroceso = millis();
    distanciaRetrocesoX = direccion * distanciaRetroceso;
    retrocesoAplicadoX = 0;
  }

  void recibirDanio(int danio) {
    if (vida <= 0) {
      return;
    }

    vida = max(0, vida - danio);
    ultimaVezDanada = millis();
    ultimaActualizacionRegeneracion = ultimaVezDanada;
    progresoRegeneracion = 0;
  }

  void equiparArma(int tipoArma) {
    if (tipoArma == TIPO_HACHA) {
      if (armaCuerpoACuerpo == TIPO_PUNOS) {
        armaCuerpoACuerpo = TIPO_HACHA;
      }
    } else if (tipoArma == TIPO_PISTOLA || tipoArma == TIPO_FUSIL) {
      armaDeFuego = tipoArma;
      municionArma = tipoArma == TIPO_PISTOLA ? capacidadMunicionPistola : capacidadMunicionFusil;
    }
  }

  Proyectil disparar() {
    if (atacando || disparoActivo() || escalando || armaDeFuego == TIPO_SIN_ARMA_FUEGO || municionArma <= 0) {
      return null;
    }

    boolean usandoFusil = armaDeFuego == TIPO_FUSIL;
    PImage spriteArma = usandoFusil ? spriteDisparoFusil : spriteDisparoPistola;
    float direccion = mirandoDerecha ? 1 : -1;
    danioRafaga = usandoFusil ? danioBalaFusil : danioProyectil;
    float anchoSpriteJugador = ancho;
    if (spriteArma != null) {
      anchoSpriteJugador = spriteArma.width * (alto / spriteArma.height);
    }

    xSalidaRafaga = pos.x + direccion * (anchoSpriteJugador * 0.45 + tamanoBala/2);
    ySalidaRafaga = pos.y - alto * 0.05;
    direccionRafaga = direccion;

    spriteDisparoActual = spriteArma;
    inicioPoseDisparo = millis();
    mirandoDerechaAlDisparar = mirandoDerecha;

    if (usandoFusil) {
      balasRafagaPendientes = min(cantidadBalasRafagaFusil - 1, municionArma - 1);
      momentoProximaBalaRafaga = millis() + intervaloBalasRafagaFusil;
    } else {
      balasRafagaPendientes = 0;
    }

    return crearBalaRafaga();
  }

  Proyectil crearBalaRafaga() {
    if (municionArma <= 0) {
      armaDeFuego = TIPO_SIN_ARMA_FUEGO;
      return null;
    }

    municionArma--;
    if (municionArma == 0) {
      armaDeFuego = TIPO_SIN_ARMA_FUEGO;
    }

    return new Proyectil(xSalidaRafaga, ySalidaRafaga, direccionRafaga, danioRafaga);
  }

  void actualizarRafaga() {
    if (balasRafagaPendientes <= 0 || millis() < momentoProximaBalaRafaga) {
      return;
    }

    Proyectil bala = crearBalaRafaga();
    if (bala != null) {
      proyectiles.add(bala);
    }

    balasRafagaPendientes--;
    momentoProximaBalaRafaga += intervaloBalasRafagaFusil;
  }

  boolean disparoActivo() {
    return spriteDisparoActual != null &&
      millis() - inicioPoseDisparo < duracionPoseDisparo;
  }

  void actualizarRegeneracion() {
    int ahora = millis();

    if (vida <= 0 || vida >= vidaInicial) {
      progresoRegeneracion = 0;
      ultimaActualizacionRegeneracion = ahora;
      return;
    }

    if (ahora - ultimaVezDanada < esperaRegeneracionVida) {
      progresoRegeneracion = 0;
      ultimaActualizacionRegeneracion = ahora;
      return;
    }

    int tiempoTranscurrido = ahora - ultimaActualizacionRegeneracion;
    progresoRegeneracion += tiempoTranscurrido / 1000.0 * puntosRegeneradosPorSegundo;

    int puntosRecuperados = (int) progresoRegeneracion;
    if (puntosRecuperados > 0) {
      vida = min(vidaInicial, vida + puntosRecuperados);
      progresoRegeneracion -= puntosRecuperados;
    }

    if (vida >= vidaInicial) {
      progresoRegeneracion = 0;
    }

    ultimaActualizacionRegeneracion = ahora;
  }

  void actualizarSeguimientoCaida() {
    if (escalando) {
      cancelarSeguimientoCaida();
      return;
    }

    if (enSuelo) {
      if (caidaEnCurso) {
        float distanciaCaida = pos.y - alturaMasAltaCaida;
        float umbralCaida = alto * alturasJugadorParaDanioCaida;

        if (distanciaCaida > umbralCaida) {
          int danio = ceil((distanciaCaida - umbralCaida) / pixelesPorPuntoDanioCaida);
          recibirDanio(danio);
        }
      }

      cancelarSeguimientoCaida();
    } else if (!caidaEnCurso) {
      caidaEnCurso = true;
      alturaMasAltaCaida = pos.y;
    } else {
      alturaMasAltaCaida = min(alturaMasAltaCaida, pos.y);
    }
  }

  void cancelarSeguimientoCaida() {
    caidaEnCurso = false;
    alturaMasAltaCaida = 0;
  }

  float actualizarRetroceso() {
    if (!retrocesoActivo) {
      return 0;
    }

    float progreso = constrain(
      (millis() - inicioRetroceso) / (float) duracionRetroceso,
      0,
      1
      );
    float distanciaActual = distanciaRetrocesoX * progreso;
    float desplazamiento = distanciaActual - retrocesoAplicadoX;
    retrocesoAplicadoX = distanciaActual;

    if (progreso >= 1) {
      retrocesoActivo = false;
      distanciaRetrocesoX = 0;
      retrocesoAplicadoX = 0;
    }

    return desplazamiento;
  }

  void dibujarHitboxGolpe() {
    int tiempoGolpe = millis() - inicioCuadroGolpe;
    if (!atacando || golpeYaImpacto || tiempoGolpe < inicioVentanaGolpe || tiempoGolpe >= finVentanaGolpe) {
      return;
    }

    float anchoGolpe = anchoHitboxGolpeActual();
    float altoGolpe = alto * altoProporcionHitboxGolpe;
    float direccion = mirandoDerechaAlAtacar ? 1 : -1;
    float centroGolpeX = pos.x + direccion * (ancho/2 + anchoGolpe/2);

    rectMode(CENTER);
    noFill();
    stroke(255, 0, 0);
    strokeWeight(2);
    rect(centroGolpeX, pos.y, anchoGolpe, altoGolpe);
    noStroke();
  }

  void dibujar() {
    if (atacando) {
      cuadroGolpe = (millis() - inicioCuadroGolpe) / 100;
      if (cuadroGolpe >= spritesGolpe.length) {
        atacando = false;
        cuadroGolpe = 0;
      }
    }

    if (!atacando) {
      if (vel.x > 0) {
        mirandoDerecha = true;
      } else if (vel.x < 0) {
        mirandoDerecha = false;
      }
    }

    boolean caminando = abs(vel.x) > 0.1;
    boolean poseDisparoActiva = spriteDisparoActual != null &&
      millis() - inicioPoseDisparo < duracionPoseDisparo;
    int armaAtaqueActual = atacando ? armaCuerpoACuerpoAlAtacar : armaCuerpoACuerpo;
    boolean usandoHacha = armaAtaqueActual == TIPO_HACHA;
    PImage[] spritesAtaqueActual = usandoHacha ? spritesGolpeHacha : spritesGolpe;
    PImage sprite = spriteQuieto;

    if (poseDisparoActiva) {
      sprite = spriteDisparoActual;
    } else if (atacando && spritesAtaqueActual != null) {
      int cuadroAtaque = min(cuadroGolpe, spritesAtaqueActual.length - 1);
      sprite = spritesAtaqueActual[cuadroAtaque];
      if (sprite == null) {
        sprite = spriteQuieto;
      }
    } else if (caminando && spritesCaminar != null) {
      if (millis() - ultimoCambioSprite >= 130) {
        cuadroCaminar = (cuadroCaminar + 1) % spritesCaminar.length;
        ultimoCambioSprite = millis();
      }
      sprite = spritesCaminar[cuadroCaminar];
    } else {
      cuadroCaminar = 0;
      ultimoCambioSprite = millis();
    }

    if (sprite == null) {
      rectMode(CENTER);
      noStroke();
      fill(c);
      rect(pos.x, pos.y, ancho, alto);
      return;
    }

    float altoSprite = alto;
    float anchoSprite = sprite.width * (altoSprite / sprite.height);
    float xSprite = pos.x - anchoSprite/2;
    float ySprite = pos.y + alto/2 - altoSprite;
    boolean dibujarDerecha = poseDisparoActiva ? mirandoDerechaAlDisparar :
      (atacando ? mirandoDerechaAlAtacar : mirandoDerecha);

    pushMatrix();
    if (!dibujarDerecha) {
      translate(pos.x, 0);
      scale(-1, 1);
      image(sprite, -anchoSprite/2, ySprite, anchoSprite, altoSprite);
    } else {
      image(sprite, xSprite, ySprite, anchoSprite, altoSprite);
    }
    popMatrix();
  }
  void dibujarHitbox() {
    rectMode(CENTER);
    noFill();
    stroke(0, 255, 0);
    strokeWeight(2);
    rect(pos.x, pos.y, ancho, alto);
    noStroke();
  }
}
