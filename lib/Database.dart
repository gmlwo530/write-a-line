import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:write_a_line/model/LineModel.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null)
      return _database;

    _database = await initDB();
    return _database;
  }


  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "WriteLineDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {
    }, onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Line ("
          "id INTEGER PRIMARY KEY,"
          "content TEXT,"
          "created_at INTEGER"
          ")");
    });
  }

  newLine(Line line) async {
    final db = await database;
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Line");
    int id = table.first["id"];
    int nowToMillisecondsSinceEpoch = new DateTime.now().millisecondsSinceEpoch;
    var raw = await db.rawInsert(
        "INSERT Into Line (id,content,created_at)"
            " VALUES (?,?,?)",
        [id, line.content, nowToMillisecondsSinceEpoch]);

    return raw;
  }

  getLine(int id) async {
    final db = await database;
    var res = await db.query("Line", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Line.fromJson(res.first) : null ;
  }

  Future<List<Line>> getAllLines() async {
    final db = await database;
    var res = await db.rawQuery('SELECT * FROM Line');
    List<Line> list = res.isNotEmpty ? res.map((c) => Line.fromJson(c)).toList() : [];
    return list;
  }

  deleteLine(int id) async {
    final db = await database;
    db.delete("Line", where: "id = ?", whereArgs: [id]);
  }
}

