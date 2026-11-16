class MotorFisico {

  void actualizar(Jugador jugador, boolean izq, boolean der, ArrayList<Plataforma> plataformas, ArrayList<Rampa> rampas) {
    boolean estabaEnRampa = jugador.enRampa;
    boolean estabaApoyado = jugador.enSuelo || estabaEnRampa;
    float pieAnterior = jugador.pos.y + jugador.alto/2;
    float xAnterior = jugador.pos.x;
    jugador.enRampa = false;

    // 1. Movimiento horizontal
    if (izq && !der) {
      jugador.vel.x = jugador.invertirX ? jugador.velocidad : -jugador.velocidad;

    } else if (der && !izq) {
      jugador.vel.x = jugador.invertirX ? -jugador.velocidad : jugador.velocidad;

    } else {
      jugador.vel.x = 0;
    }

    // 2. Aplicar gravedad
    jugador.acel.set(0, jugador.gravedad);
    jugador.vel.add(jugador.acel);
    jugador.vel.limit(20);

    // 3. Movimiento horizontal y posible apoyo sobre una rampa.
    jugador.pos.x += jugador.vel.x;

    boolean ajustadoEnRampa = false;
    if (estabaApoyado && jugador.vel.y >= 0) {
      for (Rampa rampa : rampas) {
        if (rampa.contieneX(jugador.pos.x, jugador.ancho/2)) {
          float xAnteriorEnRampa = constrain(
            xAnterior,
            min(rampa.inicio.x, rampa.fin.x),
            max(rampa.inicio.x, rampa.fin.x)
          );
          float alturaAnteriorRampa = rampa.alturaEn(xAnteriorEnRampa);
          float alturaNuevaRampa = rampa.alturaEn(jugador.pos.x);
          float diferenciaAltura = pieAnterior - alturaNuevaRampa;
          float cambioSuperficie = abs(alturaNuevaRampa - alturaAnteriorRampa);
          float tolerancia = height * 0.001;
          float maximoCambioPorPaso = cambioSuperficie + tolerancia;
          boolean veniaSiguiendoLaSuperficie = abs(pieAnterior - alturaAnteriorRampa) <= tolerancia;
          boolean cambioAlcanzable = abs(diferenciaAltura) <= maximoCambioPorPaso;

          if (veniaSiguiendoLaSuperficie && cambioAlcanzable) {
            float yAnterior = jugador.pos.y;
            jugador.pos.y = alturaNuevaRampa - jugador.alto/2;

            if (hayEspacio(jugador, plataformas)) {
              jugador.vel.y = 0;
              jugador.enSuelo = true;
              jugador.enRampa = true;
              ajustadoEnRampa = true;
              break;
            } else {
              jugador.pos.y = yAnterior;
            }
          }
        }
      }
    }

    for (Plataforma p : plataformas) {
      if (colisiona(jugador, p)) {
        if (jugador.vel.x > 0) {
          jugador.pos.x = p.x - p.ancho/2 - jugador.ancho/2;
        } else if (jugador.vel.x < 0) {
          jugador.pos.x = p.x + p.ancho/2 + jugador.ancho/2;
        }
      }
    }

    // 4. Movimiento vertical y colisiones, salvo que la rampa ya sostenga al jugador.
    if (!ajustadoEnRampa) {
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
    }

    // 5. Comprobar el apoyo en cada rampa, en el orden de la lista.
    for (Rampa rampa : rampas) {
      if (rampa.contieneX(jugador.pos.x)) {
        float alturaRampa = rampa.alturaEn(jugador.pos.x);
        float pieActual = jugador.pos.y + jugador.alto/2;

        boolean aterrizandoDesdeArriba =
          jugador.vel.y >= 0 &&
          pieAnterior <= alturaRampa &&
          pieActual >= alturaRampa;

        boolean sigueApoyado = estabaEnRampa && jugador.vel.y >= 0;

        if (aterrizandoDesdeArriba || sigueApoyado) {
          jugador.pos.y = alturaRampa - jugador.alto/2;
          jugador.vel.y = 0;
          jugador.enSuelo = true;
          jugador.enRampa = true;
          break;
        }
      }
    }

    // 6. Limpiar aceleración
    jugador.acel.mult(0);
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

  boolean hayEspacio(Jugador jugador, ArrayList<Plataforma> plataformas) {
    for (Plataforma p : plataformas) {
      if (colisiona(jugador, p)) {
        return false;
      }
    }
    return true;
  }
}
