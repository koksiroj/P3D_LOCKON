class Button {
  float x, y, w, h;

  Button(float px, float py, float pw, float ph) {
    x = px;
    y = py;
    w = pw;
    h = ph;
  }

  void display(String label) {
    pushMatrix();
    textSize(16);
    fill(#F5EBFF);
    stroke(#E3D4F9);
    strokeWeight(2);
    rect(x, y, w, h, 8);
    fill(0);
    noStroke();
    textAlign(CENTER, CENTER);
    text(label, x + w / 2, y + h / 2);
    popMatrix();
  }

  boolean isClicked(float mx, float my) {
    return mx > x && mx < x + w && my > y && my < y + h;
  }
}
