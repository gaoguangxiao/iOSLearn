import 'dart:mirrors';

import 'package:test/test.dart';

void main(List<String> args) {
  var l1 = ["苹果", "香蕉", "西瓜"];

  for (var element in l1) {
    print(element);
  }

//箭头函数
  l1.forEach((element) => prints(element));
  l1.forEach((element) => {prints(element)});

  // test1();

  test2();
}

//修改list里面数据 大于2的乘以2
void test1() {
  var list = [1, 2, 3, 4];
  // list.forEach((value) => print(value));

  var newList = list.map((value) => value > 2 ? value * 2 : value);
  print(newList);
}

void test2() {
  int n = 13;
  var list = [];
  int count = 1;
  // O(n)复杂度
  while (count < n) {
    // print(count);
    if (isEvenNumber(count)) {
      list.add(count);
    }
    count++;
  }
  print(list);
}

//打印1~n之间所有的偶数
bool isEvenNumber(int num) {
  return num % 2 == 0;
}
