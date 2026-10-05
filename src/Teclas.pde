boolean is_a = false, is_d = false, is_LEFT, is_RIGHT;


void keyPressed() {

  if (key == 'a' || key == 'A') {
    is_a = true;
  }

  if (key == 'd' || key == 'D') {
    is_d = true;
  }
  
    if (keyCode == LEFT) {
    is_LEFT = true;
  }

  if (keyCode == RIGHT) {
    is_RIGHT = true;
  }

  if (key == 'w') {
    Jugador.saltar();
  }
  
    if (keyCode == UP) {
    Jugador2.saltar();
  }
}


void keyReleased() {

  if (key == 'a' || key == 'A') {
    is_a = false;
  }

  if (key == 'd' || key == 'D') {
    is_d = false;
  }
  
      if (keyCode == LEFT) {
    is_LEFT = false;
  }

  if (keyCode == RIGHT) {
    is_RIGHT = false;
  }
}
