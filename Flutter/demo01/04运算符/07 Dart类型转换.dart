import 'dart:ffi';

void main(List<String> args) {
  var str = "1221";

// 字符串转整型
  var a = int.parse(str);

  print(str);

  print(a is double);

  var list = str.split('');
  
  list.forEach((element) {
    print(element is String);
  });

  print(list);

  // try {

  // } catch (e) {

  // }
}
