void keyPressed() {
  if (key == 'a' || key == 'A') isA = true;
  if (key == 'd' || key == 'D') isD = true;
  if (key == 's' || key == 'S') isS = true;
  if ( key == '1') is1 = true;

  if (keyCode == LEFT) isLEFT = true;
  if (keyCode == RIGHT) isRIGHT = true;
  if (keyCode == DOWN) isDOWN = true;
  if (key == 'm' || key == 'M') isM = true;

  if (keyCode == ENTER) enter = true;

  if ((key == 'w' || key == 'W') && !isW) {
    isW = true;
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

  if (keyCode == UP && !isUP) {
    isUP = true;
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

  if (key == 'p' || key == 'P') mostrarPlataformas = !mostrarPlataformas;
  if (key == 'h' || key == 'H') mostrarHitboxes = !mostrarHitboxes;
}

void keyReleased() {
  if (key == 'a' || key == 'A') isA = false;
  if (key == 'd' || key == 'D') isD = false;
  if (key == 'w' || key == 'W') isW = false;
  if (key == 's' || key == 'S') isS = false;
  if ( key == '1') is1 = false;

  if (keyCode == LEFT) isLEFT = false;
  if (keyCode == RIGHT) isRIGHT = false;
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
