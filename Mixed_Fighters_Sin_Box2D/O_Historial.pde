import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

// Configuracion local de MariaDB en XAMPP.
// Si root tiene contrasena, escribila en contrasenaBD.
final String servidorBD = "jdbc:mariadb://127.0.0.1:3306/";
final String nombreBD = "mixed_fighters";
final String usuarioBD = "root";
final String contrasenaBD = "";
boolean basePreparada = false;

void prepararBaseDatos() {
  try {
    Class.forName("org.mariadb.jdbc.Driver");

    // La primera conexion no selecciona una base: permite crearla si falta.
    Connection conexionServidor = DriverManager.getConnection(
      servidorBD, usuarioBD, contrasenaBD);
    Statement comando = conexionServidor.createStatement();
    comando.executeUpdate(
      "CREATE DATABASE IF NOT EXISTS " + nombreBD +
      " CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci");
    comando.close();
    conexionServidor.close();

    // Crea la tabla la primera vez. Las partidas anteriores se conservan.
    Connection conexionBase = DriverManager.getConnection(
      servidorBD + nombreBD, usuarioBD, contrasenaBD);
    comando = conexionBase.createStatement();
    comando.executeUpdate(
      "CREATE TABLE IF NOT EXISTS peleas (" +
      "id INT AUTO_INCREMENT PRIMARY KEY, " +
      "resultado ENUM('JUGADOR_1', 'JUGADOR_2', 'EMPATE') NOT NULL, " +
      "fecha TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP)");
    comando.close();
    conexionBase.close();

    basePreparada = true;
  }
  catch (Exception error) {
    throw new RuntimeException(
      "No se pudo iniciar MariaDB. En XAMPP, encende MySQL y revisa usuario y contrasena.",
      error);
  }
}

void cargarMarcador() {
  if (!basePreparada) {
    prepararBaseDatos();
  }

  try {
    Connection conexion = DriverManager.getConnection(
      servidorBD + nombreBD, usuarioBD, contrasenaBD);
    Statement comando = conexion.createStatement();
    ResultSet resultado = comando.executeQuery(
      "SELECT " +
      "COALESCE(SUM(resultado = 'JUGADOR_1'), 0) AS victorias_jugador1, " +
      "COALESCE(SUM(resultado = 'JUGADOR_2'), 0) AS victorias_jugador2 " +
      "FROM peleas");

    if (resultado.next()) {
      victoriasJugador1 = resultado.getInt("victorias_jugador1");
      victoriasJugador2 = resultado.getInt("victorias_jugador2");
    }

    resultado.close();
    comando.close();
    conexion.close();
  }
  catch (Exception error) {
    throw new RuntimeException("No se pudo leer el marcador de MariaDB.", error);
  }
}

void guardarResultado(String resultado) {
  try {
    Connection conexion = DriverManager.getConnection(
      servidorBD + nombreBD, usuarioBD, contrasenaBD);
    PreparedStatement comando = conexion.prepareStatement(
      "INSERT INTO peleas (resultado) VALUES (?)");
    comando.setString(1, resultado);
    comando.executeUpdate();
    comando.close();
    conexion.close();
  }
  catch (Exception error) {
    throw new RuntimeException("No se pudo guardar el resultado en MariaDB.", error);
  }
}
