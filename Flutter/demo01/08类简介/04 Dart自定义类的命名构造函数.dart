// ignore_for_file: file_names

import '03 Dart自定义类的默构造函数.dart';

class Animal {
  late String name;
  int age = 0;

  // Animal.now() {
  //   print("命名函数");
  // }

  void getInfo() {
    print("$name 是 $age");
    // print("${this.name} -- $age");
  }
}


void main(List<String> args) {
  Animal p = Animal();
  p.name = "张三";
  p.getInfo();

  // Animal a = Animal.now();
// a.getInfo();

  // print(p.getInfo());
}