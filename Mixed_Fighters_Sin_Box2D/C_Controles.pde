void keyPressed() {
  if ((key == 'n' || key == 'N') && !isN) {
    isN = true;
    jugador2.golpear();
  }

  if (key == 'a' || key == 'A') isA = true;
  if (key == 'd' || key == 'D') isD = true;
  if (key == 's' || key == 'S') isS = true;
  if (key == '1' && !is1) {
    is1 = true;
    jugador1.golpear();
  }

  if (keyCode == LEFT) isLEFT = true;
  if (keyCode == RIGHT) isRIGHT = true;
  if (keyCode == DOWN) isDOWN = true;
  if (key == '2' && !is2) {
    is2 = true;
    solicitarDisparo(jugador1, isA, isD);
  }

  if ((key == 'm' || key == 'M') && !isM) {
    isM = true;
    solicitarDisparo(jugador2, isLEFT, isRIGHT);
  }

  if (keyCode == ENTER) enter = true;

  if ((key == 'w' || key == 'W') && !isW) {
    isW = true;
    if (!jugador1.atacando) {
      if (escaleraMarinera.contieneJugador(jugador1) || jugador1.escalando) {
        if (escaleraMarinera.estaEnExtremoSuperior(jugador1) && jugador1.escalando) {
          jugador1.escalando = false;
          jugador1.enSuelo = true;
          jugador1.saltar();
          isW = false;
        }
      } else {
        jugador1.saltar();
      }
    }
  }

  if (keyCode == UP && !isUP) {
    isUP = true;
    if (!jugador2.atacando) {
      if (escaleraMarinera.contieneJugador(jugador2) || jugador2.escalando) {
        if (escaleraMarinera.estaEnExtremoSuperior(jugador2) && jugador2.escalando) {
          jugador2.escalando = false;
          jugador2.enSuelo = true;
          jugador2.saltar();
          isUP = false;
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
  if (key == 'n' || key == 'N') isN = false;
  if (key == 'a' || key == 'A') isA = false;
  if (key == 'd' || key == 'D') isD = false;
  if (key == 'w' || key == 'W') isW = false;
  if (key == 's' || key == 'S') isS = false;
  if ( key == '1') is1 = false;

  if (keyCode == LEFT) isLEFT = false;
  if (keyCode == RIGHT) isRIGHT = false;
  if (keyCode == UP) isUP = false;
  if (keyCode == DOWN) isDOWN = false;
  if (key == 'm' || key == 'M') isM = false;
  if (key == '2') is2 = false;


  if (keyCode == ENTER) enter = false;

  if (!isA && !isD) {
    jugador1.invertirX = false;
  }

  if (!isLEFT && !isRIGHT) {
    jugador2.invertirX = false;
  }
}

void solicitarDisparo(Jugador jugador, boolean izquierda, boolean derecha) {
  if (estado != 1 || jugador.escalando) {
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
