class ObjectManager {
  GameObject[] objects;
  
  public ObjectManager(){
    this.objects = new GameObject[0];
  }
  
  public void GameStep(){
    this.UpdateObjects();
    this.UpdateObjectComponents();
    this.LateUpdateObjects();
    this.LateUpdateObjectComponents();
    if (DEBUG2) println("GAMESTEP UPDATED");
  }
  
  public void UpdateObjects(){
    for(GameObject object : objects){
      object.RawUpdate();
    }
  }
  
  public void UpdateObjectComponents(){
    for(GameObject object : objects){
      object.UpdateComponents();
    }
  }
  
  public void LateUpdateObjects(){
    for(GameObject object : objects){
      object.RawLateUpdate();
    }
  }
  
  public void LateUpdateObjectComponents(){
    for(GameObject object : objects){
      object.LateUpdateComponents();
    }
  }
  
  public void createObject(GameObject object){
    this.objects = (GameObject[])append(this.objects, object);
    if(DEBUG1) println(object+" HAS BEEN ADDED TO: "+this);
  }
  
}
