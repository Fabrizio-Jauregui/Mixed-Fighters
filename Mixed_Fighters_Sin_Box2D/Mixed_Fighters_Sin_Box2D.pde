void setup() {
  fullScreen();
  mapa = loadImage("mapas/Rooftops.png");
  panCarga = loadImage("mapas/carga.png");
  panCarga.resize(width, height);
  mapa.resize(width, height);
  plataformas = new ArrayList<Plataforma>();
  crearPlataformas();
  motorFisico = new MotorFisico();

  jugador1 = new Jugador(width/2, height/2, width * 0.01, height * 0.038, color(40, 200, 100));
  jugador2 = new Jugador(width/4, height/8, width * 0.01, height * 0.038, color(230, 80, 70));
}

void draw() {
  background(0);

  dibujarInicio();
  actualizarPartida();
  dibujarFin();
}
