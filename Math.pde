public vector2d[] isLineCollidingSphere(vector2d p1, vector2d p2, vector2d c, float r) {
  //p1 is the first line point
  //p2 is the second line point
  //c is the circle's center
  //r is the circle's radius

  vector2d p3 = new vector2d(p1.x - c.x, p1.y - c.y); //shifted line points
  vector2d p4 = new vector2d(p2.x - c.x, p2.y - c.y);

  float m = (p4.y - p3.y) / (p4.x - p3.x); //slope of the line
  float b = p3.y - m * p3.x; //y-intercept of line

  double underRadical = (r*r)*(m*m) + (r*r) - (b*b); //the value under the square root sign 


  if (underRadical < 0) {
    //line completely missed
    return null;
  } else {
    vector2d nearestPoint;
    //get closest point
    vector2d A = p1.clone();
    vector2d B = p2.clone();
    vector2d P = c.clone();

    vector2d AP = new vector2d(P.x - A.x, P.y - A.y);       //Vector from A to P   
    vector2d AB = new vector2d(B.x - A.x, B.y - A.y);       //Vector from A to B  
    float magnitudeAB = AB.mag()*AB.mag();//AB.x*AB.x + AB.y*AB.y;     //Magnitude of AB vector (it's length squared)     
    float ABAPproduct = ((AB.x * AP.x) + (AB.y * AP.y));    //The DOT product of a_to_p and a_to_b     
    float distance = ABAPproduct / magnitudeAB; //The normalized "distance" from a to your closest point  

    nearestPoint = A.add(AB.mult(distance));
    if (distance > 1 || distance < 0) {
      return null;
    } else {
      double t1 = (-m*b + Math.sqrt(underRadical))/(Math.pow(m, 2) + 1); //one of the intercept x's
      double t2 = (-m*b - Math.sqrt(underRadical))/(Math.pow(m, 2) + 1); //other intercept's x

      vector2d i1 = new vector2d((float)(t1+c.x), (float)(m*t1+b+c.y)); //intercept point 1
      vector2d i2 = new vector2d((float)(t2+c.x), (float)(m*t2+b+c.y)); //intercept point 2
      vector2d a = p3.vectorTo(p4);
      vector2d normal = new vector2d(a.y, a.x*-1).normalize();

      return new vector2d[] {i1, i2, normal, nearestPoint};
    }
  }
}

public boolean sphereColliding(vector2d op, float or, vector2d tp, float tr) {
    if (op.dist(tp)-(or+tr) <= 0) {
      return true;
    }
    return false;
  }
