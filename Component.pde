class Component {
  public int ID = 0;
  public GameObject gameobject;

  public void init(GameObject _gameobject) {
    this.gameobject = _gameobject;
  }

  public void RawUpdate() {
    this.Update();
  }
  void Update() {
  }

  public void RawLateUpdate() {
    this.LateUpdate();
  }
  private void LateUpdate() {
  }
  
  public void RawUIUpdate() {
    this.UIUpdate();
  }
  private void UIUpdate() {
  }

  public void OnCollision2d(Collision2d collision) {
  }
  
  public void OnTriggerCollision2d(Collision2d collision) {
  }
}
