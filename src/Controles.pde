boolean is_a, is_d, is_w;
boolean is_LEFT, is_RIGHT, is_UP;

void keyPressed() {
  if (key == 'a' || key == 'A') is_a = true;
  if (key == 'd' || key == 'D') is_d = true;
  if (key == 'w' || key == 'W') is_w = true;
  if (keyCode == LEFT) is_LEFT = true;
  if (keyCode == RIGHT) is_RIGHT = true;
  if (keyCode == UP) is_UP = true;
}

void keyReleased() {
  if (key == 'a' || key == 'A') is_a = false;
  if (key == 'd' || key == 'D') is_d = false;
  if (key == 'w' || key == 'W') is_w = false;
  if (keyCode == LEFT) is_LEFT = false;
  if (keyCode == RIGHT) is_RIGHT = false;
  if (keyCode == UP) is_UP = false;
}
