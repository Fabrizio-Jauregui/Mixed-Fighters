PImage panCarga;
PImage mapa;
ArrayList<Plataforma> plataformas;
int estado = 0;
Jugador jugador1;
Jugador jugador2;
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
    if (estado == 0) {
    textAlign(CENTER,CENTER);
    image(panCarga, 0, 0);
    textSize(30);
    fill(0, 0, 255);
    text("Toque enter para empezar", width/2, height*0.80);
    if ( enter == true) {
      estado = 1;
    }
  }


  if (estado == 1) {
    if (mapa != null) {
      image(mapa, 0, 0);
    } else {
      background(70);
    }

    motorFisico.actualizar(jugador1, isA, isD, plataformas);
    motorFisico.actualizar(jugador2, isLEFT, isRIGHT, plataformas);

    jugador1.dibujar();
    jugador2.dibujar();

    if (mostrarPlataformas) {
      for (Plataforma p : plataformas) {
        p.dibujar();
        p.teletransporte(jugador1, isA != isD);
        p.teletransporte(jugador2, isLEFT != isRIGHT);
      }
    }

    if (mostrarHitboxes) {
      jugador1.dibujarHitbox();
      jugador2.dibujarHitbox();
    }
  

  if (jugador1.pos.x <= 0 ||
    jugador1.pos.x >= width ||
    jugador1.pos.y <= 0 ||
    jugador1.pos.y >= height) {
    estado = 3;
    perdio1 = true;
  }
  if (jugador2.pos.x <= 0 ||
    jugador2.pos.x >= width ||
    jugador2.pos.y <= 0 ||
    jugador2.pos.y >= height) {
    estado = 3;
    perdio2 = true;
  }
  }
  if (estado == 3) {
    textAlign(CENTER, CENTER);
    textSize(30);
    fill(0);
    rect(width/2, height/2, width/2, height /2);
    fill(255);
    if (perdio1 == true) {
      text("El jugador 2 gano", width/2, height/2);
    }
    if (perdio2 == true) {
      text("El jugador 1 gano", width/2, height/2);
    }
    if (enter == true) {
      estado = 0;

      perdio1 = false;
      perdio2 = false;

      jugador1.reiniciar(width/2, height/2);
      jugador2.reiniciar(width/4, height/8);

      isA = false;
      isD = false;
      isLEFT = false;
      isRIGHT = false;

      enter = false;
    }
  }
}
