// Los tres primeros valores corresponden al orden de spritesArmas en setup().
final int TIPO_PISTOLA = 0;
final int TIPO_FUSIL = 1;
final int TIPO_HACHA = 2;
final int TIPO_PUNOS = -1;

PImage obtenerSpriteArma(int tipoArma) {
  if (tipoArma < 0 || tipoArma >= spritesArmas.length) {
    return null;
  }

  return spritesArmas[tipoArma];
}
