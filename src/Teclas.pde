
// ============================================================
// ESTADO DE LAS TECLAS
// ============================================================

// Guardan si actualmente se está manteniendo presionada
// la tecla A o la tecla D.
//
// false = no está presionada.
// true  = está presionada.
boolean is_a = false, is_d = false;


// ============================================================
// CUANDO SE PRESIONA UNA TECLA
// ============================================================

void keyPressed() {

  // Si se presiona A o a, guardar que A está presionada.
  if (key == 'a' || key == 'A') {
    is_a = true;
  }


  // Si se presiona D o d, guardar que D está presionada.
  if (key == 'd' || key == 'D') {
    is_d = true;
  }
}


// ============================================================
// CUANDO SE SUELTA UNA TECLA
// ============================================================

void keyReleased() {

  // Si se suelta A o a, guardar que A ya no está presionada.
  if (key == 'a' || key == 'A') {
    is_a = false;
  }


  // Si se suelta D o d, guardar que D ya no está presionada.
  if (key == 'd' || key == 'D') {
    is_d = false;
  }
}
