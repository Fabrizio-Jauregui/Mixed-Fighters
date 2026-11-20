// Comprueba y aplica los teletransportes independientemente del dibujo de las plataformas.
void actualizarTeletransporte(Jugador jugador, boolean moviendo) {
  if (jugador.atacando) {
    return;
  }

  PVector posicion = jugador.posicion;
  boolean teletransportado = false;

  // Superior derecho -> Inferior derecho
  if (dist(posicion.x, posicion.y, width * 0.872, height * 0.52) < 20) {
    posicion.x = width * 0.85;
    posicion.y = height * 0.83;
    teletransportado = true;
  }

  // Inferior derecho -> Superior derecho
  else if (dist(posicion.x, posicion.y, width * 0.872, height * 0.845) < 20) {
    posicion.x = width * 0.85;
    posicion.y = height * 0.499;
    teletransportado = true;
  }

  // Superior izquierdo -> Inferior izquierdo
  else if (dist(posicion.x, posicion.y, width * 0.13, height * 0.22) < 20) {
    posicion.x = width * 0.13;
    posicion.y = height * 0.76;
    teletransportado = true;
  }

  // Inferior izquierdo -> Superior izquierdo
  else if (dist(posicion.x, posicion.y, width * 0.11, height * 0.77) < 20) {
    posicion.x = width * 0.15;
    posicion.y = height * 0.202;
    teletransportado = true;
  }

  if (teletransportado && moviendo) {
    jugador.invertirX = !jugador.invertirX;
  }

  if (teletransportado) {
    jugador.cancelarSeguimientoCaida();
  }
}
