// Estado compartido del sketch. Los valores actuales representan menú, partida y resultado.
PImage panCarga;
PImage mapa;
ArrayList<Plataforma> plataformas;
int estado = 0;
int inicioArmas = 0;
Jugador jugador1;
Jugador jugador2;
Armas spawn1;// cartel
Armas spawn2;// arriba a la izquierda
Armas spawn3;//abajo a la izquierda
Armas spawn4;//arriba lamp 1
Armas spawn5;// abajo lamp 1
Armas spawn6;// abajo a la derecha

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
boolean spawnArma = true;
boolean mostrarPlataformas = true;
boolean mostrarHitboxes = false;
