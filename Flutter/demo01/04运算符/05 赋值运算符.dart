void main(List<String> args) {
  // =
  // ??= b??=20; b为为空

  var b;
  b ??= 34;
  var c = b ?? 20;

  print(c);
}
