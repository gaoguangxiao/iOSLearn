void main(List<String> args) {
  var s = getData(12);
  print(s);

  var s1 = getData("ggx");
  print(s1);
}

T getData<T>(T value) {
  return value;
}
//方法不指定类型