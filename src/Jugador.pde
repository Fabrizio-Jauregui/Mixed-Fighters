class Jugador {
  PVector pos;
  PVector vel;
  PVector acel;

  float ancho;
  float alto;
  float gravedad = height * 0.0005;
  float velocidad = width * 0.0015;
  float fuerzaSalto = height * 0.01;
  boolean enSuelo = false;
  boolean invertirX = false;
  color c;

  Jugador(float x, float y, float ancho, float alto, color c) {
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    acel = new PVector(0, 0);

    this.ancho = ancho;
    this.alto = alto;
    this.c = c;
  }

  void reiniciar(float x, float y) {
    pos.set(x, y);
    vel.set(0, 0);
    acel.set(0, 0);
    enSuelo = false;
    invertirX = false;
  }

  void saltar() {
    if (enSuelo) {
      vel.y = -fuerzaSalto;
      enSuelo = false;
    }
  }

  void dibujar() {
    rectMode(CENTER);
    noStroke();
    fill(c);
    rect(pos.x, pos.y, ancho, alto);
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
