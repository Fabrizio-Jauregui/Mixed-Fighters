[1mdiff --git a/src/MixedFighters.pde b/src/MixedFighters.pde[m
[1mindex 6720e18..2ecd7c0 100644[m
[1m--- a/src/MixedFighters.pde[m
[1m+++ b/src/MixedFighters.pde[m
[36m@@ -23,6 +23,7 @@[m [mBox2DProcessing box2d;[m
 // ============================================================[m
 [m
 Jugador Jugador;[m
[32m+[m[32mJugador Jugador2;[m[41m[m
 [m
 [m
 // ============================================================[m
[36m@@ -124,6 +125,13 @@[m [mvoid setup() {[m
     60,[m
     60[m
     );[m
[32m+[m[41m    [m
[32m+[m[32m      Jugador2 = new Jugador([m[41m[m
[32m+[m[32m    width/4,[m[41m[m
[32m+[m[32m    height/8,[m[41m[m
[32m+[m[32m    60,[m[41m[m
[32m+[m[32m    60[m[41m[m
[32m+[m[32m    );[m[41m[m
 }[m
 [m
 [m
[36m@@ -145,6 +153,7 @@[m [mvoid draw() {[m
   // ----------------------------------------------------------[m
 [m
   Jugador.mover(is_a, is_d);[m
[32m+[m[32m  Jugador2.mover(is_LEFT, is_RIGHT);[m[41m[m
 [m
 [m
   // ----------------------------------------------------------[m
[36m@@ -152,4 +161,5 @@[m [mvoid draw() {[m
   // ----------------------------------------------------------[m
 [m
   Jugador.dibujar();[m
[32m+[m[32m  Jugador2.dibujar();[m[41m[m
 }[m
[1mdiff --git a/src/Teclas.pde b/src/Teclas.pde[m
[1mindex 4afc816..e60c997 100644[m
[1m--- a/src/Teclas.pde[m
[1m+++ b/src/Teclas.pde[m
[36m@@ -1,4 +1,4 @@[m
[31m-boolean is_a = false, is_d = false;[m
[32m+[m[32mboolean is_a = false, is_d = false, is_LEFT, is_RIGHT;[m[41m[m
 [m
 [m
 void keyPressed() {[m
[36m@@ -10,10 +10,22 @@[m [mvoid keyPressed() {[m
   if (key == 'd' || key == 'D') {[m
     is_d = true;[m
   }[m
[32m+[m[41m  [m
[32m+[m[32m    if (keyCode == LEFT) {[m[41m[m
[32m+[m[32m    is_LEFT = true;[m[41m[m
[32m+[m[32m  }[m[41m[m
[32m+[m[41m[m
[32m+[m[32m  if (keyCode == RIGHT) {[m[41m[m
[32m+[m[32m    is_RIGHT = true;[m[41m[m
[32m+[m[32m  }[m[41m[m
 [m
[31m-  if (key == ' ') {[m
[32m+[m[32m  if (key == 'w') {[m[41m[m
     Jugador.saltar();[m
   }[m
[32m+[m[41m  [m
[32m+[m[32m    if (keyCode == UP) {[m[41m[m
[32m+[m[32m    Jugador2.saltar();[m[41m[m
[32m+[m[32m  }[m[41m[m
 }[m
 [m
 [m
[36m@@ -25,5 +37,13 @@[m [mvoid keyReleased() {[m
 [m
   if (key == 'd' || key == 'D') {[m
     is_d = false;[m
[32m+[m[32m  }[m[41m[m
[32m+[m[41m  [m
[32m+[m[32m      if (keyCode == LEFT) {[m[41m[m
[32m+[m[32m    is_LEFT = false;[m[41m[m
[32m+[m[32m  }[m[41m[m
[32m+[m[41m[m
[32m+[m[32m  if (keyCode == RIGHT) {[m[41m[m
[32m+[m[32m    is_RIGHT = false;[m[41m[m
   }[m
 }[m
[1mdiff --git a/src/sketch.properties b/src/sketch.properties[m
[1mnew file mode 100644[m
[1mindex 0000000..da22df1[m
[1m--- /dev/null[m
[1m+++ b/src/sketch.properties[m
[36m@@ -0,0 +1 @@[m
[32m+[m[32mmain=MixedFighters.pde[m
