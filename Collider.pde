public static final int Collider2dID = 2;
class Collider2d extends Component {
  public GameObject gameobject;
  public vector2d position;
  public boolean physicsCollider;

  public Collision2d[] collisions;

  public void init(GameObject _gameobject) {
    this.ID = 2;
    this.gameobject = _gameobject;
    this.collisions = new Collision2d[0];
  }

  public boolean isSphereColliding() {
    return false;
  }
  public void RawUpdate() {
    this.collisions = new Collision2d[0];
    this.Update();
  }
  public void Update() {
  }
}

class Collision2d extends Event {
  public GameObject owner;
  public GameObject other;
  public int CollisionType;

  public Collision2d(int _CollisionType, GameObject _owner, GameObject _other) {
    this.CollisionType = _CollisionType;
    this.owner = _owner;
    this.other = _other;
  }
}




public static final int SphereCollider2dID = 3;
class SphereCollider2d extends Collider2d {
  public vector2d position;
  public float radius;

  //initialise class when it has lines
  public void init(GameObject _gameobject) {
    this.ID = 3;
    this.gameobject = _gameobject;
    this.collisions = new Collision2d[0];
  }

  public SphereCollider2d(boolean _physicsCollider, int _radius) {
    this.physicsCollider = _physicsCollider;
    this.radius = _radius;
    this.position = new vector2d();
  }

  public boolean isSphereColliding(SphereCollider2d other) {
    if (other.getClass() == this.getClass()) {
      if (sphereColliding(this.position, this.radius, other.position, other.radius)) return true;
      return false;
    }
    return false;
  }

  public void Update() {
    for (GameObject go : manager.objects) {
      if (go != this.gameobject) {
        SphereCollider2d currentSphereCollider = go.GetComponent(SphereCollider2dID);
        if (currentSphereCollider != null) {
          if (this.isSphereColliding(currentSphereCollider)) {
            Collision2d colEvent = new Collision2d(0, this.gameobject, go);
            this.collisions = (Collision2d[])append(this.collisions, colEvent);

            if (this.physicsCollider && currentSphereCollider.physicsCollider) {
              this.gameobject.OnCollision(colEvent);
            } else {
              this.gameobject.OnTriggerCollision(colEvent);
            }
          }
        }
      }
    }
  }

  public void LateUpdate() {
    if (DEBUGDRAWCOLLIDERS) { 
      noFill();
      if (this.collisions.length <= 0) {
        stroke(0);
      } else {
        stroke(255, 0, 0);
      }
      strokeWeight(1);
      circle(this.position.x, this.position.y, this.radius*2);
    }
  }
}
