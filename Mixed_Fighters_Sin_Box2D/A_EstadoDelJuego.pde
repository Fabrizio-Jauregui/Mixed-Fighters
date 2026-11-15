// Estado compartido del sketch. Los valores actuales representan menú, partida y resultado.
PImage panCarga;
PImage mapa;
ArrayList<Plataforma> plataformas;
int estado = 0;
Jugador jugador1;
Jugador jugador2;
Armas spawn1;
Armas spawn2;
Armas spawn3;
Armas spawn4;
Armas spawn5;
Armas spawn6;

MotorFisico motorFisico;

boolean enter = false;
boolean isA = false;
boolean isD = false;
boolean isLEFT = false;
boolean isRIGHT = false;
boolean perdio1 = false;
boolean perdio2 = false;

boolean mostrarPlataformas = true;
boolean mostrarHitboxes = false;
