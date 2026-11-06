class Plataforma {
  float x;
  float y;
  float ancho;
  float alto;

  Plataforma(float x, float y, float ancho, float alto) {
    this.x = x;
    this.y = y;
    this.ancho = ancho;
    this.alto = alto;
  }

  void dibujar() {
    rectMode(CENTER);
    noStroke();
    fill(255, 0, 0, 120);
    rect(x, y, ancho, alto);
  }
}
