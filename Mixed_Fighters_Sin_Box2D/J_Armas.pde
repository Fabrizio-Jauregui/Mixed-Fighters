class Armas {
  float x;
  float y;
  float ancho;
  float alto;
  boolean disponible = true;

  Armas(float x, float y, float ancho, float alto) {
    this.x = x;
    this.y = y;
    this.ancho = ancho;
    this.alto = alto;
  }

  void dibujar() {
    if (disponible) {
      rectMode(CENTER);
      noStroke();
      fill(255);
      rect(x, y, ancho, alto);
    }
  }

  void recogerSiCorresponde(Jugador jugador, boolean agachado) {
    if (!disponible || !agachado) {
      return;
    }

    boolean tocaX =
      jugador.pos.x + jugador.ancho/2 >= x - ancho/2 &&
      jugador.pos.x - jugador.ancho/2 <= x + ancho/2;

    boolean tocaY =
      jugador.pos.y + jugador.alto/2 >= y - alto/2 &&
      jugador.pos.y - jugador.alto/2 <= y + alto/2;

    if (tocaX && tocaY) {
      disponible = false;
    }
  }

  void reiniciar() {
    disponible = true;
  }
}

void actualizarPuntosArmas(Jugador jugador1, boolean agachado1, Jugador jugador2, boolean agachado2) {
  if (millis() - inicioArmas < retrasoAparicionArmas) {
    return;
  }

  for (Armas punto : puntosArmas) {
    punto.dibujar();
    punto.recogerSiCorresponde(jugador1, agachado1);
    punto.recogerSiCorresponde(jugador2, agachado2);
  }
}
