import shiffman.box2d.*;
import org.jbox2d.dynamics.*;
Box2DProcessing box2d;  

void setup(){
 size(800, 800); 
   
   box2d = new Box2DProcessing(this);
   box2d.createWorld();
   box2d.setGravity(0,-10);
   BodyDef bd = new BodyDef();
   bd.type = BodyType.DYNAMIC;
   bd.position.x = width/2;
   bd.position.y = height/2;
   Body body = box2d.world.createBody(bd);
}

void draw(){
  background(200);
  box2d.step();

}
