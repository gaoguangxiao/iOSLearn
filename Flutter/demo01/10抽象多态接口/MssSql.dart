// ignore: file_names
import './Db.dart';

class MssSql implements Db {
  @override
  late String url;

  MssSql(this.url);

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
    print("这是MssSql的添加方法");
  }
}
