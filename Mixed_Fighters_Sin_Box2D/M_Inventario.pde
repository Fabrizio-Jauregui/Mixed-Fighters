// Los tres primeros valores corresponden al orden de spritesArmas en setup().
final int TIPO_PISTOLA = 0;
final int TIPO_FUSIL = 1;
final int TIPO_HACHA = 2;
final int TIPO_PUNOS = -1;
final int TIPO_SIN_ARMA_FUEGO = -1;

final int capacidadMunicionPistola = 12;
final int capacidadMunicionFusil = 25;
final int duracionPoseDisparo = 100;
final int danioProyectil = 20;
final float tamanoBala = 6;
final float velocidadBala = 18;

PImage obtenerSpriteArma(int tipoArma) {
  if (tipoArma < 0 || tipoArma >= spritesArmas.length) {
    return null;
  }

  return spritesArmas[tipoArma];
}
