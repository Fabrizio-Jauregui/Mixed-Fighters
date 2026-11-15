void setup() {
  fullScreen();
  mapa = loadImage("mapas/Rooftops.png");
  panCarga = loadImage("mapas/carga.png");
  panCarga.resize(width, height);
  mapa.resize(width, height);
  plataformas = new ArrayList<Plataforma>();
  crearPlataformas();
  motorFisico = new MotorFisico();
  spawn1 = new Armas(width*0.55,height*0.195, 35,10);
  spawn2 = new Armas(width* 0.2265,height* 0.233, 35,10);
  spawn3 = new Armas(width* 0.217,height* 0.79, 35,10);
  spawn4 = new Armas(width * 0.50,height* 0.53, 35,10);
  spawn5 = new Armas(width* 0.48166,height* 0.808, 35,10);
  spawn6 = new Armas(width* 0.723,height* 0.86, 35,10);
  jugador1 = new Jugador(width/2, height/2, width * 0.01, height * 0.038, color(40, 200, 100));
  jugador2 = new Jugador(width/4, height/8, width * 0.01, height * 0.038, color(230, 80, 70));
}

void draw() {
  background(0);
  dibujarInicio();
  actualizarPartida();
  dibujarFin();
}

