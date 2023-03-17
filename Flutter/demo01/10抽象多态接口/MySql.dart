import './Db.dart';

class MySql implements Db {
  @override
  late String url;

  MySql(this.url);

  @override
  delete() {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  save() {
    // TODO: implement save
    throw UnimplementedError();
  }

  @override
  add(String value) {
    print("这是MySql的添加方法");
  }
}
