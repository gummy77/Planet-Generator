public static final int Rigidbody2dID = 4;
class Rigidbody2d extends Component {
  public GameObject gameobject;
  public float mass;

  public vector2d velocity;
  public boolean isPhysics;

  public void init(GameObject _gameobject) {
    this.ID = 4;
    this.gameobject = _gameobject;
  }

  Rigidbody2d(float _mass) {
    this.velocity = new vector2d();
    this.mass = _mass;
    this.isPhysics = true;
  }
  Rigidbody2d() {
    this.velocity = new vector2d();
    this.mass = 1;
    this.isPhysics = false;
  }

  public void RawUpdate() {
    this.Update();
  }
  public void RawLateUpdate() {
    this.LateUpdate();
  }

  void Update() {
    if (!this.isPhysics)return;
    Transform2d currentTransform = this.gameobject.GetComponent(Transform2dID);
    currentTransform.move(velocity.clone());
    if (DEBUG3) println("PHYSICS OF: "+this+" HAS BEEN UPDATED");
  }

  private void LateUpdate() {
  }

  public void AddForce(vector2d force) {
    if (!this.isPhysics) return;
    this.velocity.add(force.mult(1/this.mass));
    if (DEBUG3) println("FORCE OF: "+force.mag()+"N ADDED TO: "+this);
  }

  public void OnCollision(Collision2d event) {
    Rigidbody2d rigidbody1 = event.owner.GetComponent(Rigidbody2dID);
    Rigidbody2d rigidbody2 = event.other.GetComponent(Rigidbody2dID);

    if (rigidbody1.isPhysics && rigidbody2.isPhysics) {
      switch(event.CollisionType) {
        case(0):
        this.SphereBounce(event.owner, event.other);
        break;
      }
    } else if (rigidbody2.isPhysics) {
      this.SphereBounceOff(event.owner, event.other);
    } else{
      this.SphereBounceOff(event.other, event.owner);
    }
  }

  private void SphereBounce(GameObject ball1, GameObject ball2) {
    Transform2d transform1 = ball1.GetComponent(Transform2dID);
    Transform2d transform2 = ball2.GetComponent(Transform2dID);

    Rigidbody2d rigidbody1 = ball1.GetComponent(Rigidbody2dID);
    Rigidbody2d rigidbody2 = ball2.GetComponent(Rigidbody2dID);

    SphereCollider2d spherecollider1 = ball1.GetComponent(SphereCollider2dID);
    SphereCollider2d spherecollider2 = ball2.GetComponent(SphereCollider2dID);

    vector2d normal = transform1.position.vectorTo(transform2.position).normalize();

    //get all the variables smaller so the math is less crowded
    vector2d v1 = rigidbody1.velocity.clone();//new vector2d(this.velocity.y, this.velocity.x*-1);
    vector2d v2 = rigidbody2.velocity.clone();//new vector2d(ball.rigidbody.velocity.y, ball.rigidbody.velocity.x*-1);
    float m1 = rigidbody1.mass;
    float m2 = rigidbody2.mass;
    vector2d p1 = transform1.position.clone();
    vector2d p2 = transform2.position.clone();

    //do some math for this objects new velocity
    //have the vriables as unnamed smaller variables to keep the math easier to read and less cluttered
    float mm1 = (2*m2)/(m1+m2);
    float a1 = dot(v1.clone().remove(v2.clone()), p1.clone().remove(p2.clone()));
    float b1 = ((p1.clone().remove(p2.clone())).mag() * (p1.clone().remove(p2.clone())).mag());
    vector2d c1 = (p1.clone().remove(p2.clone())).mult(mm1*(a1/b1));

    //do some math for the other objects new velocity
    float mm2 = (2*m1)/(m1+m2);
    float a2 = dot(v2.clone().remove(v1.clone()), p2.clone().remove(p1.clone()));
    float b2 = ((p2.clone().remove(p1.clone())).mag() * (p2.clone().remove(p1.clone())).mag());
    vector2d c2 = (p2.clone().remove(p1.clone())).mult(mm2*(a2/b2));

    //apply the new velocitys
    rigidbody1.velocity = v1.remove(c1).mult(0.995);
    rigidbody2.velocity = v2.remove(c2).mult(0.995);

    //move this object out of the way so it is no longer collising with the other ball
    vector2d difference = normal.mult(transform2.position.clone().dist(transform1.position)-(spherecollider2.radius+spherecollider1.radius));
    transform1.move(difference);
  }

  private void SphereBounceOff(GameObject ball1, GameObject ball2) {
    Transform2d transform1 = ball1.GetComponent(Transform2dID);
    Transform2d transform2 = ball2.GetComponent(Transform2dID);

    Rigidbody2d rigidbody2 = ball2.GetComponent(Rigidbody2dID);

    SphereCollider2d spherecollider1 = ball1.GetComponent(SphereCollider2dID);
    SphereCollider2d spherecollider2 = ball2.GetComponent(SphereCollider2dID);

    vector2d normal = transform2.position.vectorTo(transform1.position).normalize();

    float theta = normal.toAngle() - rigidbody2.velocity.toAngle();
    float H = new vector2d(-rigidbody2.velocity.x, -rigidbody2.velocity.y).mag();
    float thetRad = theta*(PI/180);
    this.AddForce(new vector2d(normal.toAngle()).mult(cos(thetRad)*H*-1.95).mult(0.995));

    //move the object so its position is not intersecting the ball
    vector2d difference = normal.mult(transform1.position.clone().dist(transform2.position)-(spherecollider1.radius+spherecollider2.radius));
    transform2.move(difference);
  }
}
