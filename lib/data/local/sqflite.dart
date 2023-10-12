import 'package:path/path.dart';
import 'package:shop_helper/data/model/product_model.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  static final LocalDatabase getInstance = LocalDatabase._init();
  static String dataPath = '';

  LocalDatabase._init();

  factory LocalDatabase() {
    return getInstance;
  }

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDB("products.db");
      return _database!;
    }
  }

  Future<Database> _initDB(String dbName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    dataPath = path;
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const textType = "TEXT NOT NULL";

    await db.execute('''
    CREATE TABLE ${ProductModelFields.dbTable} (
    ${ProductModelFields.id} $idType,
    ${ProductModelFields.name} $textType,
    ${ProductModelFields.count} $textType,
    ${ProductModelFields.barcode} $textType
    )
    ''');
  }

  static Future<ProductModel> insertProduct(ProductModel studentModel) async {
    final db = await getInstance.database;
    final int id =
        await db.insert(ProductModelFields.dbTable, studentModel.toJson());
    return studentModel.copyWith(id: id);
  }

  static Future<List<ProductModel>> getAllProducts() async {
    List<ProductModel> allProducts = [];
    final db = await getInstance.database;
    allProducts = (await db.query(ProductModelFields.dbTable))
        .map((e) => ProductModel.fromJson(e))
        .toList();
    return allProducts;
  }

  static updateProduct({required String barcode, required String count}) async {
    final db = await getInstance.database;
    db.update(
      ProductModelFields.count,
      {ProductModelFields.count: count},
      where: "${ProductModelFields.barcode} = ?",
      whereArgs: [barcode],
    );
  }

  static deleteProduct(int id) async {
    final db = await getInstance.database;
    db.delete(
      ProductModelFields.dbTable,
      where: "${ProductModelFields.id} = ?",
      whereArgs: [id],
    );
  }

 static Future<bool> checkValueExists(String value) async {
   final db = await getInstance.database;

    final result = await db.query(
      ProductModelFields.dbTable,
      where: '${ProductModelFields.barcode} = ?',
      whereArgs: [value],
    );
    return result.isNotEmpty;
  }
}
