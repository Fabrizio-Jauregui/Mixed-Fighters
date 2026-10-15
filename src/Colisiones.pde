void crearMascaraDeColision() {
  colisionMapa = new boolean[MAPA_ANCHO * MAPA_ALTO];
  for (int y = 0; y < MAPA_ALTO; y++) {
    for (int x = 0; x < MAPA_ANCHO; x++) {
      int pixel = mapa.pixels[y * MAPA_ANCHO + x];
      int r = (pixel >> 16) & 255;
      int g = (pixel >> 8) & 255;
      int b = pixel & 255;
      int a = (pixel >>> 24) & 255;

      // El cartel es decorativo; el resto de estructuras grises es sólido.
      boolean cartel = x >= 700 && x <= 1120 && y >= 45 && y <= 205;
      colisionMapa[y * MAPA_ANCHO + x] = !cartel && a > 200 && r > 75 &&
        abs(r - g) < 12 && abs(g - b) < 12;
    }
  }

  // Capa roja translúcida para ver en pantalla qué píxeles son sólidos.
  capaColisiones = createImage(MAPA_ANCHO, MAPA_ALTO, ARGB);
  capaColisiones.loadPixels();
  int rojoColision = 0x82FF3030;
  for (int i = 0; i < colisionMapa.length; i++) {
    capaColisiones.pixels[i] = colisionMapa[i] ? rojoColision : 0x00000000;
  }
  capaColisiones.updatePixels();
}

boolean tocaMapa(PVector centro, float ancho, float alto) {
  int x0 = max(0, ceil(centro.x - ancho/2));
  int x1 = min(MAPA_ANCHO, ceil(centro.x + ancho/2));
  int y0 = max(0, ceil(centro.y - alto/2));
  int y1 = min(MAPA_ALTO, ceil(centro.y + alto/2));

  for (int y = y0; y < y1; y++) {
    int fila = y * MAPA_ANCHO;
    for (int x = x0; x < x1; x++) {
      if (colisionMapa[fila + x]) return true;
    }
  }
  return false;
}

void resolverChoqueEntreJugadores() {
  float solapeX = (jugador1.ancho + jugador2.ancho) / 2 - abs(jugador1.pos.x - jugador2.pos.x);
  float solapeY = (jugador1.alto + jugador2.alto) / 2 - abs(jugador1.pos.y - jugador2.pos.y);
  if (solapeX <= 0 || solapeY <= 0) return;

  float direccion = jugador1.pos.x <= jugador2.pos.x ? -1 : 1;
  float empuje = solapeX / 2 + 0.1;
  PVector p1 = jugador1.pos.copy();
  PVector p2 = jugador2.pos.copy();
  p1.x = constrain(p1.x + direccion * empuje, jugador1.ancho/2, MAPA_ANCHO - jugador1.ancho/2);
  p2.x = constrain(p2.x - direccion * empuje, jugador2.ancho/2, MAPA_ANCHO - jugador2.ancho/2);

  boolean libre1 = !tocaMapa(p1, jugador1.ancho, jugador1.alto);
  boolean libre2 = !tocaMapa(p2, jugador2.ancho, jugador2.alto);
  if (libre1 && libre2) {
    jugador1.pos.set(p1);
    jugador2.pos.set(p2);
  } else if (libre1) {
    p1 = jugador1.pos.copy();
    p1.x = constrain(p1.x + direccion * solapeX, jugador1.ancho/2, MAPA_ANCHO - jugador1.ancho/2);
    if (!tocaMapa(p1, jugador1.ancho, jugador1.alto)) jugador1.pos.set(p1);
  } else if (libre2) {
    p2 = jugador2.pos.copy();
    p2.x = constrain(p2.x - direccion * solapeX, jugador2.ancho/2, MAPA_ANCHO - jugador2.ancho/2);
    if (!tocaMapa(p2, jugador2.ancho, jugador2.alto)) jugador2.pos.set(p2);
  }

  jugador1.vel.x = 0;
  jugador2.vel.x = 0;
}
