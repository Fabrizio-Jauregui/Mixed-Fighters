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
  boolean atacando = false;
  boolean mirandoDerechaAlAtacar = true;
  int cuadroGolpe = 0;
  int inicioCuadroGolpe = 0;
  boolean invertirX = false;
  boolean mirandoDerecha = true;
  color c;
  boolean tieneArmaPrinc = false;
  boolean tieneArmaSecund = true;
  float estamina = estaminaMaxima;
  boolean corriendo = false;
  int direccionCarrera = 0;
  int direccionTapEnCurso = 0;
  int ultimaDireccionLiberada = 0;
  int instanteUltimaDireccionLiberada = 0;
  boolean esperandoInversionCarrera = false;
  int instanteInicioInversionCarrera = 0;
  int ultimaActualizacionEstamina = 0;
  boolean relojEstaminaIniciado = false;
  PImage spriteQuieto;
  PImage[] spritesCaminar;
  PImage[] spritesGolpe;
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

    spritesGolpe = new PImage[] {
      loadImage("sprites/" + carpeta + "/ataque_fisico_2.png"),
      loadImage("sprites/" + carpeta + "/ataque_fisico_3.png"),
      loadImage("sprites/" + carpeta + "/ataque_fisico_5.png"),
      loadImage("sprites/" + carpeta + "/ataque_fisico_6.png")
    };
  }

  void reiniciar(float x, float y) {
    pos.set(x, y);
    vel.set(0, 0);
    acel.set(0, 0);
    enSuelo = false;
    escalando = false;
    atacando = false;
    estamina = estaminaMaxima;
    corriendo = false;
    direccionCarrera = 0;
    direccionTapEnCurso = 0;
    ultimaDireccionLiberada = 0;
    instanteUltimaDireccionLiberada = 0;
    esperandoInversionCarrera = false;
    instanteInicioInversionCarrera = 0;
    ultimaActualizacionEstamina = millis();
    relojEstaminaIniciado = true;
    cuadroGolpe = 0;
    inicioCuadroGolpe = 0;
    invertirX = false;
    mirandoDerecha = true;
    cuadroCaminar = 0;
    tieneArmaPrinc = false;
    tieneArmaSecund = true;
  }

  void saltar() {
    if (enSuelo && !escalando && !atacando) {
      vel.y = -fuerzaSalto;
      enSuelo = false;
    }
  }

  void golpear() {
    if (!enSuelo || escalando || atacando) {
      return;
    }

    cancelarCarrera();
    atacando = true;
    mirandoDerechaAlAtacar = mirandoDerecha;
    cuadroGolpe = 0;
    inicioCuadroGolpe = millis();
    vel.x = 0;
    acel.set(0, 0);
  }

  void registrarPulsacionHorizontal(int direccion) {
    int ahora = millis();

    if (atacando || escalando) {
      limpiarEstadoCarrera();
      return;
    }

    if (corriendo) {
      if (esperandoInversionCarrera) {
        if (direccion == -direccionCarrera &&
          ahora - instanteInicioInversionCarrera <= ventanaInversionCarrera) {
          direccionCarrera = direccion;
          esperandoInversionCarrera = false;
        } else {
          cancelarCarrera();
          direccionTapEnCurso = direccion;
        }
      } else if (direccion != direccionCarrera) {
        // Si ambas direcciones se solapan, el motor deja al jugador quieto
        // hasta que quede una sola dirección presionada.
        direccionCarrera = direccion;
      }
      return;
    }

    if (ultimaDireccionLiberada == direccion &&
      ahora - instanteUltimaDireccionLiberada <= ventanaDoblePulsacionCarrera) {
      direccionTapEnCurso = 0;
      ultimaDireccionLiberada = 0;

      if (estamina > 0) {
        corriendo = true;
        direccionCarrera = direccion;
        esperandoInversionCarrera = false;
        ultimaActualizacionEstamina = ahora;
        relojEstaminaIniciado = true;
      }
    } else {
      direccionTapEnCurso = direccion;
      ultimaDireccionLiberada = 0;
    }
  }

  void registrarLiberacionHorizontal(int direccion, boolean direccionContrariaPresionada) {
    int ahora = millis();

    if (atacando || escalando) {
      limpiarEstadoCarrera();
      return;
    }

    if (corriendo) {
      if (direccion == direccionCarrera) {
        if (direccionContrariaPresionada) {
          direccionCarrera = -direccion;
          esperandoInversionCarrera = false;
        } else {
          esperandoInversionCarrera = true;
          instanteInicioInversionCarrera = ahora;
        }
      }
      return;
    }

    if (direccionTapEnCurso == direccion) {
      ultimaDireccionLiberada = direccion;
      instanteUltimaDireccionLiberada = ahora;
      direccionTapEnCurso = 0;
    }
  }

  void actualizarEstamina(int ahora, boolean hayUnaSolaDireccionPresionada) {
    if (!relojEstaminaIniciado) {
      ultimaActualizacionEstamina = ahora;
      relojEstaminaIniciado = true;
      return;
    }

    float segundosTranscurridos = (ahora - ultimaActualizacionEstamina) / 1000.0;
    ultimaActualizacionEstamina = ahora;

    if (corriendo && !esperandoInversionCarrera && hayUnaSolaDireccionPresionada) {
      estamina -= consumoEstaminaPorSegundo * segundosTranscurridos;
      if (estamina <= 0) {
        estamina = 0;
        limpiarEstadoCarrera();
      }
    } else if (!corriendo) {
      estamina += recuperacionEstaminaPorSegundo * segundosTranscurridos;
    }

    estamina = constrain(estamina, 0, estaminaMaxima);
  }

  void cancelarCarrera() {
    int ahora = millis();
    actualizarEstamina(ahora, true);
    limpiarEstadoCarrera();
  }

  void finalizarInversionSinDireccion() {
    limpiarEstadoCarrera();
  }

  void limpiarEstadoCarrera() {
    corriendo = false;
    direccionCarrera = 0;
    direccionTapEnCurso = 0;
    ultimaDireccionLiberada = 0;
    esperandoInversionCarrera = false;
    instanteInicioInversionCarrera = 0;
  }

  void dibujar() {
    if (atacando) {
      cuadroGolpe = (millis() - inicioCuadroGolpe) / 100;
      if (cuadroGolpe >= spritesGolpe.length) {
        atacando = false;
        cuadroGolpe = 0;
      }
    }

    if (!atacando) {
      if (vel.x > 0) {
        mirandoDerecha = true;
      } else if (vel.x < 0) {
        mirandoDerecha = false;
      }
    }

    boolean caminando = abs(vel.x) > 0.1;
    PImage sprite = spriteQuieto;

    if (atacando && spritesGolpe != null) {
      sprite = spritesGolpe[cuadroGolpe];
      if (sprite == null) {
        sprite = spriteQuieto;
      }
    } else if (caminando && spritesCaminar != null) {
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
    boolean dibujarDerecha = atacando ? mirandoDerechaAlAtacar : mirandoDerecha;

    pushMatrix();
    if (!dibujarDerecha) {
      translate(pos.x, 0);
      scale(-1, 1);
      image(sprite, -anchoSprite/2, ySprite, anchoSprite, altoSprite);
    } else {
      image(sprite, xSprite, ySprite, anchoSprite, altoSprite);
    }
    popMatrix();
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
