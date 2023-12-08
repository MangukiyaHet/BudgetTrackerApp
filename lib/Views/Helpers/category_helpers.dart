import 'package:budget_tracker_app_af_6/Model/category_data_model.dart';
import 'package:budget_tracker_app_af_6/Model/spending_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:core';

class Category_Helper {
  //create private constructor
  Category_Helper._();
  static Database? db;

  static final Category_Helper category_helper = Category_Helper._();
  Future initDb() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'mybudget.db');

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, _) async {
        String Category_query =
            "CREATE TABLE IF NOT EXISTS budget(id INTEGER PRIMARY KEY AUTOINCREMENT,category_name TEXT not null,category_image BLOB);";
        String spending_query =
            "CREATE TABLE IF NOT EXISTS spending_components(spending_id INTEGER PRIMARY KEY AUTOINCREMENT,spending_name TEXT NOT NULL,spending_amount TEXT NOT NULL,spending_mode TEXT NOT NULL,spending_type TEXT NOT NULL,s_time TEXT,s_date TEXT NOT NULL);";
        await db.execute(Category_query);
        await db.execute(spending_query);
      },
    );
  }

  Future<int> insertData({required CategoryModel data}) async {
    await initDb();
    String query =
        "INSERT INTO budget(category_name,category_image) VALUES(?,?);";
    List args = [data.category_name, data.category_image];
    return db!.rawInsert(query, args);
  }

  Future<List<CategoryModel>> fetchAllData() async {
    await initDb();
    String query = "SELECT * FROM budget;";
    List<Map<String, dynamic>>? responce = await db?.rawQuery(query);

    List<CategoryModel> Alldata =
        await responce!.map((e) => CategoryModel.fromSQL(data: e)).toList();
    return Alldata;
  }

  Future<int?> UpdateAllData({required String data, required int id}) async {
    await initDb();
    String query = "UPDATE budget SET category_name=? WHERE id=?;";
    List args = [data, id];
    int? res = await db?.rawUpdate(query, args);
    return res;
  }

  Future<int?> DeleteAllData({required int id}) async {
    await initDb();
    String query = "DELETE FROM budget WHERE id=?;";
    List args = [id];
    int? res = await db?.rawDelete(query, args);
    return res;
  }

  Future<List<CategoryModel>> FetchSearchedData({required String data}) async {
    await initDb();
    String query = "SELECT * FROM budget WHERE category_name LIKE '%$data%';";
    List<Map<String, dynamic>>? responce = await db?.rawQuery(query);
    List<CategoryModel> allData =
        await responce!.map((e) => CategoryModel.fromSQL(data: e)).toList();
    return allData;
  }

  Future<int> insertSpending({required SpendingModel data}) async {
    await initDb();
    String query =
        "INSERT INTO spending_components(spending_name,spending_amount,spending_mode,spending_type,s_time,s_date) VALUES(?,?,?,?,?,?);";
    List args = [
      data.s_name,
      data.s_amount,
      data.s_mode,
      data.s_type,
      data.time,
      data.date
    ];
    return db!.rawInsert(query, args);
  }

  Future<List<SpendingModel>> fetchSpendingData() async {
    await initDb();
    String query = "SELECT * FROM spending_components;";
    List<Map<String, dynamic>>? responce = await db?.rawQuery(query);

    List<SpendingModel> Alldata =
        await responce!.map((e) => SpendingModel.fromSQL(data: e)).toList();
    return Alldata;
  }

  Future<int?> DeleteSpendingData({required int id}) async {
    await initDb();
    String query = "DELETE FROM spending_components WHERE spending_id=?;";
    List args = [id];
    int? res = await db?.rawDelete(query, args);
    return res;
  }
  //CREATE TABLE IF NOT EXISTS spending_components(spending_id INTEGER PRIMARY KEY AUTOINCREMENT,
// spending_name TEXT NOT NULL,spending_amount TEXT NOT NULL,
// spending_mode TEXT NOT NULL,spending_type TEXT NOT NULL,s_time TEXT,
// s_date TEXT NOT NULL);
}
