// Comprueba y aplica los teletransportes independientemente del dibujo de las plataformas.
void actualizarTeletransporte(Jugador jugador, boolean moviendo) {
  if (jugador.atacando) {
    return;
  }

  PVector pos = jugador.pos;
  boolean teletransportado = false;

  // Superior derecho -> Inferior derecho
  if (dist(pos.x, pos.y, width * 0.872, height * 0.52) < 20) {
    pos.x = width * 0.85;
    pos.y = height * 0.83;
    teletransportado = true;
  }

  // Inferior derecho -> Superior derecho
  else if (dist(pos.x, pos.y, width * 0.872, height * 0.845) < 20) {
    pos.x = width * 0.85;
    pos.y = height * 0.499;
    teletransportado = true;
  }

  // Superior izquierdo -> Inferior izquierdo
  else if (dist(pos.x, pos.y, width * 0.13, height * 0.22) < 20) {
    pos.x = width * 0.13;
    pos.y = height * 0.76;
    teletransportado = true;
  }

  // Inferior izquierdo -> Superior izquierdo
  else if (dist(pos.x, pos.y, width * 0.11, height * 0.77) < 20) {
    pos.x = width * 0.15;
    pos.y = height * 0.202;
    teletransportado = true;
  }

  if (teletransportado && moviendo) {
    jugador.invertirX = !jugador.invertirX;
  }

  if (teletransportado) {
    jugador.cancelarSeguimientoCaida();
  }
}
