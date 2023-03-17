//定义抽象类
//
abstract class Animal {
  eat(); //抽象方法 约束子类
  run();

  printInfo() {
    print("我是一个抽象类里面的普通方法");
  }
}

class Dog extends Animal {
  @override
  eat() {
    print("狗吃骨头");
  }

  @override
  run() {
    print("狗在跑");
  }
}

class Cat extends Animal {
  @override
  eat() {
    print("猫吃鱼");
  }

  @override
  run() {
    print("猫在跑");
  }

  // @override
  // printInfo() {
  //  print("猫在跑");
  // }
}

void main(List<String> args) {
  // Dog d = Dog();
  // d.eat();
  // d.run();
  // d.printInfo();

  // Cat cat = Cat();
  // cat.eat();
  // cat.run();
  // cat.printInfo();

  Animal animal = Dog();
  animal.eat();

  Animal animalc = Cat();
  animalc.eat();
}
