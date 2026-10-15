// Tamaño de referencia del mapa y de las coordenadas del juego.
final int MAPA_ANCHO = 1920;
final int MAPA_ALTO = 1080;

// Recursos y estado global del sketch.
PImage mapa;
PImage capaColisiones;
boolean[] colisionMapa;
Jugador jugador1;
Jugador jugador2;

// Ajuste del mapa a la ventana sin recortarlo ni deformarlo.
float escalaMapa;
float margenX, margenY;
