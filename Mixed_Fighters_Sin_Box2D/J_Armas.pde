class Armas {
  float x;
  float y;
  float ancho;
  float alto;
  PImage[] spritesDisponibles;
  PImage spriteActual;
  int tipoArmaActual = -1;
  boolean disponible = true;
  int inicioCiclo = 0;
  boolean cicloIniciado = false;
  final int duracionCiclo = 30000;

  Armas(float x, float y, float ancho, float alto, PImage[] spritesDisponibles) {
    this.x = x;
    this.y = y;
    this.ancho = ancho;
    this.alto = alto;
    this.spritesDisponibles = spritesDisponibles;
  }

  void dibujar(float altoJugador) {
    if (disponible && spriteActual != null) {
      float dimensionMaxima = altoJugador * 0.70;
      float escala = dimensionMaxima / max(spriteActual.width, spriteActual.height);
      float anchoSprite = spriteActual.width * escala;
      float altoSprite = spriteActual.height * escala;

      image(spriteActual, x - anchoSprite/2, y - altoSprite/2, anchoSprite, altoSprite);
    }
  }

  void actualizar() {
    int tiempoActual = millis();

    if (!cicloIniciado) {
      inicioCiclo = tiempoActual;
      cicloIniciado = true;
      spriteActual = elegirSprite();
      return;
    }

    if (tiempoActual - inicioCiclo >= duracionCiclo) {
      disponible = true;
      spriteActual = elegirSprite();
      inicioCiclo = tiempoActual;
    }
  }

  PImage elegirSprite() {
    tipoArmaActual = (int) random(spritesDisponibles.length);
    return spritesDisponibles[tipoArmaActual];
  }

  boolean recogerSiCorresponde(Jugador jugador, boolean agachado) {
    if (!disponible || !agachado) {
      return false;
    }

    boolean seSuperponeHorizontalmente =
      jugador.posicion.x + jugador.ancho/2 >= x - ancho/2 &&
      jugador.posicion.x - jugador.ancho/2 <= x + ancho/2;

    boolean seSuperponeVerticalmente =
      jugador.posicion.y + jugador.alto/2 >= y - alto/2 &&
      jugador.posicion.y - jugador.alto/2 <= y + alto/2;

    if (seSuperponeHorizontalmente && seSuperponeVerticalmente) {
      disponible = false;
      return true;
    }

    return false;
  }

  void reiniciar() {
    disponible = true;
    inicioCiclo = 0;
    cicloIniciado = false;
    spriteActual = null;
    tipoArmaActual = -1;
  }
}

void actualizarPuntosArmas(Jugador jugador1, boolean agachado1, Jugador jugador2, boolean agachado2) {
  if (millis() - inicioArmas < retrasoAparicionArmas) {
    return;
  }

  for (Armas punto : puntosArmas) {
    punto.actualizar();
    punto.dibujar(jugador1.alto);

    if (punto.recogerSiCorresponde(jugador1, agachado1)) {
      jugador1.equiparArma(punto.tipoArmaActual);
    }
    if (punto.recogerSiCorresponde(jugador2, agachado2)) {
      jugador2.equiparArma(punto.tipoArmaActual);
    }
  }
}
