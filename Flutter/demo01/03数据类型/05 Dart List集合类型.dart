void main(List<String> args) {
  // var a = 10;
  // print(a);
  // test1();
  // test2();

  test3();
  //
  // var l1 = [];
  // l1.isEmpty
  // l1.isNotEmpty
  // l1.add(value
  // l1.addAll(iterable
  // l1.reversed
}

void test1() {
  var l1 = ["张三", "10", "12"];
  
  // print(l1);
  // print("长度" + l1.length.toString());
  // print("长度"  + "$l1");
  l1.add("李四");

  var s = l1.reversed.toList(); //翻转 转换为数组吧吧
  print(s);

// var l1 = <String>["香蕉","苹果"];///指定数据类型

  // print(l1);
}

void test2() {
  //创建一个固定长度的数组
  var l3 = List.filled(2, "");
  l3[1] = "澄澄";
  // l3.add("澄澄");
  print(l3);
}

void test3() {
  // var l1 = new List();
  // l1.add("橘子");
  // print(l1);
}
