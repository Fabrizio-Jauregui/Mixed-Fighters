// Presentación del menú inicial.
void dibujarInicio() {
  if (estado == 0) {
    textAlign(CENTER, CENTER);
    image(panCarga, 0, 0);
    textSize(30);
    fill(0, 0, 255);
    text("Toque enter para empezar", width/2, height * 0.80);

    if (enter) {
      estado = 1;
      inicioArmas = millis();
      for (Armas punto : puntosArmas) {
        punto.reiniciar();
      }
    }
  }
}

// Actualización y dibujo de la partida activa.
void actualizarPartida() {
  if (estado == 1) {
    if (mapa != null) {
      image(mapa, 0, 0);
    } else {
      background(70);
    }

    motorFisico.actualizar(jugador1, isA, isD, isW, isS, plataformas, escaleraMarinera);
    motorFisico.actualizar(jugador2, isLEFT, isRIGHT, isUP, isDOWN, plataformas, escaleraMarinera);

    actualizarTeletransporte(jugador1, isA != isD);
    actualizarTeletransporte(jugador2, isLEFT != isRIGHT);

    jugador1.dibujar();
    jugador2.dibujar();
    actualizarPuntosArmas(jugador1, isS && !jugador1.escalando, jugador2, isDOWN && !jugador2.escalando);

    if (mostrarPlataformas) {
      for (Plataforma p : plataformas) {
        p.dibujar();
      }
      escaleraMarinera.dibujarHitbox();
    }

    if (mostrarHitboxes) {
      jugador1.dibujarHitbox();
      jugador2.dibujarHitbox();
    }

    dibujarHUD();

    if (jugador1.pos.x <= 0 || jugador1.pos.x >= width ||
      jugador1.pos.y <= 0 || jugador1.pos.y >= height) {
      estado = 3;
      perdio1 = true;
    }

    if (jugador2.pos.x <= 0 || jugador2.pos.x >= width ||
      jugador2.pos.y <= 0 || jugador2.pos.y >= height) {
      estado = 3;
      perdio2 = true;
    }
  }
}

// Presentación del resultado y reinicio de la partida.
void dibujarFin() {
  if (estado == 3) {
    textAlign(CENTER, CENTER);
    textSize(30);
    fill(0);
    rect(width/2, height/2, width/2, height/2);
    fill(255);

    if (perdio1) {
      text("El jugador 2 gano", width/2, height/2);
    }
    if (perdio2) {
      text("El jugador 1 gano", width/2, height/2);
    }

    if (enter) {
      estado = 0;
      perdio1 = false;
      perdio2 = false;

      jugador1.reiniciar(width/2, height/2);
      jugador2.reiniciar(width/4, height/8);

      isA = false;
      isD = false;
      isW = false;
      isS = false;
      isLEFT = false;
      isRIGHT = false;
      isUP = false;
      isDOWN = false;
      enter = false;
    }
  }
}
