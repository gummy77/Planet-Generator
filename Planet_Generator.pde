GameObject planet;

ShapeSettings shapeSettings;
ColourSettings colourSettings;
OceanSettings oceanSettings;
NoiseSettings noiseSettings;

float planetScale = 3.5;

public void begin() {

  noiseSettings = new NoiseSettings();
  noiseSettings.strength = 0.4;
  noiseSettings.numLayers = 3;
  noiseSettings.baseRoughness = 0.2;
  noiseSettings.roughness = 6;
  noiseSettings.persistance = 0.3;
  noiseSettings.poleStrength = 0.1;

  shapeSettings = new ShapeSettings(noiseSettings);
  shapeSettings.planetRadius = (width/planetScale)-((width/planetScale)/5);
  shapeSettings.resolution = 8*7+1;
  println("rendering at planet resolution: "+shapeSettings.resolution);

  colourSettings = new ColourSettings();
  colourSettings.planetMaterial.colour = color(0, 255, 0);

  colourSettings.planetLowMaterial.colour = color(237, 215, 130);
  colourSettings.planetLowHeight = 1.3;

  colourSettings.planetHighMaterial.colour = color(153, 153, 153);
  colourSettings.planetHighHeight = 1.375;

  colourSettings.poleHeight = width/planetScale;
  colourSettings.poleMaterial.colour = color(185, 232, 234);
  colourSettings.poleMaterial.specular = color(255, 255, 255);
  colourSettings.poleMaterial.shininess = 0.5;

  colourSettings.oceanMaterial.colour = color(29, 162, 216);
  colourSettings.oceanMaterial.specular = color(222, 243, 246);
  colourSettings.oceanMaterial.shininess = 10;

  oceanSettings = new OceanSettings();
  oceanSettings.oceanRadius = width/planetScale;
  oceanSettings.strength = 0.05;
  oceanSettings.roughness = 10;
  oceanSettings.time = 0;
  oceanSettings.timeRate = 0.01;

  planet = new GameObject();
  planet.addComponent(new Transform3d(new vector3d(0, 0, -100), new vector3d()));
  planet.addComponent(new Planet(shapeSettings, colourSettings, oceanSettings));
  manager.createObject(planet);

  Planet p = planet.GetComponent(PlanetID);
  p.GeneratePlanet();
  println("hoo mama thats "+(p.meshes[0].triangles.length)*6+" triangles.");
}

float lastMouseX;
float lastMouseY;
float lastXRot;
float lastYRot;
float curXRot;
float curYRot;
float lastXRotMouse;
float lastYRotMouse;
float CameraXdiff;
float CameraYdiff;

boolean wasPressed = false;

public void Update() {
  Transform3d transform = planet.GetComponent(Transform3dID);
  float lerpTime = 10;
  float RotationSpeed = -0.02;
  float closeEnough = 0.05;

  curYRot = lerp(curYRot, 0, time.deltaTime*lerpTime);

  camera.g.push();
  camera.g.fill(255);
  camera.g.noStroke();
  camera.g.rect(-width/2, (height/2)-(height/6), width, height/5);
  camera.g.fill(0);
  camera.g.textAlign(CENTER, CENTER);
  camera.g.textSize((height/5)*0.25);
  camera.g.text("Generate", -width/2, (height/2)-(height/6), width, height/6);
  camera.g.pop();

  if (mousePressed) {
    if (mouseY >= height-(height/5)) {
      if (!wasPressed) {
        noiseSettings.seed = random(100000);
        Planet curPlanet = planet.GetComponent(PlanetID);
        curPlanet.GeneratePlanet();
      }
    } else {
      if (!wasPressed) {
        lastMouseX = camera.mouseToScreen2d().x;
        lastMouseY = -camera.mouseToScreen2d().y;
      }
      CameraXdiff =  camera.mouseToScreen2d().x - lastMouseX;
      CameraYdiff = -camera.mouseToScreen2d().y - lastMouseY;

      lastXRotMouse = lastXRot+(CameraXdiff/ width*4);

      if (CameraYdiff==0) {
        lastYRotMouse = lastYRot;
      } else {
        lastYRotMouse = lastYRot+(CameraYdiff/height*4);
      }


      //println("curYRot", curYRot, "lastYRot", lastYRot);
    }
    wasPressed = true;
  } else {
    wasPressed = false;
    lastMouseX = camera.mouseToScreen2d().x;
    lastMouseY = -camera.mouseToScreen2d().y;

    lastXRot = curXRot;
    lastYRot = curYRot;


    if (lastXRotMouse <= curXRot+closeEnough && lastXRotMouse >= curXRot-closeEnough) {
      lastXRotMouse = lastXRotMouse+RotationSpeed;
      //lastYRotMouse = 0;
    }
  }

  curXRot = lerp(curXRot, lastXRotMouse, time.deltaTime*lerpTime/2);
  curYRot = constrain(lerp(curYRot, lastYRotMouse, time.deltaTime*lerpTime/2), -1, 1);

  transform.rotation = new vector3d(curYRot, curXRot, 0);
}

public static final int PlanetID = -1;
class Planet extends Component {

  public ShapeSettings shapeSettings;
  public ColourSettings colourSettings;
  public OceanSettings oceanSettings;

  public ShapeGenerator shapeGenerator;
  public ColourGenerator colourGenerator;
  public OceanShapeGenerator oceanShapeGenerator;

  Mesh[] meshes;
  TerrainFace[] terrainFaces;

  Mesh[] oceanMeshes;
  TerrainFace[] oceanFaces;

  public void init(GameObject _gameobject) {
    this.ID = -1;
    this.gameobject = _gameobject;
  }

  Planet(ShapeSettings _shapeSettings, ColourSettings _colourSettings, OceanSettings _oceanSettings) {
    this.shapeSettings = _shapeSettings;
    this.colourSettings = _colourSettings;
    this.oceanSettings = _oceanSettings;
  }

  void Initialize() {
    //                           up                     down                left                      right                forward              back
    vector3d[] directions = {new vector3d(0, 1, 0), new vector3d(0, -1, 0), new vector3d(-1, 0, 0), new vector3d(1, 0, 0), new vector3d(0, 0, 1), new vector3d(0, 0, -1)};

    this.colourGenerator = new ColourGenerator(this.colourSettings);

    this.shapeGenerator = new ShapeGenerator(this.shapeSettings);
    this.meshes = new Mesh[6];
    this.terrainFaces = new TerrainFace[6];

    for (int i = 0; i < 6; i++) {
      this.meshes[i] = new Mesh(this.gameobject);
      this.terrainFaces[i] = new TerrainFace(this.shapeGenerator, this.colourGenerator, null, this.meshes[i], this.shapeSettings.resolution, directions[i]);
    }

    this.oceanShapeGenerator = new OceanShapeGenerator(this.oceanSettings);
    this.oceanMeshes = new Mesh[6];
    this.oceanFaces = new TerrainFace[6];

    for (int i = 0; i < 6; i++) {
      this.oceanMeshes[i] = new Mesh(this.gameobject);
      this.oceanFaces[i] = new TerrainFace(null, this.colourGenerator, this.oceanShapeGenerator, this.oceanMeshes[i], this.shapeSettings.resolution, directions[i]);
    }
  }

  public void GeneratePlanet() {
    this.Initialize();
    this.GenerateMesh();
    this.GenerateOcean();
  }

  void GenerateMesh() {
    for (TerrainFace face : terrainFaces) {
      face.ConstructMesh();
    }
  }

  void GenerateOcean() {
    for (TerrainFace face : oceanFaces) {
      face.ConstructMesh();
    }
  }

  void Update() {
    for (TerrainFace face : oceanFaces) {
      drawMesh(face.mesh);
    }
    for (TerrainFace face : terrainFaces) {
      drawMesh(face.mesh);
    }
    this.oceanSettings.time+=this.oceanSettings.timeRate;
    GenerateOcean();
  }
}

class TerrainFace {
  ShapeGenerator shapeGenerator;
  ColourGenerator colourGenerator;
  OceanShapeGenerator oceanShapeGenerator;
  Mesh mesh;
  int resolution;
  vector3d localUp;
  vector3d axisA;
  vector3d axisB;

  TerrainFace(ShapeGenerator _shapeGenerator, ColourGenerator _colourGenerator, OceanShapeGenerator _oceanShapeGenerator, Mesh _mesh, int _resolution, vector3d _localUp) {
    this.shapeGenerator = _shapeGenerator;
    this.colourGenerator = _colourGenerator;
    this.oceanShapeGenerator = _oceanShapeGenerator;
    this.mesh = _mesh;
    this.resolution = _resolution;
    this.localUp = _localUp;

    this.axisA = new vector3d(this.localUp.y, this.localUp.z, this.localUp.x);
    this.axisB = crossProduct(this.localUp, this.axisA);
  }

  public void ConstructMesh() {
    vector3d[] vertices = new vector3d[(int)sq(this.resolution)]; 
    int[] triangles = new int[(this.resolution-1) * (resolution-1) * 4];

    Material[] materials = new Material[(this.resolution-1) * (resolution-1)];
    int triIndex = 0;
    int colIndex = 0;

    for (int y = 0; y < this.resolution; y++) {
      for (int x = 0; x < this.resolution; x++) {
        int i = x + (y * resolution);
        vector2d percent = new vector2d(x, y).mult(1 / ((float)this.resolution-1));

        vector3d a = axisA.clone().mult((percent.x - 0.5) * 2);
        vector3d b = axisB.clone().mult((percent.y - 0.5) * 2);
        vector3d pointOnUnitCube = localUp.clone().add(a).add(b);
        vector3d pointOnUnitSphere = pointOnUnitCube.clone().normalize();

        float elevation = 0;
        vector3d p;

        if (this.shapeGenerator != null) {

          elevation = this.shapeGenerator.calculateElevation(pointOnUnitSphere);

          vertices[i] = pointOnUnitSphere.mult(this.shapeGenerator.shapeSettings.planetRadius * elevation);
        } else {
          vertices[i] = this.oceanShapeGenerator.CalculatePointOnUnitSphere(pointOnUnitSphere);
        }

        if (x != resolution-1 && y != resolution-1) {
          triangles[triIndex] = i;
          triangles[triIndex+1] = i + resolution;
          triangles[triIndex+2] = i + resolution + 1;
          triangles[triIndex+3] = i + 1;

          triIndex += 4;
          Material mat;
          if (this.shapeGenerator != null) {
            mat = this.colourGenerator.EvaluateLandColour(vertices[i], elevation);
          } else {
            mat = this.colourGenerator.EvaluateOceanColour(vertices[i], elevation);
          }
          materials[colIndex] = mat;
          colIndex+=1;
        }
      }
    }

    mesh.clear();
    mesh.vertices = vertices;
    mesh.materials = materials;
    mesh.triangles = triangles;
  }
}

public class ShapeGenerator {

  ShapeSettings shapeSettings;
  NoiseFilter noiseFilter;

  ShapeGenerator(ShapeSettings _shapeSettings) {
    this.shapeSettings = _shapeSettings;
    this.noiseFilter = new NoiseFilter(this.shapeSettings.noiseSettings, this.shapeSettings);
  }

  public float calculateElevation(vector3d pointOnUnitSphere) {
    return this.noiseFilter.Evaluate(pointOnUnitSphere);
  }
}

public class ColourGenerator {

  ColourSettings colourSettings;

  ColourGenerator(ColourSettings _colourSettings) {
    this.colourSettings = _colourSettings;
  }

  public Material EvaluateLandColour(vector3d point, float elevation) {
    if (point.y >= colourSettings.poleHeight || point.y <= -colourSettings.poleHeight) {
      return this.colourSettings.poleMaterial;
    }

    if (elevation < colourSettings.planetLowHeight) {
      return this.colourSettings.planetLowMaterial;
    }
    if (elevation > colourSettings.planetHighHeight) {
      return this.colourSettings.planetHighMaterial;
    }

    return this.colourSettings.planetMaterial;
  }

  public Material EvaluateOceanColour(vector3d point, float elevation) {
    return this.colourSettings.oceanMaterial;
  }
}

public class OceanShapeGenerator {

  OceanSettings oceanSettings;

  OceanShapeGenerator(OceanSettings _oceanSettings) {
    this.oceanSettings = _oceanSettings;
  }

  public vector3d CalculatePointOnUnitSphere(vector3d pointOnUnitSphere) {
    float elevation = this.Evaluate(pointOnUnitSphere);
    return pointOnUnitSphere.mult(this.oceanSettings.oceanRadius * elevation);
  }

  public float Evaluate(vector3d point) {
    point = point.clone().mult(this.oceanSettings.roughness);
    float v = noise(point.x+1000, point.y+1000, point.z+1000+this.oceanSettings.time);
    return 1+(v*oceanSettings.strength);
  }
}


public class NoiseFilter {
  NoiseSettings noiseSettings;
  ShapeSettings shapeSettings;

  NoiseFilter(NoiseSettings _noiseSettings, ShapeSettings _shapeSettings) {
    this.noiseSettings = _noiseSettings;
    this.shapeSettings = _shapeSettings;
  }

  public float Evaluate(vector3d point) {
    float noiseValue = 0;
    float frequency = this.noiseSettings.baseRoughness;
    float amplitude = 1;

    vector3d basePoint = point.clone();

    for (int i = 0; i < this.noiseSettings.numLayers; i++) {
      point = basePoint.clone().mult(this.noiseSettings.roughness).mult(frequency);
      float v = noise(point.x+1000, point.y+1000, point.z+1000+this.noiseSettings.seed);
      if (i==0) {
        v += abs(point.y)*this.noiseSettings.poleStrength;
      }
      noiseValue += v * amplitude;
      frequency *= this.noiseSettings.roughness;
      amplitude *= this.noiseSettings.persistance;
    }


    return 1+(noiseValue * this.noiseSettings.strength);
  }
}

public class ShapeSettings {
  public float planetRadius = 100;
  public int resolution = 10;
  public NoiseSettings noiseSettings;

  ShapeSettings(NoiseSettings _noiseSettings) {
    this.noiseSettings = _noiseSettings;
  }
}

public class ColourSettings {
  public Material planetMaterial = new Material();
  public Material oceanMaterial = new Material();
  public Material poleMaterial = new Material();
  public float poleHeight = 50;

  public Material planetLowMaterial = new Material();
  public float planetLowHeight = 1.25;

  public Material planetHighMaterial = new Material();
  public float planetHighHeight = 1.75;
}

public class NoiseSettings {
  public float strength = 1;
  public int numLayers = 1;
  public float baseRoughness = 1;
  public float roughness = 2;
  public float persistance = 0.5;
  public float poleStrength = 0;
  public float seed = random(100000);
}

public class OceanSettings {
  public float oceanRadius = 125;
  public float strength = 1;
  public float roughness = 2;
  public float time = 0;
  public float timeRate = 0.01;
}
