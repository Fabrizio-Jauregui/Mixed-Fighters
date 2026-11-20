// Zona invisible para iniciar y mantener la escalada de la escalera marinera.
class EscaleraMarinera {
  float bordeIzquierdo;
  float bordeSuperior;
  float bordeDerecho;
  float bordeInferior;

  EscaleraMarinera(float x1, float y1, float x2, float y2) {
    bordeIzquierdo = min(x1, x2);
    bordeSuperior = min(y1, y2);
    bordeDerecho = max(x1, x2);
    bordeInferior = max(y1, y2);
  }

  boolean contieneJugador(Jugador jugador) {
    return jugador.posicion.x + jugador.ancho/2 >= bordeIzquierdo && jugador.posicion.x - jugador.ancho/2 <= bordeDerecho && jugador.posicion.y + jugador.alto/2 >= bordeSuperior && jugador.posicion.y - jugador.alto/2 <= bordeInferior;
  }

  boolean salioPorCostado(Jugador jugador) {
    return jugador.posicion.x + jugador.ancho/2 < bordeIzquierdo || jugador.posicion.x - jugador.ancho/2 > bordeDerecho;
  }

  boolean estaEnExtremoSuperior(Jugador jugador) {
    return jugador.posicion.y <= bordeSuperior - jugador.alto/2;
  }

  void dibujarHitbox() {
    rectMode(CENTER);
    noStroke();
    fill(255, 0, 0, 120);
    float centroX = (bordeIzquierdo + bordeDerecho) / 2;
    float centroY = (bordeSuperior + bordeInferior) / 2;
    rect(centroX, centroY, bordeDerecho - bordeIzquierdo, bordeInferior - bordeSuperior);
  }
}
