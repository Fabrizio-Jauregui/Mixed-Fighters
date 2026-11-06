void keyPressed() {
  if (key == 'a' || key == 'A') isA = true;
  if (key == 'd' || key == 'D') isD = true;

  if (keyCode == LEFT) isLEFT = true;
  if (keyCode == RIGHT) isRIGHT = true;

  if (key == 'w' || key == 'W') jugador1.saltar();
  if (keyCode == UP) jugador2.saltar();

  if (key == 'p' || key == 'P') mostrarPlataformas = !mostrarPlataformas;
  if (key == 'h' || key == 'H') mostrarHitboxes = !mostrarHitboxes;
}

void keyReleased() {
  if (key == 'a' || key == 'A') isA = false;
  if (key == 'd' || key == 'D') isD = false;

  if (keyCode == LEFT) isLEFT = false;
  if (keyCode == RIGHT) isRIGHT = false;
}
