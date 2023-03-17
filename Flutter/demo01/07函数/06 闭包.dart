void main(List<String> args) {
  //闭包

  // 全局变量：常驻内存
  // 局部变量：

  fn() {
    var a = 123;
    return () {
      a++;
      print(a);
    };
  }

  var f = fn();

  f();
  f();

  // fn();
  // fn();
}
