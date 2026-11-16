class Jugador {
  PVector pos;
  PVector vel;
  PVector acel;
  
  int vida = 100;
  
  float ancho;
  float alto;
  float gravedad = height * 0.0005;
  float velocidad = width * 0.0015;
  float fuerzaSalto = height * 0.01;
  boolean enSuelo = false;
  boolean escalando = false;
  boolean invertirX = false;
  boolean mirandoDerecha = true;
  color c;
  boolean tieneArmaPrinc = false;
  boolean tieneArmaSecund = true;
  PImage spriteQuieto;
  PImage[] spritesCaminar;
  int cuadroCaminar = 0;
  int ultimoCambioSprite = 0;

  Jugador(float x, float y, float ancho, float alto, color c) {
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    acel = new PVector(0, 0);

    this.ancho = ancho;
    this.alto = alto;
    this.c = c;
  }

  void cargarSprites(String carpeta) {
    spriteQuieto = loadImage("sprites/" + carpeta + "/quieto_1.png");
    spritesCaminar = new PImage[4];

    for (int i = 0; i < spritesCaminar.length; i++) {
      spritesCaminar[i] = loadImage("sprites/" + carpeta + "/caminar_" + (i + 1) + ".png");
    }
  }

  void reiniciar(float x, float y) {
    pos.set(x, y);
    vel.set(0, 0);
    acel.set(0, 0);
    enSuelo = false;
    escalando = false;
    invertirX = false;
    mirandoDerecha = true;
    cuadroCaminar = 0;
    tieneArmaPrinc = false;
    tieneArmaSecund = true;
  }

  void saltar() {
    if (enSuelo && !escalando) {
      vel.y = -fuerzaSalto;
      enSuelo = false;
    }
  }

  void dibujar() {
    if (vel.x > 0) {
      mirandoDerecha = true;
    } else if (vel.x < 0) {
      mirandoDerecha = false;
    }

    boolean caminando = abs(vel.x) > 0.1;
    PImage sprite = spriteQuieto;

    if (caminando && spritesCaminar != null) {
      if (millis() - ultimoCambioSprite >= 130) {
        cuadroCaminar = (cuadroCaminar + 1) % spritesCaminar.length;
        ultimoCambioSprite = millis();
      }
      sprite = spritesCaminar[cuadroCaminar];
    } else {
      cuadroCaminar = 0;
      ultimoCambioSprite = millis();
    }

    if (sprite == null) {
      rectMode(CENTER);
      noStroke();
      fill(c);
      rect(pos.x, pos.y, ancho, alto);
      return;
    }

    float altoSprite = alto;
    float anchoSprite = sprite.width * (altoSprite / sprite.height);
    float xSprite = pos.x - anchoSprite/2;
    float ySprite = pos.y + alto/2 - altoSprite;

    pushMatrix();
    if (!mirandoDerecha) {
      translate(pos.x, 0);
      scale(-1, 1);
      image(sprite, -anchoSprite/2, ySprite, anchoSprite, altoSprite);
    } else {
      image(sprite, xSprite, ySprite, anchoSprite, altoSprite);
    }
    popMatrix();
  }
  
  
  void golpear(){
  
  
  
  }


  void disparar(){
  
  
  
  }
  

  void dibujarHitbox() {
    rectMode(CENTER);
    noFill();
    stroke(0, 255, 0);
    strokeWeight(2);
    rect(pos.x, pos.y, ancho, alto);
    noStroke();
  }
}
