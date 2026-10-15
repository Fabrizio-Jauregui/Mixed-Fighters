void cargarMapa() {
  mapa = loadImage("mapas/Rooftops.png");
  if (mapa == null || mapa.width != MAPA_ANCHO || mapa.height != MAPA_ALTO) {
    throw new RuntimeException("No se pudo cargar mapas/Rooftops.png (debe medir 1920 x 1080)");
  }
  mapa.loadPixels();

  escalaMapa = min(width / (float)MAPA_ANCHO, height / (float)MAPA_ALTO);
  margenX = (width - MAPA_ANCHO * escalaMapa) / 2;
  margenY = (height - MAPA_ALTO * escalaMapa) / 2;
}

void dibujarMapa() {
  image(mapa, 0, 0);
  image(capaColisiones, 0, 0);
}
