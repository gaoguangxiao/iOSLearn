//null

//? !

//late

// require 必须传递的值

//const 常量，编译时确定、可节省内存，组件不会重新构建
//final 运行时确定，声明之后赋值

// identical 两个实例指向同一块空间
class Person {
  late String name;//允许late 延迟赋值，不得为空
  late int age;

  void setName(String name, int age) {
    this.name = name;
    this.age = age;
  }

  String getName() {
    return "$name-----$age";
  }
}

void main(List<String> args) {
  Person p = Person();

  p.setName("张三", 12);

  print(p.getName());

  // identical(a, b) 检测是否指向同一块内存
}
