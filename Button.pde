class Button {
  float x, y, w, h;

  Button(float px, float py, float pw, float ph) {
    x = px;
    y = py;
    w = pw;
    h = ph;
  }

  void display(String label) {
    fill(200);
    rect(x, y, w, h);
    fill(0);
    textAlign(CENTER, CENTER);
    text(label, x + w / 2, y + h / 2);
  }

  boolean isClicked(float mx, float my) {
    return mx > x && mx < x + w && my > y && my < y + h;
  }
}
