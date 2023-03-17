class A {
  void printA() {}
}

class B {
  printB() {}
}

class C implements A, B {
  @override
  printA() {
    // TODO: implement printA
    print("打印A");
  }

  @override
  printB() {
    // TODO: implement printB
    print("打打B");
  }
}

class D with A, B {}

/**
 * 
 * 可以实现多个接口
*/
void main(List<String> args) {
  C c = C();
  c.printA();
  c.printB();
}
