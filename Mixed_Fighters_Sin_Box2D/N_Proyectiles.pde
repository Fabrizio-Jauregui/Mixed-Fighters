// Las balas chocan con las plataformas y desaparecen al impactar.
class Proyectil {
  float x;
  float y;
  float direccion;
  int danio;
  boolean activo = true;

  Proyectil(float x, float y, float direccion, int danio) {
    this.x = x;
    this.y = y;
    this.direccion = direccion;
    this.danio = danio;
  }

  void actualizar() {
    x += direccion * velocidadBala;

    if (x < -tamanoBala/2 || x > width + tamanoBala/2) {
      activo = false;
      return;
    }

    for (Plataforma plataforma : plataformas) {
      boolean tocaX =
        x + tamanoBala/2 > plataforma.x - plataforma.ancho/2 &&
        x - tamanoBala/2 < plataforma.x + plataforma.ancho/2;
      boolean tocaY =
        y + tamanoBala/2 > plataforma.y - plataforma.alto/2 &&
        y - tamanoBala/2 < plataforma.y + plataforma.alto/2;

      if (tocaX && tocaY) {
        activo = false;
        return;
      }
    }

    if (tocaJugador(jugador1)) {
      jugador1.recibirDanio(danio);
      activo = false;
      return;
    }

    if (tocaJugador(jugador2)) {
      jugador2.recibirDanio(danio);
      activo = false;
    }
  }

  boolean tocaJugador(Jugador jugador) {
    boolean tocaX =
      x + tamanoBala/2 > jugador.pos.x - jugador.ancho/2 &&
      x - tamanoBala/2 < jugador.pos.x + jugador.ancho/2;
    boolean tocaY =
      y + tamanoBala/2 > jugador.pos.y - jugador.alto/2 &&
      y - tamanoBala/2 < jugador.pos.y + jugador.alto/2;

    return tocaX && tocaY;
  }

  void dibujar() {
    pushStyle();
    noStroke();
    fill(255, 230, 90);
    ellipseMode(CENTER);
    ellipse(x, y, tamanoBala, tamanoBala);
    popStyle();
  }
}

void actualizarProyectiles() {
  for (int i = proyectiles.size() - 1; i >= 0; i--) {
    Proyectil proyectil = proyectiles.get(i);
    proyectil.actualizar();

    if (proyectil.activo) {
      proyectil.dibujar();
    } else {
      proyectiles.remove(i);
    }
  }
}
