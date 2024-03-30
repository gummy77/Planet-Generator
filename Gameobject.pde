//base class for a gameobject
class GameObject {
  public ObjectManager manager;
  private Component[] components;

  //creation function
  GameObject() {
    //initialize variables
    this.manager = manager;
    this.components = new Component[0];
  }

  public void RawUpdate () {
    this.Update();
  }
  private void Update() {
  }

  public void RawLateUpdate () {
    this.LateUpdate();
  }
  private void LateUpdate() {
  }

  //update components
  void UpdateComponents() {
    for (Component c : this.components) {
      c.RawUpdate();
    }
  }
  //late update components (happens after everything else)
  void LateUpdateComponents() {
    for (Component c : this.components) {
      c.RawLateUpdate();
    }
  }


  public void addComponent(Component newComponent) {
    this.components = (Component[]) append(this.components, newComponent);
    newComponent.init(this);
    if (DEBUG1) println("ADDED: "+newComponent+" TO "+this);
  }

  public <T> T GetComponent(int componentType) {
    for (Component c : this.components) {
      if (c.ID == componentType) return (T) c;
    }
    return null;
  }
  
  private void OnCollision(Collision2d event){
    for (Component c : this.components) {
      c.OnCollision2d(event);
    }
  }
  
  private void OnTriggerCollision(Collision2d event){
    for (Component c : this.components) {
      c.OnTriggerCollision2d(event);
    }
  }
}
