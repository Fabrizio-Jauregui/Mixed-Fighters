// Dibuja el HUD y representa la vida actual; los demás indicadores siguen siendo decorativos.
void dibujarHUD() {
  float escala = width / 1920.0;
  float margen = width * 0.01;
  float hudAncho = hudJugador1.width * escala;
  float hudAlto = hudJugador1.height * escala;

  dibujarHUDJugador(hudJugador1, margen, margen, hudAncho, hudAlto, jugador1.vida);
  dibujarHUDJugador(
    hudJugador2,
    width - margen - hudAncho,
    margen,
    hudAncho,
    hudAlto,
    jugador2.vida
    );
}

void dibujarHUDJugador(PImage imagenHUD, float x, float y, float ancho, float alto, int vida) {
  image(imagenHUD, x, y, ancho, alto);

  float porcentajeVida = constrain(vida / (float) vidaInicial, 0, 1);
  float anchoBarraVida = 234 * (width / 1920.0);
  float altoBarraVida = 11 * (width / 1920.0);
  float xBarraVida = x + 100 * (width / 1920.0);
  float yBarraVida = y + 8 * (width / 1920.0);
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
}
