//vector class for math and ease
class vector2d {
  //init variables
  public float x;
  public float y;

  //init functions with various parameters
  public vector2d(float _x, float _y) {
    this.x = _x;
    this.y = _y;
  }

  public vector2d() {
    this.x = 0;
    this.y = 0;
  }

  public vector2d(float theta) {
    float rad = theta*PI/180;
    this.x = sin(rad);
    this.y = cos(rad);
  }

  //add with a vector
  public vector2d add(vector2d _v) {
    this.x += _v.x;
    this.y += _v.y;
    return this;
  }

  //add with to floats
  public vector2d add(float _x, float _y) {
    this.x += _x;
    this.y += _y;
    return this;
  }

  //remove (minus) with a vector
  public vector2d remove(vector2d _v) {
    this.x -= _v.x;
    this.y -= _v.y;
    return this;
  }

  //remove (minus) with two floats
  public vector2d remove(float _x, float _y) {
    this.x -= _x;
    this.y -= _y;
    return this;
  }

  //multiply X and Y values by one float
  public vector2d mult(float multiplier) {
    this.x = this.x*multiplier;
    this.y = this.y*multiplier;
    return this;
  }
  //multiply X and Y by seperate float
  public vector2d mult(float multiplierX, float multiplierY) {
    this.x = this.x*multiplierX;
    this.y = this.y*multiplierY;
    return this;
  }
  //multiple X and Y by seperate valuse from another vector
  public vector2d mult(vector2d multiplier) {
    this.x = this.x*multiplier.x;
    this.y = this.y*multiplier.y;
    return this;
  }

  //get the normalised vector
  public vector2d normalize() {
    this.mult(1 / this.mag());
    return this;
  }

  //get the magnitude of the vector
  public float mag() {
    float mag = sqrt((this.x*this.x)+(this.y*this.y));
    if (Float.isNaN(mag)) {
      mag = 0;
    }
    return(mag);
  }

  //clears the vector to {0,0}
  public vector2d clear() {
    this.x=0;
    this.y=0;
    return this;
  }

  //gets the distance to another vector
  public float dist(vector2d other) {
    float a = (this.x-other.x);
    float b = (this.y-other.y);

    float c = (a*a)+(b*b);

    return sqrt(c);
  }

  //clones the vector as to not effect the actual object
  public vector2d clone() {
    return new vector2d(this.x, this.y);
  }

  //gets a new vector point from this object to another vector
  public vector2d vectorTo(vector2d other) {
    return new vector2d(other.x-this.x, other.y-this.y);
  }

  //gets a new vector pointing from thi object to another vector but its normalised
  public vector2d dirTo(vector2d other) {
    return new vector2d(other.x-this.x, other.y-this.y).normalize();
  }
  
  //gets the angle of the vector
  public float toAngle(){
    float rad = atan2(this.x,this.y);
    float angle = rad * 180/PI;
    return angle;
  }
}

//the dot product of two vectors
public float dot(vector2d a, vector2d b){
  return (a.x * b.x) + (a.y * b.y);
}
