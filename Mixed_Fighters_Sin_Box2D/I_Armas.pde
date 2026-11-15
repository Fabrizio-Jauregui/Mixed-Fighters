class Armas {
  float x;
  float y;
  float ancho;
  float alto;
  boolean spawn = true;
  Armas(float x, float y, float ancho, float alto) {
    this.x = x;
    this.y = y;
    this.ancho = ancho;
    this.alto = alto;
  }

  void dibujar() {
    if (spawn) {
      rectMode(CENTER);
      noStroke();
      fill(255);
      rect(x, y, ancho, alto);
    }
  }

  void agarrarArma(Jugador jugador, boolean agachado) {
    boolean tocaX = jugador.pos.x + jugador.ancho / 2 >= x - ancho / 2 && jugador.pos.x - jugador.ancho / 2 <= x + ancho / 2;
    boolean tocaY = jugador.pos.y + jugador.alto / 2 >= y - alto / 2 &&  jugador.pos.y - jugador.alto / 2 <= y + alto / 2;  
    if (agachado && tocaX && tocaY) {
      spawn = false;
    }
  }
}
