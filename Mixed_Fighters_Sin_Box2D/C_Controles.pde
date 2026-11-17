void keyPressed() {
  if ((key == 'n' || key == 'N') && !isN) {
    isN = true;
    jugador2.golpear();
  }

  if ((key == 'a' || key == 'A') && !isA) {
    isA = true;
    jugador1.registrarPulsacionHorizontal(-1);
  }
  if ((key == 'd' || key == 'D') && !isD) {
    isD = true;
    jugador1.registrarPulsacionHorizontal(1);
  }
  if (key == 's' || key == 'S') isS = true;
  if (key == '1' && !is1) {
    is1 = true;
    jugador1.golpear();
  }

  if (keyCode == LEFT && !isLEFT) {
    isLEFT = true;
    jugador2.registrarPulsacionHorizontal(-1);
  }
  if (keyCode == RIGHT && !isRIGHT) {
    isRIGHT = true;
    jugador2.registrarPulsacionHorizontal(1);
  }
  if (keyCode == DOWN) isDOWN = true;
  if (key == 'm' || key == 'M') isM = true;

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
  if ((key == 'a' || key == 'A') && isA) {
    isA = false;
    jugador1.registrarLiberacionHorizontal(-1, isD);
  }
  if ((key == 'd' || key == 'D') && isD) {
    isD = false;
    jugador1.registrarLiberacionHorizontal(1, isA);
  }
  if (key == 'w' || key == 'W') isW = false;
  if (key == 's' || key == 'S') isS = false;
  if ( key == '1') is1 = false;

  if (keyCode == LEFT && isLEFT) {
    isLEFT = false;
    jugador2.registrarLiberacionHorizontal(-1, isRIGHT);
  }
  if (keyCode == RIGHT && isRIGHT) {
    isRIGHT = false;
    jugador2.registrarLiberacionHorizontal(1, isLEFT);
  }
  if (keyCode == UP) isUP = false;
  if (keyCode == DOWN) isDOWN = false;
  if (key == 'm' || key == 'M') isM = true;


  if (keyCode == ENTER) enter = false;

  if (!isA && !isD) {
    jugador1.invertirX = false;
  }

  if (!isLEFT && !isRIGHT) {
    jugador2.invertirX = false;
  }
}
