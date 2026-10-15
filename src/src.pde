void setup() {
  fullScreen();
  surface.setTitle("Mixed Fighters");
  frameRate(60);
  noSmooth();

  cargarMapa();
  crearMascaraDeColision();
  jugador1 = new Jugador(320, 804, color(60, 190, 255));
  jugador2 = new Jugador(1550, 564, color(255, 100, 100));
}

void draw() {
  background(0);
  pushMatrix();
  translate(margenX, margenY);
  scale(escalaMapa);
  dibujarMapa();

  jugador1.mover(is_a, is_d, is_w);
  jugador2.mover(is_LEFT, is_RIGHT, is_UP);
  resolverChoqueEntreJugadores();
  jugador1.mostrar();
  jugador2.mostrar();
  popMatrix();
}
