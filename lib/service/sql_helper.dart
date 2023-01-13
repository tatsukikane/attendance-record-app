import 'package:attendance_record_app/models/attendace_recoard.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;

//todo 時間用にカスタマイズする
class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE items(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      totalTime INTEGER,
      startedAt TIMESTAMP,
      endedAt TIMESTAMP)
    """);
  }

  //openDatabaseの第一引数がDB作成場所のpathになるので、そこは引数で入れるようにする
  static Future<sql.Database> db() async {
    return sql.openDatabase('attendace_record.db', version: 1,
        onCreate: (sql.Database database, int verson) async {
      await createTables(database);
    });
  }

  static Future<int> createItem(String title, String? description) async {
    final db = await SQLHelper.db();
    final List<AttendaceRecoard> existingDataCount = await getItems();

    final fetchedRecord = {
      'id': existingDataCount.length + 1,
      'totalTime': title,
      'startedAt': DateTime.now().toString()
    };

    final id = await db.insert('items', fetchedRecord,
        //コンフリクト発生時の処理オプション
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<AttendaceRecoard>> getItems() async {
    final db = await SQLHelper.db();
    final List<Map<String, dynamic>> fetchedRecord =
        await db.query('items', orderBy: "id");

    return List.generate(fetchedRecord.length, (i) {
      return AttendaceRecoard(
        id: fetchedRecord[i]['id'],
        totalTime: fetchedRecord[i]['totalTime'],
        startedAt: DateTime.parse(fetchedRecord[i]['startedAt']),
        endedAt: DateTime.parse(fetchedRecord[i]['endedAt']),
      );
    });
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelper.db();
    return db.query('items', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateItem(int id, String totalTime) async {
    final db = await SQLHelper.db();

    final fetchedRecord = {
      'totalTime': totalTime,
      'endedAt': DateTime.now().toString(),
    };

    final result = await db
        .update('items', fetchedRecord, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();

    try {
      await db.delete("items", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
