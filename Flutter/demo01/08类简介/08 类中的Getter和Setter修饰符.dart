
class Rect {
  
  var height = 0;
  var width = 0;

Rect(this.height,this.width);
//  get area(){
  //   return this.height * this.width;
  // }

  get area {
    return this.height * this.width;
  }
}

void main(List<String> args) {
  Rect r = Rect(20, 2);
  print("面积：${r.area}");
}