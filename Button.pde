class Button {
  float x, y, w, h;

  Boolean CanInteract = true;

  Button(float px, float py, float pw, float ph) {
    x = px;
    y = py;
    w = pw;
    h = ph;
  }

  void display(String label) {
    pushMatrix();
    textSize(16);
    if (CanInteract) {
      fill(#F5EBFF);
      stroke(#E3D4F9);
    } else {
      fill(#A9A3AF);
      stroke(#9F94B2);
    }
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
