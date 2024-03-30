public static final int Renderer2dID = 5;
//class for transform
class Renderer2d extends Component {
  public vector2d position;
  public float rotation;

  //initialise class
  public void init(GameObject _gameobject) {
    this.ID = 5;
    this.gameobject = _gameobject;
  }

  //functions to move position
  void RawUpdate() {
    Transform2d currentTransform = this.gameobject.GetComponent(Transform2dID);
    this.position = currentTransform.position;
    this.rotation = currentTransform.rotation;

    this.Update();
  }

  void Update(){
    
  }

}

public static final int EllipseRenderer2dID = 6;
class EllipseRenderer2d extends Renderer2d {
  public vector2d size;
  public color fill;
  public color stroke;
  public float strokeWeight;

  //initialise class
  public void init(GameObject _gameobject) {
    this.ID = 6;
    this.gameobject = _gameobject;
  }

  public EllipseRenderer2d(vector2d _size, color _fill, color _stroke, float _strokeWeight) {
    this.size = _size;
    this.fill = _fill;
    this.stroke = _stroke;
    this.strokeWeight = _strokeWeight;
  }
  public EllipseRenderer2d(float _radius, color _fill, color _stroke, float _strokeWeight) {
    this.size = new vector2d(_radius*2, _radius*2);
    this.fill = _fill;
    this.stroke = _stroke;
    this.strokeWeight = _strokeWeight;
  }


  void Update() {
    push();
    fill(this.fill);
    stroke(this.stroke);
    strokeWeight(this.strokeWeight);
    ellipse(this.position.x, this.position.y, this.size.x, this.size.y);
    pop();
  }
}
