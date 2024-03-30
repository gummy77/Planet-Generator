class Camera {
  public vector3d position3d;
  public vector2d position2d;
  public float zoom = 1;

  public PGraphics g;
  //PostFX fx;

  public int res = 20;

  public vector2d viewTL, viewBR;

  Camera(Planet_Generator s, int _res) {
    this.res = _res;
    this.position2d = new vector2d();
    this.position3d = new vector3d(0, 0, 0);

    this.g = createGraphics(width, height, P3D);
    //this.fx = new PostFX(s);
  }

  public void update() {
    this.g.beginDraw();
    //image(this.background, 0, 0);
    zoom = constrain(zoom, 0.000000001, 15);
    camera.g.translate(position2d.x+(width/2), (position2d.y+height/2));
  }

  public void lateUpdate() {
    //g.point(0,0);
    this.g.endDraw();

    boolean a = false;
    if (!a) {
      image(this.g, 0, 0);
    } else {
      scale(0.5);
      translate(width/2, height/2);
      image(this.g, 0, 0);
      //this.fx.render()
      //  .chromaticAberration()
      //  .pixelate(width/res/2)
      //  .compose();
      
      push();
      stroke(0);
      strokeWeight(1);
      noFill();
      for (int i = 0; i < height/res/2; i++) {
        line(0, i*res*2, width, i*res*2);
      }
      pop();
    }
  }

  public vector2d mouseToScreen2d() {
    return new vector2d(mouseX-width/2, mouseY-height/2).mult(1/sq(zoom)).add(new vector2d(this.position2d.x, this.position2d.y).mult(-1)).mult(1);
  }
}
