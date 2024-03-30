public class Mesh {
  GameObject gameobject;
  public vector3d[] vertices;
  public int[] triangles;
  public Material[] materials;

  Mesh(GameObject _gameobject, vector3d[] _vertices, int[] _triangles, Material[] _materials) {
    this.gameobject = _gameobject;
    this.vertices = _vertices;
    this.triangles = _triangles;
    this.materials = _materials;
  }
  Mesh(GameObject _gameobject) {
    this.gameobject = _gameobject;
    this.vertices = new vector3d[0];
    this.triangles = new int[0];
    this.materials = new Material[0];
  }
  public void clear() {
    this.vertices = new vector3d[0];
    this.triangles = new int[0];
    this.materials = new Material[0];
  }
}

void drawMesh(Mesh mesh) {
  Planet planet = mesh.gameobject.GetComponent(PlanetID);

  for (int i = 0; i < mesh.triangles.length; i+=4) {
    camera.g.push();

    if (DEBUGDRAWWIREFRAME) {
      camera.g.stroke(0);
      camera.g.strokeWeight(1);
    } else {
      camera.g.noStroke();
    }

    Transform3d transform = mesh.gameobject.GetComponent(Transform3dID);
    camera.g.translate(transform.position.x, transform.position.y, transform.position.z);
    camera.g.rotateX(transform.rotation.x);
    camera.g.rotateY(transform.rotation.y);
    camera.g.rotateZ(transform.rotation.z);

    camera.g.beginShape(QUADS);
    camera.g.fill(mesh.materials[i/4].colour);
    camera.g.specular(mesh.materials[i/4].specular);
    camera.g.shininess(mesh.materials[i/4].shininess);
    if (mesh.materials[i/4].emissive) {
      camera.g.emissive(mesh.materials[i/4].emission);
    }
    for (int j = 0; j < 4; j++) {
      int id = i+j;
      vector3d vector = mesh.vertices[mesh.triangles[id]].clone();
      camera.g.vertex(vector.x, vector.y, vector.z);
    }
    camera.g.endShape();
    camera.g.pop();
  }
}
