public static final int Renderer3dID = 8;
//class for transform
class Renderer3d extends Component {
  public vector3d position;
  public vector3d rotation;

  //initialise class
  public void init(GameObject _gameobject) {
    this.ID = 8;
    this.gameobject = _gameobject;
    this.position = new vector3d();
    this.rotation = new vector3d();
  }

  //functions to move position
  void RawUpdate() {
    Transform3d currentTransform = this.gameobject.GetComponent(Transform3dID);
    this.position = currentTransform.position;
    this.rotation = currentTransform.rotation;

    this.Update();
  }

  void Update() {
  }
}

public static final int MeshRenderer3dID = 6;
class MeshRenderer3d extends Renderer3d {
  public Mesh mesh;

  //initialise class
  public void init(GameObject _gameobject) {
    this.ID = 6;
    this.gameobject = _gameobject;
  }

  public MeshRenderer3d( Mesh _mesh) {
    this.mesh = _mesh;
  }

  public MeshRenderer3d() {
  }

  void Update() {
    if (this.mesh != null) {
      drawMesh(this.mesh);
    }
  }
}
