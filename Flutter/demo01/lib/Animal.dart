class Animal {
  String name = "";
  int age = 0;

  Animal(this.name,this.age);

  void getInfo() {
    // print("$name 是 $age");
    print("${this.name} -- $age");
  }
}