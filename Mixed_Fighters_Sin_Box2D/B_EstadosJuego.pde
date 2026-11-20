// Presentación del menú inicial.
void dibujarInicio() {
  if (estadoJuego == 0) {
    if (!marcadorConsultado) {
      cargarMarcador();
      marcadorConsultado = true;
    }

    textAlign(CENTER, CENTER);
    image(panCarga, 0, 0);
    textSize(30);
    fill(0, 0, 255);
    text("Toque enter para empezar", width/2, height * 0.80);
    textSize(22);
    fill(255);
    text("Victorias: Jugador 1: " + victoriasJugador1 +
      "  |  Jugador 2: " + victoriasJugador2, width/2, height * 0.87);

    if (enter) {
      estadoJuego = 1;
      resultadoGuardado = false;
      inicioArmas = millis();
      proyectiles.clear();
      for (Armas punto : puntosArmas) {
        punto.reiniciar();
      }
    }
  }
}

// Actualización y dibujo de la partida activa.
void actualizarPartida() {
  if (estadoJuego == 1) {
    if (mapa != null) {
      image(mapa, 0, 0);
    } else {
      background(70);
    }

    motorFisico.actualizar(jugador1, teclaA, teclaD, teclaW, teclaS, plataformas, escaleraMarinera);
    motorFisico.actualizar(jugador2, flechaIzquierda, flechaDerecha, flechaArriba, flechaAbajo, plataformas, escaleraMarinera);

    actualizarTeletransporte(jugador1, teclaA != teclaD);
    actualizarTeletransporte(jugador2, flechaIzquierda != flechaDerecha);

    jugador1.dibujar();
    jugador2.dibujar();
    actualizarProyectiles();
    resolverGolpes();
    actualizarPuntosArmas(jugador1, teclaS && !jugador1.escalando, jugador2, flechaAbajo && !jugador2.escalando);

    if (mostrarPlataformas) {
      for (Plataforma p : plataformas) {
        p.dibujar();
      }
      escaleraMarinera.dibujarHitbox();
    }

    if (mostrarHitboxes) {
      jugador1.dibujarHitbox();
      jugador2.dibujarHitbox();
      jugador1.dibujarHitboxGolpe();
      jugador2.dibujarHitboxGolpe();
    }

    perdio1 = jugador1.vida <= 0 || jugador1.posicion.x <= 0 || jugador1.posicion.x >= width ||jugador1.posicion.y <= 0 || jugador1.posicion.y >= height;
    perdio2 = jugador2.vida <= 0 || jugador2.posicion.x <= 0 || jugador2.posicion.x >= width ||jugador2.posicion.y <= 0 || jugador2.posicion.y >= height;

    if (perdio1 || perdio2) {
      if (!resultadoGuardado) {
        resultadoGuardado = true;
        String resultado = perdio1 && perdio2 ? "EMPATE" : perdio1 ? "JUGADOR_2" : "JUGADOR_1";
        guardarResultado(resultado);
      }
      estadoJuego = 3;
    }

    dibujarHUD();
  }
}

// Presentación del resultado y reinicio de la partida.
void dibujarFin() {
  if (estadoJuego == 3) {
    textAlign(CENTER, CENTER);
    textSize(30);
    fill(0);
    rect(width/2, height/2, width/2, height/2);
    fill(255);

    if (perdio1 && perdio2) {
      text("La partida quedó en empate", width/2, height/2);
    } else if (perdio1) {
      text("JUGADOR 2 GANA", width/2, height/2);
    } else if (perdio2) {
      text("JUGADOR 1 GANA", width/2, height/2);
    }

    if (enter) {
      estadoJuego = 0;
      marcadorConsultado = false;
      perdio1 = false;
      perdio2 = false;
      teclaN = false;
      tecla1 = false;
      teclaM = false;
      tecla2 = false;
      proyectiles.clear();

      jugador1.reiniciar(width/4, height/8);
      jugador2.reiniciar(width/2, height/2);

      teclaA = false;
      teclaD = false;
      teclaW = false;
      teclaS = false;
      flechaIzquierda = false;
      flechaDerecha = false;
      flechaArriba = false;
      flechaAbajo = false;
      enter = false;
    }
  }
}
