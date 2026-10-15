class Jugador {
  PVector pos;
  PVector vel = new PVector(0, 0);
  PVector acel = new PVector(0, 0);

  final float ancho = 28;
  final float alto = 48;
  final float aceleracionHorizontal = 0.8;
  final float velocidadMaxima = 5.5;
  final float gravedad = 0.65;
  final float impulsoSalto = 12.5;
  final float velocidadCaidaMaxima = 15;

  PVector posicionInicial;
  color tono;
  boolean enSuelo = false;
  boolean saltoAnterior = false;

  Jugador(float x, float y, color tono) {
    pos = new PVector(x, y);
    posicionInicial = pos.copy();
    this.tono = tono;
  }

  void mover(boolean izquierda, boolean derecha, boolean saltar) {
    acel.set(0, gravedad);

    if (izquierda != derecha) {
      acel.x = izquierda ? -aceleracionHorizontal : aceleracionHorizontal;
    } else if (enSuelo) {
      vel.x *= 0.72;  // fricción en el suelo
    } else {
      vel.x *= 0.98;  // conserva más control mientras está en el aire
    }

    if (saltar && !saltoAnterior && enSuelo) {
      aplicarImpulso(new PVector(0, -impulsoSalto));
      enSuelo = false;
    }
    saltoAnterior = saltar;

    // Patrón de movimiento de Pong: aceleración, velocidad y posición.
    vel.add(acel);
    vel.x = constrain(vel.x, -velocidadMaxima, velocidadMaxima);
    vel.y = min(vel.y, velocidadCaidaMaxima);
    acel.set(0, 0);

    moverHorizontal(vel.x);
    moverVertical(vel.y);

    if (pos.y > MAPA_ALTO + alto) reiniciarPosicion();
  }

  void aplicarImpulso(PVector impulso) {
    vel.add(impulso);
  }

  void moverHorizontal(float distancia) {
    int pasos = max(1, ceil(abs(distancia)));
    float paso = distancia / pasos;

    for (int i = 0; i < pasos; i++) {
      PVector siguiente = pos.copy();
      siguiente.x = constrain(siguiente.x + paso, ancho/2, MAPA_ANCHO - ancho/2);
      if (tocaMapa(siguiente, ancho, alto)) {
        // Permite recorrer pequeños escalones sin atravesar una pared.
        boolean pudoSubir = false;
        for (int subida = 1; subida <= 10; subida++) {
          PVector escalon = siguiente.copy();
          escalon.y -= subida;
          if (!tocaMapa(escalon, ancho, alto)) {
            pos.set(escalon);
            pudoSubir = true;
            break;
          }
        }
        if (!pudoSubir) {
          vel.x = 0;
          break;
        }
      } else {
        pos.x = siguiente.x;
      }
    }
  }

  void moverVertical(float distancia) {
    enSuelo = false;
    int pasos = max(1, ceil(abs(distancia)));
    float paso = distancia / pasos;

    for (int i = 0; i < pasos; i++) {
      PVector siguiente = pos.copy();
      siguiente.y += paso;
      if (tocaMapa(siguiente, ancho, alto)) {
        if (distancia > 0) enSuelo = true;
        vel.y = 0;
        break;
      }
      pos.y = siguiente.y;
    }
  }

  void reiniciarPosicion() {
    pos.set(posicionInicial);
    vel.set(0, 0);
    acel.set(0, 0);
    enSuelo = false;
  }

  void mostrar() {
    rectMode(CENTER);
    stroke(15, 20, 32);
    strokeWeight(2);
    fill(tono);
    rect(pos.x, pos.y, ancho, alto, 4);
    noStroke();
    fill(255);
    rect(pos.x + 6, pos.y - 10, 5, 5);
  }
}
