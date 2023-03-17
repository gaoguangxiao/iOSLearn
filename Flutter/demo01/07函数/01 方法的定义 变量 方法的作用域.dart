void main(List<String> args) {
  print("Hello World");

  // var n = printUserInfo("ggx", 20);

  // var n = printUserInfo("name");

   var n = printUserInfo("ggx","男",12);
  print(n);
}

// String printUserInfo(String name, int age) {
//   return "名字： $name,年龄 $age";
// }


String printUserInfo(String name, [sex = "男",age]) {
  if (age == null) {
    return "名字：$name-性别：$sex 年龄保密";
  }
  return "名字：$name性别：$sex -年龄：$age";
}