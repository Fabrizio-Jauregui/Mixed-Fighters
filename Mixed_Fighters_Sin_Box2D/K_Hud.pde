// Dibuja el HUD y representa la vida actual; los demás indicadores siguen siendo decorativos.
void dibujarHUD() {
  float escala = width / 1920.0;
  float margen = width * 0.01;
  float hudAncho = hudJugador1.width * escala;
  float hudAlto = hudJugador1.height * escala;

  dibujarHUDJugador(hudJugador1, margen, margen, hudAncho, hudAlto, jugador1);
  dibujarHUDJugador(
    hudJugador2,
    width - margen - hudAncho,
    margen,
    hudAncho,
    hudAlto,
    jugador2
    );
}

void dibujarHUDJugador(PImage imagenHUD, float x, float y, float ancho, float alto, Jugador jugador) {
  image(imagenHUD, x, y, ancho, alto);

  float escalaHUD = ancho / imagenHUD.width;
  float porcentajeVida = constrain(jugador.vida / (float) vidaInicial, 0, 1);
  float anchoBarraVida = 234 * escalaHUD;
  float altoBarraVida = 11 * escalaHUD;
  float xBarraVida = x + 100 * escalaHUD;
  float yBarraVida = y + 8 * escalaHUD;
  float anchoRestante = anchoBarraVida * (1 - porcentajeVida);

  if (anchoRestante > 0) {
    pushStyle();
    rectMode(CORNER);
    noStroke();
    fill(0);
    rect(
      xBarraVida + anchoBarraVida - anchoRestante,
      yBarraVida,
      anchoRestante,
      altoBarraVida
      );
    popStyle();
  }

  dibujarIconoArma(obtenerSpriteArma(jugador.armaCuerpoACuerpo), x, y, escalaHUD, 133, 45);
  dibujarIconoArma(obtenerSpriteArma(jugador.armaDeFuego), x, y, escalaHUD, 213, 45);
  dibujarMunicion(jugador, x, y, escalaHUD);
}

void dibujarMunicion(Jugador jugador, float x, float y, float escalaHUD) {
  float centroX = x + 249 * escalaHUD;
  float centroY = y + 124 * escalaHUD;

  pushStyle();
  rectMode(CENTER);
  noStroke();
  fill(0, 180);
  rect(centroX, centroY, 42 * escalaHUD, 24 * escalaHUD, 5 * escalaHUD);
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(16 * escalaHUD);
  text(jugador.municionArma, centroX, centroY);
  popStyle();
}

void dibujarIconoArma(PImage icono, float x, float y, float escalaHUD, float slotX, float slotY) {
  if (icono == null) {
    return;
  }

  float anchoSlot = 72 * escalaHUD;
  float altoSlot = 72 * escalaHUD;
  float anchoMaximoIcono = anchoSlot * 0.70;
  float altoMaximoIcono = altoSlot * 0.70;
  float escalaIcono = min(
    anchoMaximoIcono / icono.width,
    altoMaximoIcono / icono.height
    );
  float anchoIcono = icono.width * escalaIcono;
  float altoIcono = icono.height * escalaIcono;
  float xIcono = x + slotX * escalaHUD + (anchoSlot - anchoIcono)/2;
  float yIcono = y + slotY * escalaHUD + (altoSlot - altoIcono)/2;

  image(icono, xIcono, yIcono, anchoIcono, altoIcono);
}
