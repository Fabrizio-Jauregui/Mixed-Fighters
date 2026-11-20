// Datos compartidos por las pestañas del sketch.
PImage panCarga;
PImage mapa;
PImage hudJugador1;
PImage hudJugador2;

ArrayList<Plataforma> plataformas;
ArrayList<Armas> puntosArmas;
ArrayList<Proyectil> proyectiles;
PImage[] spritesArmas;

EscaleraMarinera escaleraMarinera;
MotorFisico motorFisico;
Jugador jugador1;
Jugador jugador2;

int estadoJuego = 0;
int inicioArmas = 0;
final int retrasoAparicionArmas = 10000;

boolean enter = false;
boolean teclaA = false;
boolean teclaD = false;
boolean teclaW = false;
boolean teclaS = false;
boolean teclaN = false;
boolean tecla1 = false;
boolean flechaIzquierda = false;
boolean flechaDerecha = false;
boolean flechaArriba = false;
boolean flechaAbajo = false;
boolean teclaM = false;
boolean tecla2 = false;

boolean perdio1 = false;
boolean perdio2 = false;
int victoriasJugador1 = 0;
int victoriasJugador2 = 0;
boolean marcadorConsultado = false;
boolean resultadoGuardado = false;

boolean mostrarPlataformas = true;
boolean mostrarHitboxes = false;

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
