// 定义一个抽象类db
abstract class Db {
  late String url;

  add(String value);

  save();

  delete();
}
