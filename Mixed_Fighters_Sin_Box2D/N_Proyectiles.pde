// Las balas son visuales por ahora: se mueven en horizontal y no comprueban impactos.
class Proyectil {
  float x;
  float y;
  float direccion;
  boolean activo = true;

  Proyectil(float x, float y, float direccion) {
    this.x = x;
    this.y = y;
    this.direccion = direccion;
  }

  void actualizar() {
    x += direccion * velocidadBala;

    if (x < -tamanoBala/2 || x > width + tamanoBala/2) {
      activo = false;
    }
  }

  void dibujar() {
    pushStyle();
    noStroke();
    fill(255, 230, 90);
    ellipseMode(CENTER);
    ellipse(x, y, tamanoBala, tamanoBala);
    popStyle();
  }
}

void actualizarProyectiles() {
  for (int i = proyectiles.size() - 1; i >= 0; i--) {
    Proyectil proyectil = proyectiles.get(i);
    proyectil.actualizar();

    if (proyectil.activo) {
      proyectil.dibujar();
    } else {
      proyectiles.remove(i);
    }
  }
}
