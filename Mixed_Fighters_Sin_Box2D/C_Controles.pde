void keyPressed() {
  if ((key == 'n' || key == 'N') && !teclaN) {
    teclaN = true;
    jugador2.golpear();
  }

  if (key == 'a' || key == 'A') teclaA = true;
  if (key == 'd' || key == 'D') teclaD = true;
  if (key == 's' || key == 'S') teclaS = true;
  if (key == '1' && !tecla1) {
    tecla1 = true;
    jugador1.golpear();
  }

  if (keyCode == LEFT) flechaIzquierda = true;
  if (keyCode == RIGHT) flechaDerecha = true;
  if (keyCode == DOWN) flechaAbajo = true;
  if (key == '2' && !tecla2) {
    tecla2 = true;
    solicitarDisparo(jugador1, teclaA, teclaD);
  }

  if ((key == 'm' || key == 'M') && !teclaM) {
    teclaM = true;
    solicitarDisparo(jugador2, flechaIzquierda, flechaDerecha);
  }

  if (keyCode == ENTER) enter = true;

  if ((key == 'w' || key == 'W') && !teclaW) {
    teclaW = true;
    if (!jugador1.atacando) {
      if (escaleraMarinera.contieneJugador(jugador1) || jugador1.escalando) {
        if (escaleraMarinera.estaEnExtremoSuperior(jugador1) && jugador1.escalando) {
          jugador1.escalando = false;
          jugador1.enSuelo = true;
          jugador1.saltar();
          teclaW = false;
        }
      } else {
        jugador1.saltar();
      }
    }
  }

  if (keyCode == UP && !flechaArriba) {
    flechaArriba = true;
    if (!jugador2.atacando) {
      if (escaleraMarinera.contieneJugador(jugador2) || jugador2.escalando) {
        if (escaleraMarinera.estaEnExtremoSuperior(jugador2) && jugador2.escalando) {
          jugador2.escalando = false;
          jugador2.enSuelo = true;
          jugador2.saltar();
          flechaArriba = false;
        }
      } else {
        jugador2.saltar();
      }
    }
  }

  if (key == 'p' || key == 'P') mostrarPlataformas = !mostrarPlataformas;
  if (key == 'h' || key == 'H') mostrarHitboxes = !mostrarHitboxes;
}

void keyReleased() {
  if (key == 'n' || key == 'N') teclaN = false;
  if (key == 'a' || key == 'A') teclaA = false;
  if (key == 'd' || key == 'D') teclaD = false;
  if (key == 'w' || key == 'W') teclaW = false;
  if (key == 's' || key == 'S') teclaS = false;
  if ( key == '1') tecla1 = false;

  if (keyCode == LEFT) flechaIzquierda = false;
  if (keyCode == RIGHT) flechaDerecha = false;
  if (keyCode == UP) flechaArriba = false;
  if (keyCode == DOWN) flechaAbajo = false;
  if (key == 'm' || key == 'M') teclaM = false;
  if (key == '2') tecla2 = false;


  if (keyCode == ENTER) enter = false;

  if (!teclaA && !teclaD) {
    jugador1.invertirX = false;
  }

  if (!flechaIzquierda && !flechaDerecha) {
    jugador2.invertirX = false;
  }
}

void solicitarDisparo(Jugador jugador, boolean izquierda, boolean derecha) {
  if (estadoJuego != 1 || jugador.escalando) {
    return;
  }

  // Si el movimiento y el disparo entran juntos, actualiza primero la orientación.
  if (izquierda != derecha) {
    jugador.mirandoDerecha = derecha;
  }

  Proyectil nuevoProyectil = jugador.disparar();
  if (nuevoProyectil != null) {
    proyectiles.add(nuevoProyectil);
  }
}
