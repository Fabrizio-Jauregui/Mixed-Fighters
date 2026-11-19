final String urlGuardarResultado = "http://127.0.0.1/mixedfighters/guardar.php";
final String urlConsultarMarcador = "http://127.0.0.1/mixedfighters/marcador.php";

void cargarMarcador() {
  JSONObject marcador = parseJSONObject(solicitarHTTP(urlConsultarMarcador, null));
  if (marcador == null) throw new RuntimeException("Respuesta de marcador inválida.");
  victoriasJugador1 = marcador.getInt("victorias_jugador1");
  victoriasJugador2 = marcador.getInt("victorias_jugador2");
}

void guardarResultado(String resultado) {
  String respuesta = solicitarHTTP(urlGuardarResultado, "resultado=" + resultado);
  if (!respuesta.trim().equals("OK")) throw new RuntimeException("No se pudo guardar el resultado.");
}

String solicitarHTTP(String direccion, String datos) {
  try {
    java.net.HttpURLConnection conexion =
      (java.net.HttpURLConnection) new java.net.URL(direccion).openConnection();
    conexion.setConnectTimeout(2500);
    conexion.setReadTimeout(2500);
    if (datos != null) {
      conexion.setRequestMethod("POST");
      conexion.setDoOutput(true);
      conexion.setRequestProperty("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
      java.io.OutputStream salida = conexion.getOutputStream();
      salida.write(datos.getBytes("UTF-8"));
      salida.close();
    }
    if (conexion.getResponseCode() != 200) throw new RuntimeException("Error HTTP.");
    java.io.BufferedReader lector = new java.io.BufferedReader(
      new java.io.InputStreamReader(conexion.getInputStream(), "UTF-8"));
    StringBuilder respuesta = new StringBuilder();
    String linea;
    while ((linea = lector.readLine()) != null) respuesta.append(linea);
    lector.close();
    conexion.disconnect();
    return respuesta.toString();
  }
  catch (Exception error) {
    throw new RuntimeException("No se pudo conectar con el historial.", error);
  }
}
