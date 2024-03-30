//class to keep track of time and to help with physics calculations
class Time {
  //initialize variables
  public float gameSpeed = 1;

  public float realTime;
  public float gameTime;
  public float realDeltaTime;
  public float deltaTime;
  public int fps;

  private float lastFPSUpdate;
  private float lastTime;

  //updates every frame
  public void Update() {
    //do a lot of math
    this.realTime = millis()/float(1000);
    this.realDeltaTime = this.realTime-this.lastTime;
    this.deltaTime = this.realDeltaTime * gameSpeed;
    this.gameTime += this.deltaTime;

    //updates the frame every 5 frames so it's more readable
    if (this.realTime-this.lastFPSUpdate > 0.2) {
      this.lastFPSUpdate = this.realTime;
      this.fps = round(1/(this.realTime-this.lastTime));
    }

    this.lastTime = this.realTime;
    
    //surface.setTitle("FPS: "+this.fps);
    //println("fps: "+this.fps);
  }
}
