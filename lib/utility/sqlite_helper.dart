import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLiteHelper {
  final String nameDatebase = 'treeshop.db';
  final String tableDatebase = 'orderTABLE';
  int varsion = 1;

  final String idColumn = 'id';
  final String idShopClumn = 'isShop';
  final String nameShop = 'nameShop';
  final String idTree = 'idTree';
  final String nameTree = 'nameTree';
  final String price = 'price';
  final String amount = 'amount';
  final String sum = 'sum';
  final String distance = 'transport';
  final String transport = 'transport';

  SQLiteHelper() {
    initDatabase();
  }

  Future<Null> initDatabase() async {
    await openDatabase(join(await getDatabasesPath(), nameDatebase),
        onCreate: (db, version) => db.execute(
            'CREATE TABLE $tableDatebase ($idColumn INTEGER PRIMARY KEY, $idShopClumn TEXT, $nameShop TEXT, $idTree TEXT, $nameTree TEXT, $price TEXT, $amount TEXT, $sum TEXT, $distance TEXT, $transport TEXT)'),
        version: varsion);
  }
}
