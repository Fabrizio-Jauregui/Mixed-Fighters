PImage panCarga;
PImage mapa;
ArrayList<Plataforma> plataformas;
int estado = 0;
Jugador jugador1;
Jugador jugador2;
boolean enter = false;
boolean isA = false;
boolean isD = false;
boolean isLEFT = false;
boolean isRIGHT = false;

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

  jugador1 = new Jugador(width/2, height/2, 20, 40, color(40, 200, 100));
  jugador2 = new Jugador(width/4, height/8, 20, 40, color(230, 80, 70));
}

void draw() {
  
  if(estado == 0){
    image(panCarga,0,0);
    textSize(30);
    fill(0,0,255);
    text("Toque enter para empezar", width*0.35, height*0.80);
    if( enter == true){
    estado = 1;
    }
    
  }
  
  
  if (estado == 1) {
    if (mapa != null) {
      image(mapa, 0, 0);
    } else {
      background(70);
    }

    jugador1.mover(isA, isD, plataformas);
    jugador2.mover(isLEFT, isRIGHT, plataformas);

    jugador1.dibujar();
    jugador2.dibujar();

    if (mostrarPlataformas) {
      for (Plataforma p : plataformas) {
        p.dibujar();
      }
    }

    if (mostrarHitboxes) {
      jugador1.dibujarHitbox();
      jugador2.dibujarHitbox();
    }
  }
}
