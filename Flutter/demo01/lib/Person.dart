class Person {
  String name = "张三";

  int age = 23;
  void getInfo() {
    // print("$name 是 $age");
    print("${this.name} -- $age");
  }
}
