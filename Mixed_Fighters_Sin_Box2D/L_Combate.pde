// Parámetros aprobados para el combate cuerpo a cuerpo y el daño por caída.
final int vidaInicial = 100;
final int danioPunetazo = 10;
final int danioHacha = 20;
final int inicioVentanaGolpe = 100;
final int finVentanaGolpe = 300;
final float altoProporcionHitboxGolpe = 0.65;
final float proporcionAnchoHitboxHacha = 1.5;
final int duracionRetroceso = 120;
final float distanciaRetroceso = 24;
final float alturasJugadorParaDanioCaida = 3;
final float pixelesPorPuntoDanioCaida = 12;
final int esperaRegeneracionVida = 5000;
final float puntosRegeneradosPorSegundo = 3;

void resolverGolpes() {
  // Se comprueban los dos ataques antes de aplicar daño para permitir un empate simultáneo.
  boolean impactoJugador1 = jugador1.puedeGolpear(jugador2);
  boolean impactoJugador2 = jugador2.puedeGolpear(jugador1);

  if (impactoJugador1) {
    jugador1.golpeYaImpacto = true;
    float direccion = jugador1.mirandoDerechaAlAtacar ? 1 : -1;
    jugador2.recibirGolpe(jugador1.danioGolpeActual(), direccion);
  }

  if (impactoJugador2) {
    jugador2.golpeYaImpacto = true;
    float direccion = jugador2.mirandoDerechaAlAtacar ? 1 : -1;
    jugador1.recibirGolpe(jugador2.danioGolpeActual(), direccion);
  }
}
