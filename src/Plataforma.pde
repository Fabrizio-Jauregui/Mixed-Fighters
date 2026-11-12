class Plataforma {
  float x;
  float y;
  float ancho;
  float alto;

  Plataforma(float x, float y, float ancho, float alto) {
    this.x = x;
    this.y = y;
    this.ancho = ancho;
    this.alto = alto;
  }
  void teletransporte(PVector pos) {
    rectMode(CENTER);
    if(pos.x == width * 0.872 && pos.y == height * 0.5){
    pos.x = width * 0.872;
    pos.y = height * 0.845;
    }
    
     if(pos.x == width * 0.872 && pos.y == height * 0.845){
    pos.x = width * 0.872;
    pos.y = height *0.11875;
    }
    
     if(pos.x == width * 0.13 && pos.y == height * 0.2){
    pos.x = width *(width * 0.11;
    pos.y = height *  0.77;
    }
    
     if(pos.x == width * 0.872 && pos.y == height * 0.11875){
    pos.x = width * 0.872;
    pos.y = height * 0.845;
    }
    
    
    
    
    
    
    rect(width * 0.872, height * 0.5, width * 0.009, height * 0.11875);//pared tp arriba a la derecha
    
    rect(width * 0.872, height * 0.845, width * 0.009, height * 0.11875);//pared tp abajo a la derecha
    
    rect(width * 0.13, height * 0.2, width * 0.009, height * 0.11875);//pared tp arriba a la izquierda
    
    rect(width * 0.11, height * 0.77, width * 0.009, height * 0.11875);//pared tp abajo a la izquierda
  }

  void dibujar() {
    rectMode(CENTER);
    noStroke();
    fill(255, 0, 0, 120);
    rect(x, y, ancho, alto);
  }
}
