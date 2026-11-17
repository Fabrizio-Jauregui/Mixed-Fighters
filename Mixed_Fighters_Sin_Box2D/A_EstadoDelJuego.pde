// Estado compartido del sketch. Los valores actuales representan menú, partida y resultado.
PImage panCarga;
PImage mapa;
PImage hudJugador1;
PImage hudJugador2;
ArrayList<Plataforma> plataformas;
ArrayList<Armas> puntosArmas;
PImage[] spritesArmas;
EscaleraMarinera escaleraMarinera;
int estado = 0;
int inicioArmas = 0;
final int retrasoAparicionArmas = 10000;
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
