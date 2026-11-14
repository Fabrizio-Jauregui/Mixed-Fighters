class MotorFisico {

  void actualizar(Jugador jugador, boolean izq, boolean der, ArrayList<Plataforma> plataformas) {

    // 1. Movimiento horizontal
    if (izq && !der) {
      jugador.vel.x = jugador.invertirX ? jugador.velocidad : -jugador.velocidad;

    } else if (der && !izq) {
      jugador.vel.x = jugador.invertirX ? -jugador.velocidad : jugador.velocidad;

    } else {
      jugador.vel.x = 0;
    }

    // 2. Aplicar gravedad
    jugador.acel.set(0, jugador.gravedad);
    jugador.vel.add(jugador.acel);
    jugador.vel.limit(20);

    // 3. Movimiento horizontal y colisiones
    jugador.pos.x += jugador.vel.x;

    for (Plataforma p : plataformas) {
      if (colisiona(jugador, p)) {
        if (jugador.vel.x > 0) {
          jugador.pos.x = p.x - p.ancho/2 - jugador.ancho/2;
        } else if (jugador.vel.x < 0) {
          jugador.pos.x = p.x + p.ancho/2 + jugador.ancho/2;
        }
      }
    }

    // 4. Movimiento vertical y colisiones
    jugador.enSuelo = false;
    jugador.pos.y += jugador.vel.y;

    for (Plataforma p : plataformas) {
      if (colisiona(jugador, p)) {
        if (jugador.vel.y > 0) {
          jugador.pos.y = p.y - p.alto/2 - jugador.alto/2;
          jugador.enSuelo = true;
        } else if (jugador.vel.y < 0) {
          jugador.pos.y = p.y + p.alto/2 + jugador.alto/2;
        }

        jugador.vel.y = 0;
      }
    }

    // 5. Limpiar aceleración
    jugador.acel.mult(0);
  }

  boolean colisiona(Jugador jugador, Plataforma p) {
    boolean tocaX =
      jugador.pos.x + jugador.ancho/2 > p.x - p.ancho/2 &&
      jugador.pos.x - jugador.ancho/2 < p.x + p.ancho/2;

    boolean tocaY =
      jugador.pos.y + jugador.alto/2 > p.y - p.alto/2 &&
      jugador.pos.y - jugador.alto/2 < p.y + p.alto/2;

    return tocaX && tocaY;
  }
}
