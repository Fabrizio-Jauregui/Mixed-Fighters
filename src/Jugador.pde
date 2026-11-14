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

  void mover(boolean izq, boolean der, ArrayList<Plataforma> plataformas) {
    if (izq && !der) {
      vel.x = invertirX ? velocidad : -velocidad;
    } else if (der && !izq) {
      vel.x = invertirX ? -velocidad : velocidad;
    } else {
      vel.x = 0;
    }

    // Aplicamos gravedad mediante aceleracion.
    acel.set(0, gravedad);
    vel.add(acel);
    vel.limit(20);

    // Primero movemos en X y resolvemos las colisiones horizontales.
    pos.x += vel.x;

    for (Plataforma p : plataformas) {
      if (colisiona(p)) {
        if (vel.x > 0) {
          pos.x = p.x - p.ancho/2 - ancho/2;
        } else if (vel.x < 0) {
          pos.x = p.x + p.ancho/2 + ancho/2;
        }
      }
    }

    // Despues movemos en Y y resolvemos suelo, techos y paredes.
    enSuelo = false;
    pos.y += vel.y;

    for (Plataforma p : plataformas) {
      if (colisiona(p)) {
        if (vel.y > 0) {
          // El jugador estaba cayendo: se apoya sobre la plataforma.
          pos.y = p.y - p.alto/2 - alto/2;
          enSuelo = true;
        } else if (vel.y < 0) {
          // El jugador estaba subiendo: golpea la parte inferior.
          pos.y = p.y + p.alto/2 + alto/2;
        }
        vel.y = 0;
      }
    }

    acel.mult(0);
  }

  boolean colisiona(Plataforma p) {
    boolean tocaX = pos.x + ancho/2 > p.x - p.ancho/2 &&
                    pos.x - ancho/2 < p.x + p.ancho/2;

    boolean tocaY = pos.y + alto/2 > p.y - p.alto/2 &&
                    pos.y - alto/2 < p.y + p.alto/2;

    return tocaX && tocaY;
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
