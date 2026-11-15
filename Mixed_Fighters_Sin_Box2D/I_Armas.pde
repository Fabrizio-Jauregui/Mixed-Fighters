class Armas {
  float x;
  float y;
  float ancho;
  float alto;

  Armas(float x, float y, float ancho, float alto) {
    this.x = x;
    this.y = y;
    this.ancho = ancho;
    this.alto = alto;
  }

  void dibujar() {
    rectMode(CENTER);
    noStroke();
    fill(255);
    rect(x, y, ancho, alto);
  }
}
