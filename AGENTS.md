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
- Movimiento horizontal, salto, agachamiento, carrera con resistencia, puñetazo, apuntado, disparo, hacha, pistola, fusil, proyectiles, inventario, armas recogibles, teletransportes y las dos escaleras especificadas.
- Caja, barril metálico, mesa y silla como objetos físicos. Caja, mesa y silla se pueden destruir; el barril es movible e indestructible.
- Vida, muerte por daño o caída, victoria del último jugador vivo y empate si ambos mueren simultáneamente.

Quedan fuera: bots, juego online, mapas adicionales, granadas, vidrios rompibles, patadas, derribos, invulnerabilidad de recuperación, pausa, reinicio automático, revancha, rondas adicionales, música, efectos de sonido, puntuación y cualquier función adicional no aprobada.

La imagen Rooftops disponible mide 1920 × 1080. El juego se ejecuta a pantalla completa y la cámara permanece fija. Usa geometrías de colisión explícitas en código; no extraigas colisiones automáticamente de los píxeles. Las colisiones ya creadas son una base aproximada que se debe revisar y ajustar, no rehacer desde cero. Conserva las coordenadas actuales salvo que una discrepancia con el mapa o una petición del usuario justifique cambiarlas. El fondo se ajusta a pantalla completa.

Utiliza Processing nativo, sin Box2D ni bibliotecas externas. La versión menor de Processing no es un impedimento para comenzar; trabaja con la disponible y verifica compatibilidad cuando corresponda. No introduzcas dependencias.

## 3. Reglas de mecánicas confirmadas

### Jugadores y controles

- Jugador 1 usa WASD: `A`/`D` para moverse, `W` para saltar y `S` para agacharse.
- Jugador 2 usa las flechas: `←`/`→` para moverse, `↑` para saltar y `↓` para agacharse.
- Jugador 1 usa `N` para atacar o recoger y `M` para apuntar/disparar. Jugador 2 usa `1` para atacar o recoger y `2` para apuntar/disparar. Para `1` y `2`, usa inicialmente la fila superior del teclado.
- Al apuntar, las direcciones modifican la mira; en la escalera marinera, arriba/abajo permiten subir y bajar. Estas funciones dependen del estado actual del personaje.
- El prototipo actual ya implementa movimiento horizontal de jugador 1 con `A`/`D`, movimiento horizontal de jugador 2 con `←`/`→`, y salto de jugador 1 con `W` y jugador 2 con `↑`. Todavía no implementa agacharse ni las acciones de `N`, `M`, `1` y `2`.
- Gestiona teclas mantenidas y liberadas y prueba acciones simultáneas. Si una combinación no funciona, considera también el ghosting del teclado físico.
- Los personajes no se bloquean físicamente entre sí, pero pueden recibir daño de ataques y proyectiles.
- Los personajes se representan primero con formas geométricas. Separa su dibujo de su movimiento y combate para permitir añadir sprites en el futuro. No generes ni busques sprites.

### Movimiento y estados

- Correr se activa con doble pulsación de una dirección horizontal y mantenerla. Consume resistencia; al agotarla se detiene y vuelve la velocidad normal. La resistencia empieza a recuperarse al dejar de correr, no puede ser negativa y no reactiva la carrera automáticamente.
- No ataques cuerpo a cuerpo en el aire.
- Mantén separados el estado general de la partida y los estados de cada jugador. Evita estados incompatibles y condiciones de acción dispersas.
- La orientación debe seguir el movimiento o la mira y conservarse al soltar el apuntado.

### Escaleras y puertas

- La escalera marinera está en el centro del mapa. Su zona de interacción invisible cubre toda la parte visual. Si el personaje está dentro, puede iniciar la subida o bajada pulsando arriba/abajo desde cualquier altura; no necesita estar en un extremo.
- Durante la escalada no puede caminar normalmente, saltar, agacharse, atacar ni disparar, pero sí puede recibir daño. Puede moverse a izquierda o derecha para salir de la zona; al salir, deja de escalar, vuelve a la física normal y puede caer. En el extremo superior puede saltar o salir hacia un costado.
- La escalera recta inferior derecha, conocida en el proyecto como “escalerita falopa”, se representa actualmente mediante peldaños pequeños y debe convertirse en una pendiente transitable normal, sin estado especial de escalada.
- Hay cuatro indicadores verdes en el mapa. Las conexiones confirmadas son parejas verticales: el acceso superior e inferior del lado izquierdo forman una pareja; lo mismo en el lado derecho. El teletransporte funciona en ambos sentidos, sin espera ni restricciones adicionales.
- La lógica del teletransporte debe ejecutarse independientemente del dibujo de las plataformas. Ocultar las plataformas para depuración nunca debe desactivar los portales.

### Combate y armas

- El puñetazo es un golpe por pulsación, solo en el suelo, hacia donde mira el personaje. Tiene hitbox temporal, daño fijo, retroceso e intervalo. Durante el golpe bloquea las acciones especificadas. Una intersección persistente no debe aplicar daño varias veces.
- El hacha sustituye a los puños mientras está equipada, hace más daño y tiene más alcance, pero no consume munición ni durabilidad. Recoger otra hacha cuando ya se tiene no hace nada.
- Apuntar requiere mantener `M` o `2`; el personaje queda inmóvil, puede elegir ocho direcciones y conserva la última orientación al soltar. La pistola dispara un proyectil al soltar la tecla. Tiene 12 disparos; no dispara automáticamente.
- El fusil tiene 25 balas. Al soltar el apuntado inicia una ráfaga de cinco, con intervalo breve. El usuario puede seguir modificando la mira durante la ráfaga para orientar los disparos que aún no salieron. No permite ráfagas parciales.
- Cada jugador tiene espacios independientes para arma de fuego y arma cuerpo a cuerpo. Empieza con pistola de 12 disparos y puños; no empieza con fusil ni hacha. Recoger requiere agacharse y pulsar ataque con al menos un píxel de superposición. Los objetos recogibles no tienen colisión física. Una nueva arma de fuego reemplaza la anterior y no la deja caer; al agotarse desaparece y se conservan hacha o puños según corresponda.
- Los proyectiles dañan jugadores y objetos, chocan con plataformas sin dañarlas, y desaparecen al impactar o salir del mundo. No agregues rebotes, penetración, explosiones ni alcance máximo.

### Aparición de armas — reglas aclaradas por el usuario

- Hay seis puntos de aparición y cada uno mantiene su propio ciclo independiente. Al comenzar la partida aparece un arma en cada punto y se inicia el temporizador individual de cada arma.
- Cuando vence el temporizador de un punto, el arma anterior desaparece y otra aparece inmediatamente en ese mismo punto. El temporizador de la nueva arma comienza entonces.
- Si un jugador recoge el arma antes de que venza su temporizador, el punto queda vacío hasta el vencimiento previsto; en ese momento aparece la siguiente arma en el mismo lugar.
- Si un jugador está sobre el punto cuando vence el temporizador, el arma aparece igualmente y no se recoge automáticamente. Para recogerla debe agacharse y pulsar la tecla de ataque.
- En cada aparición, el tipo se selecciona con igual probabilidad entre pistola, fusil y hacha.
- La duración del temporizador se propondrá y aprobará al llegar a la etapa de armas; no exijas definirla en la etapa de análisis inicial. Si queda por decidir si un tipo puede repetirse consecutivamente, presenta una recomendación en esa etapa.

### Objetos, vida y final

- Todos los objetos tienen posición, dimensiones, gravedad, fricción y colisiones con plataformas y entre sí; pueden apilarse y frenarse sin deslizarse indefinidamente ni rebotar exageradamente.
- No se empujan al caminar; se desplazan por impactos autorizados. Caja, mesa y silla tienen resistencia configurable y desaparecen al llegar a cero. El barril es movible e indestructible.
- Disparos, golpes e impactos entre objetos producen daño fijo. Una colisión persistente no debe repetir daño cada cuadro; una plataforma no destruye automáticamente un objeto.
- La vida de cada jugador solo disminuye. Al llegar a cero o caer al vacío, muere sin reaparecer. La partida termina con `JUGADOR 1 GANA`, `JUGADOR 2 GANA` o un texto de empate que debe acordarse antes de implementarlo.
- No añadas estadísticas, botones, menú final, revancha ni reinicio automático.

## 4. Decisiones y parámetros

No presentes parámetros no definidos como hechos. Antes de la etapa que los necesite, presenta una tabla agrupada que indique nombre, valor inicial recomendado, unidad, efecto, justificación y qué observar al probarlo. Centraliza los valores aprobados en un lugar claro; evita números mágicos y no exijas que el usuario decida cada número por separado.

Entre los valores que requieren propuesta están: vida, daños, retroceso, velocidades, salto, gravedad, resistencia, duración e intervalo de ataques, alcance, velocidad de proyectiles, intervalo de ráfaga, vida de objetos, daño entre objetos, fricción y resistencia al movimiento.

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

Revisa el fondo y las plataformas sólidas ya definidas; conserva sus coordenadas aproximadas y ajusta únicamente las que no coincidan con Rooftops. Mantén la plataforma central fija, los límites del mundo y la visualización de depuración. Reemplaza la representación actual de la “escalerita falopa” inferior derecha por una pendiente transitable normal. No confundas esta pendiente con la escalera marinera del centro, que recibe su comportamiento interactivo en la Etapa 4.

**Aceptación:** el plano de colisión coincide con Rooftops y todas las superficies acordadas están verificadas visualmente.

### Etapa 3 — Movimiento de dos jugadores

Integra personajes geométricos con movimiento, salto, gravedad, agachamiento, orientación, colisión con el escenario, carrera y resistencia. La colisión física entre jugadores permanece desactivada. Prueba que las entradas independientes se lean simultáneamente.

**Aceptación:** movimientos estables, aterrizajes y colisiones correctas; sin atravesar plataformas ni resistencia negativa.

### Etapa 4 — Escalera marinera y teletransporte

Implementa en la escalera marinera del centro una zona de interacción que cubra toda su parte visual. Dentro de ella, arriba/abajo inicia la subida o bajada. Izquierda/derecha permite abandonar la zona desde cualquier altura; al salir, se reanuda la física normal y el jugador puede caer. En el extremo superior puede saltar o salir de costado. Añade las dos parejas verticales de portales y mantén su lógica separada del dibujo de plataformas.

**Aceptación:** interacción en cualquier altura de la escalera, restricciones de acciones correctas, salida lateral/superior y teletransportes bidireccionales.

### Etapa 5 — Puñetazo, daño y victoria

Implementa el estado de ataque, hitbox temporal, daño, retroceso, vida, muerte por daño y caída, sin derribos ni reaparición. Añade victoria y empate simultáneo, aprobando el texto antes de codificarlo.

**Aceptación:** un golpe por pulsación, ningún ataque en el aire, sin daño repetido por contacto y final correcto al morir uno o ambos.

### Etapa 6 — Pistola y proyectil base

Implementa espacios del inventario para arma de fuego y cuerpo a cuerpo, equipamiento inicial de pistola/puños, apuntado de ocho direcciones, inmovilidad al apuntar, disparo único al liberar y consumo de munición. Los proyectiles colisionan con jugadores y plataformas y se eliminan correctamente.

**Aceptación:** 12 disparos exactos, direcciones correctas, una bala por liberación y limpieza al impactar/salir del mundo.

### Etapa 7 — Hacha, fusil, recogida y ciclos de aparición

Integra el hacha, reemplazo de arma, recogida agachado más ataque, fusil con ráfagas de cinco, dirección ajustable durante la ráfaga y reglas de munición. Implementa seis ciclos independientes: una aparición inicial en cada punto y un temporizador propio por arma. Al vencer, reemplaza el arma en ese mismo lugar y reinicia el temporizador; si la recogen antes, deja vacío el punto hasta el vencimiento. Si un jugador está sobre el punto, aparece igualmente sin recogerse automáticamente. Propón y aprueba la duración antes de implementarla.

**Aceptación:** inventario independiente, reglas de reemplazo exactas, fusil con cinco ráfagas completas, seis ciclos independientes, tipo equiprobable y sustituciones en cada punto al vencer su temporizador.

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
