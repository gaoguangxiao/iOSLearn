import './MssSql.dart';
import './MySql.dart';

//mysql msssql mongdb


void main(List<String> args) {
  
  MySql mysql = MySql("12133");
  mysql.add("mysql");

  MssSql mssql = MssSql("adada");
  mssql.add("mssql");
  
}