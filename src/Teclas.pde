boolean is_a = false, is_d = false;


void keyPressed() {

  if (key == 'a' || key == 'A') {
    is_a = true;
  }

  if (key == 'd' || key == 'D') {
    is_d = true;
  }

  if (key == ' ') {
    Jugador.saltar();
  }
}


void keyReleased() {

  if (key == 'a' || key == 'A') {
    is_a = false;
  }

  if (key == 'd' || key == 'D') {
    is_d = false;
  }
}
