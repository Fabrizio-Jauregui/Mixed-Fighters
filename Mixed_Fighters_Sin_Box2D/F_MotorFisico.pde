class MotorFisico {

  void actualizar(Jugador jugador, boolean moverIzquierda, boolean moverDerecha, boolean moverArriba, boolean moverAbajo, ArrayList<Plataforma> plataformas, EscaleraMarinera escalera) {
    float desplazamientoRetroceso = jugador.actualizarRetroceso();
    if (desplazamientoRetroceso != 0) {
      jugador.posicion.x += desplazamientoRetroceso;
      resolverColisionHorizontal(jugador, plataformas, desplazamientoRetroceso);
    }

    boolean retrocesoActivo = jugador.retrocesoActivo;

    if (!jugador.atacando && !retrocesoActivo && !jugador.escalando &&
      escalera.contieneJugador(jugador) && moverArriba != moverAbajo) {
      jugador.escalando = true;
      jugador.velocidadActual.y = 0;
      jugador.aceleracion.set(0, 0);
      jugador.enSuelo = false;
    }   
    
    
    if (jugador.escalando) {
      jugador.cancelarSeguimientoCaida();
      actualizarEscalada(
        jugador,
        retrocesoActivo ? false : moverIzquierda,
        retrocesoActivo ? false : moverDerecha,
        moverArriba,
        moverAbajo,
        plataformas,
        escalera
        );
      return;
    }

    // 1. Movimiento horizontal; durante el ataque o el retroceso no hay control lateral.
    if (jugador.atacando || retrocesoActivo || jugador.disparoActivo()) {
      jugador.velocidadActual.x = 0;
    } else if (moverIzquierda && !moverDerecha) {
      jugador.velocidadActual.x = jugador.invertirX ? jugador.velocidad : -jugador.velocidad;
    } else if (moverDerecha && !moverIzquierda) {
      jugador.velocidadActual.x = jugador.invertirX ? -jugador.velocidad : jugador.velocidad;
    } else {
      jugador.velocidadActual.x = 0;
    }

    // 2. Movimiento horizontal y colisiones laterales con plataformas.
    jugador.posicion.x += jugador.velocidadActual.x;

    for (Plataforma p : plataformas) {
      if (colisiona(jugador, p)) {
        if (jugador.velocidadActual.x > 0) {
          jugador.posicion.x = p.x - p.ancho/2 - jugador.ancho/2;
        } else if (jugador.velocidadActual.x < 0) {
          jugador.posicion.x = p.x + p.ancho/2 + jugador.ancho/2;
        }
      }
    }

    // 3. Movimiento vertical y colisiones con plataformas.
    actualizarMovimientoVertical(jugador, plataformas);
    jugador.actualizarSeguimientoCaida();
  }

  void actualizarMovimientoVertical(Jugador jugador, ArrayList<Plataforma> plataformas) {
    jugador.aceleracion.set(0, jugador.gravedad);
    jugador.velocidadActual.add(jugador.aceleracion);
    jugador.velocidadActual.limit(20);
    jugador.enSuelo = false;
    jugador.posicion.y += jugador.velocidadActual.y;

    for (Plataforma p : plataformas) {
      if (colisiona(jugador, p)) {
        if (jugador.velocidadActual.y > 0) {
          jugador.posicion.y = p.y - p.alto/2 - jugador.alto/2;
          jugador.enSuelo = true;
        } else if (jugador.velocidadActual.y < 0) {
          jugador.posicion.y = p.y + p.alto/2 + jugador.alto/2;
        }

        jugador.velocidadActual.y = 0;
      }
    }

    jugador.aceleracion.mult(0);
  }

  void resolverColisionHorizontal(Jugador jugador, ArrayList<Plataforma> plataformas, float movimientoX) {
    for (Plataforma p : plataformas) {
      if (colisiona(jugador, p)) {
        if (movimientoX > 0) {
          jugador.posicion.x = p.x - p.ancho/2 - jugador.ancho/2;
        } else if (movimientoX < 0) {
          jugador.posicion.x = p.x + p.ancho/2 + jugador.ancho/2;
        }
      }
    }
  }

  void actualizarEscalada(Jugador jugador, boolean moverIzquierda, boolean moverDerecha, boolean moverArriba, boolean moverAbajo, ArrayList<Plataforma> plataformas, EscaleraMarinera escalera) {
    if (moverIzquierda && !moverDerecha) {
      jugador.velocidadActual.x = jugador.invertirX ? jugador.velocidad : -jugador.velocidad;
    } else if (moverDerecha && !moverIzquierda) {
      jugador.velocidadActual.x = jugador.invertirX ? -jugador.velocidad : jugador.velocidad;
    } else {
      jugador.velocidadActual.x = 0;
    }

    jugador.velocidadActual.y = 0;
    jugador.posicion.x += jugador.velocidadActual.x;

    for (Plataforma p : plataformas) {
      if (colisiona(jugador, p)) {
        if (jugador.velocidadActual.x > 0) {
          jugador.posicion.x = p.x - p.ancho/2 - jugador.ancho/2;
        } else if (jugador.velocidadActual.x < 0) {
          jugador.posicion.x = p.x + p.ancho/2 + jugador.ancho/2;
        }
      }
    }

    if (escalera.salioPorCostado(jugador)) {
      jugador.escalando = false;
      jugador.enSuelo = false;
      return;
    }

    if (moverArriba != moverAbajo) {
      jugador.velocidadActual.y = moverArriba ? -jugador.velocidad : jugador.velocidad;
      jugador.posicion.y += jugador.velocidadActual.y;
    }

    float centroSuperior = escalera.bordeSuperior - jugador.alto/2;
    float centroInferior = escalera.bordeInferior - jugador.alto/2;

    if (jugador.posicion.y <= centroSuperior) {
      jugador.posicion.y = centroSuperior;
      jugador.velocidadActual.y = 0;
      jugador.enSuelo = true;
    } else if (jugador.posicion.y >= centroInferior) {
      jugador.posicion.y = centroInferior;
      jugador.velocidadActual.y = 0;
      jugador.enSuelo = true;
    } else {
      jugador.enSuelo = false;
    }

    for (Plataforma p : plataformas) {
      if (colisiona(jugador, p)) {
        if (jugador.velocidadActual.y > 0) {
          jugador.posicion.y = p.y - p.alto/2 - jugador.alto/2;
          jugador.enSuelo = true;
        } else if (jugador.velocidadActual.y < 0) {
          jugador.posicion.y = p.y + p.alto/2 + jugador.alto/2;
          jugador.enSuelo = false;
        }
        jugador.velocidadActual.y = 0;
      }
    }
  }

  boolean colisiona(Jugador jugador, Plataforma p) {
    boolean seSuperponeHorizontalmente =
      jugador.posicion.x + jugador.ancho/2 > p.x - p.ancho/2 &&
      jugador.posicion.x - jugador.ancho/2 < p.x + p.ancho/2;

    boolean seSuperponeVerticalmente =
      jugador.posicion.y + jugador.alto/2 > p.y - p.alto/2 &&
      jugador.posicion.y - jugador.alto/2 < p.y + p.alto/2;

    return seSuperponeHorizontalmente && seSuperponeVerticalmente;
  }

}
