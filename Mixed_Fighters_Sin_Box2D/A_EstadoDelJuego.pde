// Estado compartido del sketch. Los valores actuales representan menú, partida y resultado.
PImage panCarga;
PImage mapa;
ArrayList<Plataforma> plataformas;
ArrayList<Rampa> rampas;
ArrayList<Armas> puntosArmas;
int estado = 0;
int inicioArmas = 0;
final int retrasoAparicionArmas = 10000;
Jugador jugador1;
Jugador jugador2;

MotorFisico motorFisico;

boolean enter = false;
boolean isA = false;
boolean isD = false;
boolean isS = false;
boolean isLEFT = false;
boolean isRIGHT = false;
boolean isDOWN = false;
boolean perdio1 = false;
boolean perdio2 = false;
boolean mostrarPlataformas = true;
boolean mostrarHitboxes = false;
