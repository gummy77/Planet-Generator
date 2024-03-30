public static final int Transform2dID = 1;
//class for transform
class Transform2d extends Component {
  public vector2d position;
  public float rotation;


  //initialise class
  public void init(GameObject _gameobject) {
    this.ID = 1;
    this.gameobject = _gameobject;
  }
  public Transform2d () {
    this.position = new vector2d();
    this.rotation = 0;
  }
  
  public Transform2d (vector2d _position, float _rotation) {
    this.position = _position;
    this.rotation = _rotation;
  }

  //functions to move position
  void move(vector2d d) {
    this.position.add(d);
  }
  void move(float _x, float _y) {
    this.position.add(new vector2d(_x, _y));
  }
}

public static final int Transform3dID = 7;
//class for transform
class Transform3d extends Component {
  public vector3d position;
  public vector3d rotation;


  //initialise class
  public void init(GameObject _gameobject) {
    this.ID = 7;
    this.gameobject = _gameobject;
  }
  public Transform3d () {
    this.position = new vector3d();
    this.rotation = new vector3d();;
  }
  
  public Transform3d (vector3d _position, vector3d _rotation) {
    this.position = _position;
    this.rotation = _rotation;
  }

  //functions to move position
  void move(vector3d d) {
    this.position.add(d);
  }
  void move(float _x, float _y, float _z) {
    this.move(new vector3d(_x, _y, _z));
  }
}
