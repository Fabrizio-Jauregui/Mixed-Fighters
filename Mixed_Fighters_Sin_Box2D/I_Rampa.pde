// Superficie inclinada definida por dos extremos editables en el archivo principal.
class Rampa {
  PVector inicio;
  PVector fin;

  Rampa(float x1, float y1, float x2, float y2) {
    inicio = new PVector(x1, y1);
    fin = new PVector(x2, y2);
  }

  boolean contieneX(float x) {
    return x >= min(inicio.x, fin.x) &&
           x <= max(inicio.x, fin.x);
  }

  boolean contieneX(float x, float margen) {
    return x >= min(inicio.x, fin.x) - margen &&
           x <= max(inicio.x, fin.x) + margen;
  }

  float alturaEn(float x) {
    x = constrain(x, min(inicio.x, fin.x), max(inicio.x, fin.x));
    float proporcion = (x - inicio.x) / (fin.x - inicio.x);
    return inicio.y + proporcion * (fin.y - inicio.y);
  }

  void dibujar() {
    stroke(255, 0, 0, 160);
    strokeWeight(6);
    line(inicio.x, inicio.y, fin.x, fin.y);
    noStroke();
  }
}
