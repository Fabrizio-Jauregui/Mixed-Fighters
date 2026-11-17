class Armas {
  float x;
  float y;
  float ancho;
  float alto;
  PImage[] spritesDisponibles;
  PImage spriteActual;
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
    int ahora = millis();

    if (!cicloIniciado) {
      inicioCiclo = ahora;
      cicloIniciado = true;
      spriteActual = elegirSprite();
      return;
    }

    if (ahora - inicioCiclo >= duracionCiclo) {
      disponible = true;
      spriteActual = elegirSprite();
      inicioCiclo = ahora;
    }
  }

  PImage elegirSprite() {
    int indice = (int) random(spritesDisponibles.length);
    return spritesDisponibles[indice];
  }

  boolean recogerSiCorresponde(Jugador jugador, boolean agachado) {
    if (!disponible || !agachado) {
      return false;
    }

    boolean tocaX =
      jugador.pos.x + jugador.ancho/2 >= x - ancho/2 &&
      jugador.pos.x - jugador.ancho/2 <= x + ancho/2;

    boolean tocaY =
      jugador.pos.y + jugador.alto/2 >= y - alto/2 &&
      jugador.pos.y - jugador.alto/2 <= y + alto/2;

    if (tocaX && tocaY) {
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
      jugador1.tieneArmaPrinc = true;
    }
    if (punto.recogerSiCorresponde(jugador2, agachado2)) {
      jugador2.tieneArmaPrinc = true;
    }
  }
}
