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
void teletransporte(Jugador jugador, boolean moviendo) {
  rectMode(CENTER);
  PVector pos = jugador.pos;
  boolean teletransportado = false;

  // Superior derecho -> Inferior derecho
  if (dist(pos.x, pos.y, width * 0.872, height * 0.5) < 20) {
    pos.x = width * 0.85;
    pos.y = height * 0.845;
    teletransportado = true;
  }

  // Inferior derecho -> Superior derecho
  else if (dist(pos.x, pos.y, width * 0.872, height * 0.845) < 20) {
    pos.x = width * 0.85;
    pos.y = height * 0.5;
    teletransportado = true;
  }

  // Superior izquierdo -> Inferior izquierdo
  else if (dist(pos.x, pos.y, width * 0.13, height * 0.22) < 20) {
    pos.x = width * 0.13;
    pos.y = height * 0.77;
    teletransportado = true;
  }

  // Inferior izquierdo -> Superior izquierdo
  else if (dist(pos.x, pos.y, width * 0.11, height * 0.77) < 20) {
    pos.x = width * 0.15;
    pos.y = height * 0.2;
    teletransportado = true;
  }

  if (teletransportado && moviendo) {
    jugador.invertirX = true;
  }


    
    /*
    rect(width * 0.85, height * 0.5, width * 0.009, height * 0.11875);//pared tp arriba a la derecha
    
    rect(width * 0.87, height * 0.845, width * 0.009, height * 0.11875);//pared tp abajo a la derecha
    
    rect(width * 0.15, height * 0.2, width * 0.009, height * 0.11875);//pared tp arriba a la izquierda
    
    rect(width * 0.11, height * 0.77, width * 0.009, height * 0.11875);//pared tp abajo a la izquierda
    
    */

    
  }

  void dibujar() {
    rectMode(CENTER);
    noStroke();
    fill(255, 0, 0, 120);
    rect(x, y, ancho, alto);
  }
}
