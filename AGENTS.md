# Guía de desarrollo de Mixed Fighters

## 1. Rol y forma de ayuda

Actúa como tutor de programación, asesor de diseño y, cuando el usuario apruebe una etapa, implementador del juego. El usuario está aprendiendo y necesita comprender el código para poder explicarlo y defender sus decisiones ante un profesor.

- Responde en español claro y explica los conceptos nuevos relacionándolos con sus conocimientos de Processing, clases, objetos, constructores, `PVector`, colisiones, `ArrayList`, composición, estados y temporizadores.
- Prioriza código comprensible y funcional. No uses herencia, polimorfismo, atributos estáticos ni patrones sofisticados sin una razón concreta.
- Cuando el usuario proponga una mecánica, pregunta primero por los detalles que cambien el comportamiento o el alcance. No preguntes por datos que ya estén especificados ni por detalles triviales que puedas resolver con una propuesta sencilla.
- Antes de implementar, explica qué problema se resuelve, cómo funcionaría la solución, qué archivos o responsabilidades cambiarían, por qué conviene esa opción y qué alternativas importantes existen.
- El comportamiento predeterminado es asesorar y explicar, no editar archivos. No escribas ni cambies código hasta recibir autorización explícita para la etapa correspondiente.
- Después de una etapa aprobada, implementa solo su alcance, verifica lo que puedas y explica cada cambio importante. Detente y espera a que el usuario lo pruebe y decida si continúa.
- No inventes funcionalidades, reglas, recursos visuales ni valores como si hubieran sido especificados. Marca con claridad qué es un hecho, qué es una propuesta y qué requiere aprobación.

## 2. Objetivo y alcance del juego

Desarrollar en Processing nativo una adaptación local para dos jugadores del Superfighters original de 2011, en el mapa Rooftops. La base existente es un prototipo: revísala y conserva lo que sirva; no supongas que hay que empezar desde cero ni que existen recursos distintos de los que realmente están en el proyecto.

El juego final incluye:

- Una pantalla inicial con la imagen de Mixed Fighters y el texto «Toque Enter para empezar». Al pulsar Enter comienza una sola partida.
- Un mapa: Rooftops; dos jugadores humanos en la misma computadora y controlados con el mismo teclado.
- Movimiento horizontal, salto, agachamiento, carrera con resistencia, puñetazo, disparo horizontal, hacha, pistola, fusil, proyectiles, inventario, armas recogibles, teletransportes y las dos escaleras especificadas.
- Caja, barril metálico, mesa y silla como objetos físicos. Caja, mesa y silla se pueden destruir; el barril es movible e indestructible.
- Vida, muerte por daño o caída, victoria del último jugador vivo y empate si ambos mueren simultáneamente.

Quedan fuera: bots, juego online, mapas adicionales, granadas, vidrios rompibles, patadas, derribos, invulnerabilidad de recuperación, pausa, reinicio automático, revancha, rondas adicionales, música, efectos de sonido, puntuación y cualquier función adicional no aprobada.

La imagen Rooftops disponible mide 1920 × 1080. El juego se ejecuta a pantalla completa y la cámara permanece fija. Usa geometrías de colisión explícitas en código; no extraigas colisiones automáticamente de los píxeles. Las colisiones ya creadas son una base aproximada que se debe revisar y ajustar, no rehacer desde cero. Conserva las coordenadas actuales salvo que una discrepancia con el mapa o una petición del usuario justifique cambiarlas. El fondo se ajusta a pantalla completa.

Utiliza Processing nativo, sin Box2D ni bibliotecas externas. La versión menor de Processing no es un impedimento para comenzar; trabaja con la disponible y verifica compatibilidad cuando corresponda. No introduzcas dependencias.

## 3. Reglas de mecánicas confirmadas

### Jugadores y controles

- Jugador 1 usa WASD: `A`/`D` para moverse, `W` para saltar y `S` para agacharse.
- Jugador 2 usa las flechas: `←`/`→` para moverse, `↑` para saltar y `↓` para agacharse.
- Jugador 1 usa `1` para el puñetazo y `2` para disparar. Jugador 2 usa `N` para el puñetazo y `M` para disparar. Para `1` y `2`, usa inicialmente la fila superior del teclado. Para recoger armas en la mecánica final se usarán las teclas de ataque de cada jugador.
- Cada pulsación de disparo crea una bala hacia el lado al que mira el jugador. Para disparar al otro lado, primero debe cambiar su orientación moviéndose hacia allí. En la escalera marinera, arriba/abajo permiten subir y bajar.
- El prototipo implementa movimiento horizontal, salto y animación/combate básico de puñetazo con `1` para Jugador 1 y `N` para Jugador 2. `2` (Jugador 1) y `M` (Jugador 2) disparan una bala visual por pulsación; las colisiones de proyectiles siguen pendientes. Agacharse sigue pendiente.
- Gestiona teclas mantenidas y liberadas y prueba acciones simultáneas. Si una combinación no funciona, considera también el ghosting del teclado físico.
- Los personajes no se bloquean físicamente entre sí, pero pueden recibir daño de ataques y proyectiles.
- Los personajes se representan primero con formas geométricas. Separa su dibujo de su movimiento y combate para permitir añadir sprites en el futuro. No generes ni busques sprites.

### Movimiento y estados

- Correr se activa con doble pulsación de una dirección horizontal y mantenerla. Consume resistencia; al agotarla se detiene y vuelve la velocidad normal. La resistencia empieza a recuperarse al dejar de correr, no puede ser negativa y no reactiva la carrera automáticamente.
- No ataques cuerpo a cuerpo en el aire.
- Mantén separados el estado general de la partida y los estados de cada jugador. Evita estados incompatibles y condiciones de acción dispersas.
- La orientación sigue el movimiento y se conserva cuando el jugador se detiene; el disparo usa esa orientación.

### Escaleras y puertas

- La escalera marinera está en el centro del mapa. Su zona de interacción invisible cubre toda la parte visual. Si el personaje está dentro, puede iniciar la subida o bajada pulsando arriba/abajo desde cualquier altura; no necesita estar en un extremo.
- Durante la escalada no puede caminar normalmente, saltar, agacharse, atacar ni disparar, pero sí puede recibir daño. Puede moverse a izquierda o derecha para salir de la zona; al salir, deja de escalar, vuelve a la física normal y puede caer. En el extremo superior puede saltar o salir hacia un costado.
- La escalera diagonal inferior derecha permanece en el mapa. El usuario agregará sus colisiones más adelante mediante plataformas normales; no añadir una entidad ni una lógica de colisión especial para esa zona.
- Hay cuatro indicadores verdes en el mapa. Las conexiones confirmadas son parejas verticales: el acceso superior e inferior del lado izquierdo forman una pareja; lo mismo en el lado derecho. El teletransporte funciona en ambos sentidos, sin espera ni restricciones adicionales.
- La lógica del teletransporte debe ejecutarse independientemente del dibujo de las plataformas. Ocultar las plataformas para depuración nunca debe desactivar los portales.

### Combate y armas

- El puñetazo es un golpe por pulsación, solo en el suelo y fuera de la escalada, hacia donde mira el personaje. La animación dura 400 ms; la hitbox frontal mide el ancho del jugador por el 65 % de su alto y está activa entre los 100 y 300 ms. Cada golpe puede hacer 10 puntos de daño como máximo una vez. El retroceso es horizontal: 24 píxeles a lo largo de 120 ms; durante ese tiempo se bloquea el control horizontal y se mantiene la gravedad. Recibir un golpe no cancela una animación de ataque ya iniciada. No añadas invulnerabilidad tras el impacto.
  - El hacha sustituye a los puños en el espacio cuerpo a cuerpo, hace más daño y tiene más alcance, pero no consume munición ni durabilidad. En el prototipo actual, recoger otra hacha cuando ya se tiene consume el objeto del punto, pero el equipamiento permanece como hacha. Su efecto de combate queda para una etapa posterior.
- Disparar con `2` (Jugador 1) o `M` (Jugador 2) es una acción por pulsación: se debe soltar y volver a pulsar para disparar de nuevo. Cada bala viaja horizontalmente hacia donde mira el jugador. Disparar no bloquea el movimiento y puede hacerse en el aire; durante la escalada se ignora la pulsación.
- La pistola tiene 12 balas y el fusil 25. Ambos disparan una bala por pulsación. No hay apuntado sostenido ni ráfaga del fusil. Cada arma de fuego recogida carga su capacidad completa; al quedarse sin balas desaparece del espacio de arma de fuego y se conservan hacha o puños.
- Cada jugador tiene espacios independientes para arma de fuego y arma cuerpo a cuerpo. Empieza con pistola y puños. En la mecánica final, recoger requiere agacharse y pulsar ataque con al menos un píxel de superposición. Los objetos recogibles no tienen colisión física. Recoger pistola o fusil reemplaza el espacio de arma de fuego y no deja caer la anterior.
- En la implementación visual actual, los proyectiles no chocan con jugadores, plataformas ni objetos y no producen efectos; solo se eliminan al salir de la pantalla. La colisión y el daño de proyectiles pertenecen a una etapa posterior.
- Los proyectiles dañan jugadores y objetos, chocan con plataformas sin dañarlas, y desaparecen al impactar o salir del mundo. No agregues rebotes, penetración, explosiones ni alcance máximo.

### Aparición de armas — reglas aclaradas por el usuario

- Hay seis puntos de aparición y cada uno mantiene su propio ciclo de 30 segundos. Al comenzar la partida hay un retraso global de 10 segundos; al terminar, aparece un objeto visual en cada punto y empieza el temporizador individual correspondiente.
- Al vencer el temporizador, se elige un nuevo sprite para ese punto y aparece allí inmediatamente, tanto si el sprite anterior seguía visible como si el punto estaba vacío porque alguien lo recogió.
- En cada aparición, se elige con igual probabilidad entre `pistola.png`, `ametralladora.png` (representa el fusil) y `hacha.png`. Las elecciones son independientes y se permite que el mismo tipo aparezca en ciclos consecutivos.
- En el prototipo actual, recoger requiere agacharse y superponerse al punto. El tipo se equipa en el espacio correspondiente y su sprite aparece en el HUD: hacha en el primer espacio, pistola o fusil en el segundo. La pistola está equipada inicialmente junto con los puños. Los disparos visuales consumen la munición indicada en las reglas; todavía no colisionan ni producen daño, y el hacha aún no cambia el combate. Si se recoge otra hacha teniendo ya una, el objeto desaparece y el equipamiento sigue siendo hacha. La regla final de recogida añadirá la pulsación de ataque; no debe describirse como ya implementada.
- En la mecánica final, recoger requerirá la tecla de ataque además de agacharse. Si un jugador está sobre el punto al vencer el temporizador, el nuevo objeto no se recogerá automáticamente.

### Objetos, vida y final

- Todos los objetos tienen posición, dimensiones, gravedad, fricción y colisiones con plataformas y entre sí; pueden apilarse y frenarse sin deslizarse indefinidamente ni rebotar exageradamente.
- No se empujan al caminar; se desplazan por impactos autorizados. Caja, mesa y silla tienen resistencia configurable y desaparecen al llegar a cero. El barril es movible e indestructible.
- Disparos, golpes e impactos entre objetos producen daño fijo. Una colisión persistente no debe repetir daño cada cuadro; una plataforma no destruye automáticamente un objeto.
- La vida de cada jugador comienza en 100, no supera ese máximo y se regenera automáticamente a razón de tres puntos por segundo después de cinco segundos sin recibir daño. Cada nuevo daño reinicia la espera. Al llegar a cero o caer al vacío, muere sin reaparecer; la regeneración no revive a un jugador ni continúa después del final de la partida. Al aterrizar tras caer más de tres alturas de jugador, recibe un punto de daño por cada 12 píxeles adicionales, redondeando hacia arriba. La caída se mide desde el punto más alto alcanzado en el aire. Caer fuera del mundo sigue causando derrota inmediata. Si ambos mueren en la misma actualización, el resultado es «La partida quedó en empate». La barra de vida del HUD refleja la vida actual; la barra de resistencia permanece decorativa hasta que se apruebe conectarla.
- No añadas estadísticas, botones, menú final, revancha ni reinicio automático.

## 4. Decisiones y parámetros

No presentes parámetros no definidos como hechos. Antes de la etapa que los necesite, presenta una tabla agrupada que indique nombre, valor inicial recomendado, unidad, efecto, justificación y qué observar al probarlo. Centraliza los valores aprobados en un lugar claro; evita números mágicos y no exijas que el usuario decida cada número por separado.

Entre los valores que requieren propuesta están: vida, daños, retroceso, velocidades, salto, gravedad, resistencia, duración e intervalo de ataques, alcance, velocidad de proyectiles, vida de objetos, daño entre objetos, fricción y resistencia al movimiento.

Para decisiones no especificadas:

1. Respeta primero las reglas explícitas y las aclaraciones posteriores del usuario.
2. Usa la imagen disponible, distinguiendo observaciones de inferencias.
3. Si quedan varias opciones con consecuencias relevantes, explica alternativas y recomienda una; pide aprobación antes de codificarla.
4. No afirmes que una posición es original si no se verificó. Si investigas, limita la búsqueda al Superfighters original de 2011 y no confundas sus reglas con Superfighters Deluxe.
5. No investigues tecnologías externas si Processing nativo basta.

## 5. Etapas, dependencias y verificación

El trabajo parte del prototipo actual y avanza en este orden. No crees clases vacías, acciones falsas ni mecánicas temporales para aparentar progreso. No implementes una etapa antes de que sus dependencias estén terminadas.

### Etapa 0 — Diseño previo, sin código

Inspecciona el proyecto y el mapa disponibles. Usa las plataformas ya codificadas y las posiciones iniciales actuales como base; documenta discrepancias claras y propone ajustes solo donde hagan falta. Las posiciones iniciales actuales son jugador 1 en `(width/2, height/2)` y jugador 2 en `(width/4, height/8)`; son la base aprobada y podrán ajustarse más adelante.

Confirma mediante inspección la organización del código, las zonas de la escalera marinera y la correspondencia de las geometrías con Rooftops. No vuelvas a preguntar si el juego va a pantalla completa, qué controles usa cada jugador, dónde se ubican inicialmente los jugadores ni cómo funcionan los seis ciclos de armas: ya están definidos en esta guía.

No exijas en esta etapa las coordenadas de aparición de armas ni las ubicaciones de los objetos físicos: se proponen cuando se implementen esos sistemas. Tampoco exijas una tabla completa de parámetros antes de que sean necesarios. Propón y explica los parámetros al presentar cada etapa que dependa de ellos, agrupándolos y esperando aprobación antes de usarlos.

Presenta la arquitectura, las pruebas y solo las decisiones de diseño que aún afecten el trabajo. El empate se muestra exactamente como «La partida quedó en empate». Espera la aprobación del diseño antes de programar.

### Etapa 1 — Base técnica y flujo

Ordena la estructura compatible con Processing IDE, revisa Git, conserva los cambios existentes, centraliza configuración y revisa el manejo del tiempo y de la entrada. Mantén pantalla completa, la pantalla inicial y las coordenadas de colisión/inicio existentes. El archivo principal coordina el ciclo; dibujo y reglas quedan separados. El teletransporte debe ejecutarse aunque las plataformas estén ocultas. Documenta cómo ejecutar el sketch y la arquitectura aprobada.

**Aceptación:** compila en la Processing disponible, muestra la pantalla inicial y el mapa y comienza al pulsar Enter. No se avanza si la base no arranca.

### Etapa 2 — Escenario y geometrías

Revisa el fondo y las plataformas sólidas ya definidas; conserva sus coordenadas aproximadas y ajusta únicamente las que no coincidan con Rooftops. Mantén la plataforma central fija, los límites del mundo y la visualización de depuración. La escalera diagonal inferior derecha permanece sin colisiones adicionales hasta que el usuario las agregue como plataformas normales. No confundas esa geometría con la escalera marinera del centro, que recibe su comportamiento interactivo en la Etapa 4.

**Aceptación:** el plano de colisión coincide con Rooftops y todas las superficies acordadas están verificadas visualmente.

### Etapa 3 — Movimiento de dos jugadores

Integra personajes geométricos con movimiento, salto, gravedad, agachamiento, orientación, colisión con el escenario, carrera y resistencia. La colisión física entre jugadores permanece desactivada. Prueba que las entradas independientes se lean simultáneamente.

**Aceptación:** movimientos estables, aterrizajes y colisiones correctas; sin atravesar plataformas ni resistencia negativa.

### Etapa 4 — Escalera marinera y teletransporte

Implementa en la escalera marinera del centro una zona de interacción que cubra toda su parte visual. Dentro de ella, arriba/abajo inicia la subida o bajada. Izquierda/derecha permite abandonar la zona desde cualquier altura; al salir, se reanuda la física normal y el jugador puede caer. En el extremo superior puede saltar o salir de costado. Añade las dos parejas verticales de portales y mantén su lógica separada del dibujo de plataformas.

**Aceptación:** interacción en cualquier altura de la escalera, restricciones de acciones correctas, salida lateral/superior y teletransportes bidireccionales.

### Etapa 5 — Puñetazo, daño y victoria

Implementa el estado de ataque, hitbox temporal, daño, retroceso, vida, regeneración, muerte por daño y caída, sin derribos, invulnerabilidad ni reaparición. El puñetazo usa 10 puntos de daño, hitbox frontal del ancho del jugador por el 65 % de su alto activa entre 100 y 300 ms, y retroceso horizontal de 24 píxeles durante 120 ms. La vida regenera tres puntos por segundo después de cinco segundos sin daño, hasta 100; cualquier nuevo daño reinicia la espera y la regeneración no revive jugadores. La caída causa daño al aterrizar si supera tres alturas de jugador: un punto por cada 12 píxeles adicionales, redondeando hacia arriba, medidos desde el punto más alto alcanzado durante la caída. Caer fuera del mundo sigue causando derrota inmediata. El empate usa el texto «La partida quedó en empate».

**Aceptación:** un golpe por pulsación, ningún ataque en el aire, sin daño repetido por contacto y final correcto al morir uno o ambos.

### Etapa 6 — Pistola y proyectil base

Implementa espacios del inventario para arma de fuego y cuerpo a cuerpo, equipamiento inicial de pistola/puños, disparo horizontal por pulsación y consumo de munición. La pistola tiene 12 balas y el fusil 25; ambos disparan una bala por pulsación. El personaje puede moverse y disparar, incluso en el aire, pero no durante la escalada. Por ahora, las balas son visuales, atraviesan el escenario y se eliminan al salir de la pantalla; las colisiones y sus efectos se implementarán después.

**Aceptación:** orientación horizontal correcta, una bala por pulsación, conteo de 12 y 25 balas, pose de disparo correcta y limpieza al salir del mundo, sin colisiones en esta etapa.

### Etapa 7 — Hacha, fusil, recogida y ciclos de aparición

Integra el hacha, recogida agachado más ataque y sus efectos de combate. Para los puntos ya acordados, conserva el retraso global de 10 segundos y seis ciclos independientes de 30 segundos. Al comenzar cada ciclo y al vencer su temporizador, el punto muestra una elección equiprobable entre pistola, fusil (`ametralladora.png`) y hacha; puede repetirse el mismo tipo consecutivamente. Si recogen el objeto, el punto queda vacío hasta el vencimiento previsto. Si un jugador está sobre el punto cuando vence, aparece igualmente y no se recoge automáticamente. Los sprites se dibujan centrados, preservando su proporción, con su dimensión mayor limitada aproximadamente al 70 % de la altura del jugador. El prototipo ya recoge al agacharse y superponerse, equipa el tipo de arma correspondiente, carga la munición completa y muestra el icono en el HUD. La regla final añadirá la tecla de ataque. El uso de hacha queda pendiente. Recoger un hacha duplicada consume el objeto pero conserva el equipamiento actual. Los 10 y 30 segundos y la elección repetible ya fueron acordados: no volver a proponerlos para aprobación.

**Aceptación:** inventario independiente, reglas de reemplazo exactas, fusil con 25 disparos por cargador, seis ciclos independientes, tipo equiprobable y sustituciones en cada punto al vencer su temporizador.

### Etapa 8 — Objetos físicos

Añade caja, barril, mesa y silla en ubicaciones aprobadas. Implementa cuerpos, gravedad, fricción, colisiones, apilamiento y desplazamiento por impactos. Integra daño de puños, hacha, proyectiles y choques entre objetos; destruye solo los tres tipos destructibles.

**Aceptación:** objetos estables, sin vibración persistente ni deslizamiento indefinido; daño una vez por impacto, destrucción correcta y barril indestructible.

### Etapa 9 — Integración y cierre

Prueba la partida completa desde la pantalla inicial hasta victoria/empate. Revisa simultaneidad de controles, estados bloqueados, temporizadores, inventario, proyectiles, colisiones y condiciones de muerte. Actualiza `README.md`, `ARCHITECTURE.md` y `BUGS.md` para reflejar solo lo realmente implementado.

**Aceptación:** compila, se puede completar una partida, no quedan errores conocidos que impidan jugar y la documentación coincide con el comportamiento real.

## 6. Procedimiento de trabajo, Git y pruebas

Para cada etapa:

1. Expón objetivo, límites, dependencias, archivos, decisiones y pruebas.
2. Espera autorización explícita del usuario.
3. Implementa solo esa etapa.
4. Compila y ejecuta las pruebas posibles.
5. Reporta cambios y resultados, separando código inspeccionado, compilado, ejecutado y pendiente de prueba manual.
6. Indica cómo probarlo y detente hasta recibir confirmación.

Si encuentras un error de una etapa anterior o necesitas cambiar una decisión aprobada, explica el problema, consecuencia y solución recomendada; espera aprobación antes de modificarlo.

Revisa `git status` antes de trabajar. Conserva los cambios locales y no sobrescribas archivos sin inspeccionarlos. Trabaja en una rama de desarrollo separada cuando pueda hacerse sin perder o descartar el estado existente. No hagas commits automáticamente ni ejecutes `reset`, `rebase`, limpieza destructiva o borrado de ramas sin autorización explícita.

No afirmes que una mecánica funciona si solo leíste el código. Registra qué compilaste, qué ejecutaste y qué debe probar el usuario. No agregues herramientas ni dependencias de prueba externas.
