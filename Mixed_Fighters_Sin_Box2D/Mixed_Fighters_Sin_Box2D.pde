void setup() {
  fullScreen();
  mapa = loadImage("mapas/Rooftops.png");
  panCarga = loadImage("mapas/carga.png");
  hudJugador1 = loadImage("hud/inventario P1 con dos armas.png");
  hudJugador2 = loadImage("hud/inventario P2 con dos armas.png");
  panCarga.resize(width, height);
  mapa.resize(width, height);
  plataformas = new ArrayList<Plataforma>();
  crearPlataformas();

  //Escalera Marinera
  escaleraMarinera = new EscaleraMarinera(
    width * 0.336, height * 0.23,
    width * 0.358, height * 0.620
    );

  spritesArmas = new PImage[] {
    loadImage("armas/pistola.png"),
    loadImage("armas/ametralladora.png"),
    loadImage("armas/hacha.png")
  };
  proyectiles = new ArrayList<Proyectil>();

  puntosArmas = new ArrayList<Armas>();
  puntosArmas.add(new Armas(width * 0.55, height * 0.195, 35, 10, spritesArmas));
  puntosArmas.add(new Armas(width * 0.2265, height * 0.233, 35, 10, spritesArmas));
  puntosArmas.add(new Armas(width * 0.217, height * 0.79, 35, 10, spritesArmas));
  puntosArmas.add(new Armas(width * 0.50, height * 0.53, 35, 10, spritesArmas));
  puntosArmas.add(new Armas(width * 0.48166, height * 0.808, 35, 10, spritesArmas));
  puntosArmas.add(new Armas(width * 0.723, height * 0.86, 35, 10, spritesArmas));
  motorFisico = new MotorFisico();
  jugador1 = new Jugador(width/4, height/8, width * 0.02, height * 0.059, color(40, 200, 100));
  jugador2 = new Jugador(width/2, height/2, width * 0.02, height * 0.059, color(230, 80, 70));
  jugador1.cargarSprites("remera_blanca_original");
  jugador2.cargarSprites("remera_negra");
}

void draw() {
  background(0);
  dibujarInicio();
  actualizarPartida();
  dibujarFin();
}
