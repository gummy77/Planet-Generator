//import ch.bildspur.postfx.builder.*;
//import ch.bildspur.postfx.pass.*;
//import ch.bildspur.postfx.*;

public static final boolean DEBUG1 = false;
public static final boolean DEBUG2 = false;
public static final boolean DEBUG3 = false;

public static final boolean DEBUGDRAWCOLLIDERS = false;
public static final boolean DEBUGDRAWWIREFRAME = false;

public Camera camera;
public Time time;
public ObjectManager manager;

float phoneSizeX = 300;
float phoneSizeY = 700;

float scale = 0.25;
int res = 3;

void settings() {
  //size(floor((phoneSizeX*scale)/res)*res, floor((phoneSizeY*scale)/res)*res, P3D);
  size(floor((600)/res)*res, floor((600)/res)*res, P3D);
  //size(floor((displayWidth)/res)*res, floor((displayHeight)/res)*res, P3D);


  //fullScreen(P3D);
}

void setup() {
  //frameRate(15);
  if (DEBUG1) println("LOADING");
  camera = new Camera(this, res);
  time = new Time();
  manager = new ObjectManager();

  begin();
}


void draw() {
  //scale(scale);
  camera.update();
  camera.g.background(0);
  camera.g.lightSpecular(255, 255, 255);
  camera.g.directionalLight(150, 150, 150, -1, 1, -1);
  camera.g.ambientLight(15, 15, 15);
  manager.GameStep();

  if (mousePressed) {
    if (mouseButton == CENTER) {
      camera.position3d.add(new vector3d(-mouseX+width/2, -mouseY+height/2, 0).mult(0.01));
    }
  }
  Update();

  time.Update();
  camera.lateUpdate();
}

//public class ScreenPass extends BasePass {
//  private static final String PASS_NAME = "ScreenShader";

//  private float amount;
//  PShader shader;

//  public ScreenPass(PApplet sketch) {
//    this(sketch, 10);
//  }

//  public ScreenPass(PApplet sketch, float amount) {
//    super(sketch, PASS_NAME);

//    this.amount = amount;
//  }

//  //@Override
//  public void prepare(Supervisor supervisor) {
//    shader.set("resolution", supervisor.getResolution());
//    shader.set("amount", amount);
//  }

//  public float getAmount() {
//    return amount;
//  }

//  public void setAmount(float amount) {
//    this.amount = amount;
//  }
//}
