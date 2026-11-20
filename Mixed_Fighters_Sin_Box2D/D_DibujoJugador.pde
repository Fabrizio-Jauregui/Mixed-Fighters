// Carga imágenes y representa visualmente un jugador.
class DibujoJugador {
  PImage spriteQuieto;
  PImage[] spritesCaminar;
  PImage[] spritesGolpe;
  PImage[] spritesGolpeHacha;
  PImage spriteDisparoPistola;
  PImage spriteDisparoFusil;
  PImage spriteDisparoActual;

  int cuadroCaminar = 0;
  int ultimoCambioSprite = 0;
  int inicioPoseDisparo = 0;
  boolean mirandoDerechaAlDisparar = true;

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

  void reiniciar() {
    cuadroCaminar = 0;
    ultimoCambioSprite = 0;
    spriteDisparoActual = null;
    inicioPoseDisparo = 0;
    mirandoDerechaAlDisparar = true;
  }

  PImage spriteDisparoParaArma(int tipoArma) {
    return tipoArma == TIPO_FUSIL ? spriteDisparoFusil : spriteDisparoPistola;
  }

  float anchoSpriteDisparo(int tipoArma, float altoJugador, float anchoJugador) {
    PImage sprite = spriteDisparoParaArma(tipoArma);
    if (sprite == null) {
      return anchoJugador;
    }
    return sprite.width * (altoJugador / sprite.height);
  }

  void iniciarPoseDisparo(int tipoArma, boolean mirandoDerecha) {
    spriteDisparoActual = spriteDisparoParaArma(tipoArma);
    inicioPoseDisparo = millis();
    mirandoDerechaAlDisparar = mirandoDerecha;
  }

  boolean poseDisparoActiva() {
    return spriteDisparoActual != null &&
      millis() - inicioPoseDisparo < duracionPoseDisparo;
  }

  void dibujar(Jugador jugador) {
    if (jugador.atacando) {
      jugador.cuadroGolpe = (millis() - jugador.inicioAnimacionGolpe) / 100;
      if (jugador.cuadroGolpe >= spritesGolpe.length) {
        jugador.atacando = false;
        jugador.cuadroGolpe = 0;
      }
    }

    if (!jugador.atacando) {
      if (jugador.velocidadActual.x > 0) {
        jugador.mirandoDerecha = true;
      } else if (jugador.velocidadActual.x < 0) {
        jugador.mirandoDerecha = false;
      }
    }

    boolean caminando = abs(jugador.velocidadActual.x) > 0.1;
    boolean disparando = poseDisparoActiva();
    int tipoArmaGolpe = jugador.atacando ? jugador.armaCuerpoACuerpoAlAtacar : jugador.armaCuerpoACuerpo;
    PImage[] spritesAtaque = tipoArmaGolpe == TIPO_HACHA ? spritesGolpeHacha : spritesGolpe;
    PImage sprite = spriteQuieto;

    if (disparando) {
      sprite = spriteDisparoActual;
    } else if (jugador.atacando && spritesAtaque != null) {
      int cuadroAtaque = min(jugador.cuadroGolpe, spritesAtaque.length - 1);
      sprite = spritesAtaque[cuadroAtaque];
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
      fill(jugador.c);
      rect(jugador.posicion.x, jugador.posicion.y, jugador.ancho, jugador.alto);
      return;
    }

    float altoSprite = jugador.alto;
    float anchoSprite = sprite.width * (altoSprite / sprite.height);
    float xSprite = jugador.posicion.x - anchoSprite/2;
    float ySprite = jugador.posicion.y + jugador.alto/2 - altoSprite;
    boolean dibujarDerecha = disparando ? mirandoDerechaAlDisparar :
      (jugador.atacando ? jugador.mirandoDerechaAlAtacar : jugador.mirandoDerecha);

    pushMatrix();
    if (!dibujarDerecha) {
      translate(jugador.posicion.x, 0);
      scale(-1, 1);
      image(sprite, -anchoSprite/2, ySprite, anchoSprite, altoSprite);
    } else {
      image(sprite, xSprite, ySprite, anchoSprite, altoSprite);
    }
    popMatrix();
  }
}
