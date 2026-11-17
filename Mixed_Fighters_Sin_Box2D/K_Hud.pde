// Dibuja los HUD decorativos sin conectarlos todavía a los datos de los jugadores.
void dibujarHUD() {
  float escala = width / 1920.0;
  float margen = width * 0.01;
  float hudAncho = hudJugador1.width * escala;
  float hudAlto = hudJugador1.height * escala;

  image(hudJugador1, margen, margen, hudAncho, hudAlto);
  image(hudJugador2, width - margen - hudAncho, margen, hudAncho, hudAlto);
}
