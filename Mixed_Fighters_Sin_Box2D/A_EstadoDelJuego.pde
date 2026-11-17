// Estado compartido del sketch. Los valores actuales representan menú, partida y resultado.
PImage panCarga;
PImage mapa;
ArrayList<Plataforma> plataformas;
ArrayList<Armas> puntosArmas;
EscaleraMarinera escaleraMarinera;
int estado = 0;
int inicioArmas = 0;
final int retrasoAparicionArmas = 10000;
final float estaminaMaxima = 100;
final int ventanaDoblePulsacionCarrera = 1000;
final int ventanaInversionCarrera = 100;
final float multiplicadorVelocidadCarrera = 1.75;
final float consumoEstaminaPorSegundo = 25;
final float recuperacionEstaminaPorSegundo = 20;
Jugador jugador1;
Jugador jugador2;

MotorFisico motorFisico;

boolean enter = false;
boolean isA = false;
boolean isD = false;
boolean isW = false;
boolean isS = false;
boolean isN = false;
boolean is1 = false;
boolean isLEFT = false;
boolean isRIGHT = false;
boolean isUP = false;
boolean isDOWN = false;
boolean isM = false;
boolean perdio1 = false;
boolean perdio2 = false;
boolean mostrarPlataformas = true;
boolean mostrarHitboxes = false;
