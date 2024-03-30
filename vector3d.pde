//vector class for math and ease

public class vector3d {
  //static variables
  

  //init variables
  public float x;
  public float y;
  public float z;

  //init functions with various parameters
  public vector3d(float _x, float _y, float _z) {
    this.x = _x;
    this.y = _y;
    this.z = _z;
  }

  public vector3d() {
    this.x = 0;
    this.y = 0;
    this.z = 0;
  }


  //add with a vector
  public vector3d add(vector3d _v) {
    this.x += _v.x;
    this.y += _v.y;
    this.z += _v.z;
    return this;
  }

  //add with to floats
  public vector3d add(float _x, float _y, float _z) {
    this.x += _x;
    this.y += _y;
    this.z += _z;
    return this;
  }

  //remove (minus) with a vector
  public vector3d remove(vector3d _v) {
    this.x -= _v.x;
    this.y -= _v.y;
    this.z -= _v.z;
    return this;
  }

  //remove (minus) with two floats
  public vector3d remove(float _x, float _y, float _z) {
    this.x -= _x;
    this.y -= _y;
    this.z -= _z;
    return this;
  }

  //multiply X and Y values by one float
  public vector3d mult(float multiplier) {
    this.x = this.x*multiplier;
    this.y = this.y*multiplier;
    this.z = this.z*multiplier;
    return this;
  }
  //multiply X and Y by seperate float
  public vector3d mult(float multiplierX, float multiplierY, float multiplierZ) {
    this.x = this.x*multiplierX;
    this.y = this.y*multiplierY;
    this.z = this.z*multiplierZ;
    return this;
  }
  //multiple X and Y by seperate valuse from another vector
  public vector3d mult(vector3d multiplier) {
    this.x = this.x*multiplier.x;
    this.y = this.y*multiplier.y;
    this.z = this.z*multiplier.z;
    return this;
  }

  //get the normalised vector
  public vector3d normalize() {
    this.mult(1 / this.mag());
    return this;
  }

  //get the magnitude of the vector
  public float mag() {
    float mag = sqrt(sq(this.x)+sq(this.y)+sq(this.z));
    if (Float.isNaN(mag)) {
      mag = 0;
    }
    return(mag);
  }

  //clears the vector to {0,0}
  public vector3d clear() {
    this.x=0;
    this.y=0;
    this.z=0;
    return this;
  }

  //gets the distance to another vector
  public float dist(vector3d other) {
    float a = (this.x-other.x);
    float b = (this.y-other.y);
    float c = (this.z-other.z);

    float d = sq(a)+sq(b)+sq(c);

    return sqrt(d);
  }

  //clones the vector as to not effect the actual object
  public vector3d clone() {
    return new vector3d(this.x, this.y, this.z);
  }

  //gets a new vector point from this object to another vector
  public vector3d vectorTo(vector3d other) {
    return new vector3d(other.x-this.x, other.y-this.y, other.z-this.z);
  }

  //gets a new vector pointing from thi object to another vector but its normalised
  public vector3d dirTo(vector3d other) {
    return new vector3d(other.x-this.x, other.y-this.y, other.z-this.z).normalize();
  }

  //gets the angle of the vector in 3 dimentions??
  //public float toAngle() {
  //  float rad = atan2(this.x, this.y);
  //  float angle = rad * 180/PI;
  //  return angle;
  //}

}

 public vector3d crossProduct(vector3d a, vector3d b) {
    vector3d c = new vector3d();
    c.x = a.y*b.z - a.z*b.y;
    c.y = a.z*b.x - a.x*b.z;
    c.z = a.x*b.y - a.y*b.x;

    return c;
  }

//the dot product of two vectors
public float dot3d(vector3d a, vector3d b, vector3d c) {
  return 0;//(a.x * b.x) + (a.y * b.y); can't be bothered rn
}
