class MotorFisico {

  void actualizar(Jugador jugador, boolean izq, boolean der, boolean subir, boolean bajar,
    ArrayList<Plataforma> plataformas, EscaleraMarinera escalera) {
    int ahora = millis();
    jugador.actualizarEstamina(ahora, izq != der);

    if (jugador.atacando) {
      jugador.vel.set(0, 0);
      jugador.acel.set(0, 0);
      return;
    }

    if (jugador.esperandoInversionCarrera &&
      ahora - jugador.instanteInicioInversionCarrera > ventanaInversionCarrera) {
      jugador.finalizarInversionSinDireccion();
    }

    if (!jugador.escalando && escalera.contieneJugador(jugador) && subir != bajar) {
      jugador.cancelarCarrera();
      jugador.escalando = true;
      jugador.vel.y = 0;
      jugador.acel.set(0, 0);
      jugador.enSuelo = false;
    }   
    
    
    if (jugador.escalando) {
      jugador.cancelarCarrera();
      actualizarEscalada(jugador, izq, der, subir, bajar, plataformas, escalera);
      return;
    }

    // 1. Movimiento horizontal
    float velocidadHorizontal = jugador.velocidad;
    if (jugador.corriendo) {
      velocidadHorizontal *= multiplicadorVelocidadCarrera;
    }

    if (izq && !der) {
      jugador.vel.x = jugador.invertirX ? velocidadHorizontal : -velocidadHorizontal;

    } else if (der && !izq) {
      jugador.vel.x = jugador.invertirX ? -velocidadHorizontal : velocidadHorizontal;

    } else {
      jugador.vel.x = 0;
    }

    // 2. Aplicar gravedad
    jugador.acel.set(0, jugador.gravedad);
    jugador.vel.add(jugador.acel);
    jugador.vel.limit(20);

    // 3. Movimiento horizontal y colisiones laterales con plataformas.
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

    // 4. Movimiento vertical y colisiones con plataformas.
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

  void actualizarEscalada(Jugador jugador, boolean izq, boolean der, boolean subir, boolean bajar, ArrayList<Plataforma> plataformas, EscaleraMarinera escalera) {
    if (izq && !der) {
      jugador.vel.x = jugador.invertirX ? jugador.velocidad : -jugador.velocidad;
    } else if (der && !izq) {
      jugador.vel.x = jugador.invertirX ? -jugador.velocidad : jugador.velocidad;
    } else {
      jugador.vel.x = 0;
    }

    jugador.vel.y = 0;
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

    if (escalera.salioPorCostado(jugador)) {
      jugador.escalando = false;
      jugador.enSuelo = false;
      return;
    }

    if (subir != bajar) {
      jugador.vel.y = subir ? -jugador.velocidad : jugador.velocidad;
      jugador.pos.y += jugador.vel.y;
    }

    float centroSuperior = escalera.bordeSuperior - jugador.alto/2;
    float centroInferior = escalera.bordeInferior - jugador.alto/2;

    if (jugador.pos.y <= centroSuperior) {
      jugador.pos.y = centroSuperior;
      jugador.vel.y = 0;
      jugador.enSuelo = true;
    } else if (jugador.pos.y >= centroInferior) {
      jugador.pos.y = centroInferior;
      jugador.vel.y = 0;
      jugador.enSuelo = true;
    } else {
      jugador.enSuelo = false;
    }

    for (Plataforma p : plataformas) {
      if (colisiona(jugador, p)) {
        if (jugador.vel.y > 0) {
          jugador.pos.y = p.y - p.alto/2 - jugador.alto/2;
          jugador.enSuelo = true;
        } else if (jugador.vel.y < 0) {
          jugador.pos.y = p.y + p.alto/2 + jugador.alto/2;
          jugador.enSuelo = false;
        }
        jugador.vel.y = 0;
      }
    }
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
