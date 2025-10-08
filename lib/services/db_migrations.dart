import 'package:sqflite/sqflite.dart';

typedef MigrationScript = Future<void> Function(Database db);

class DbMigrations {
  static final Map<int, MigrationScript> migrations = {
    1: _createV1,
    2: _upgradeToV2,
    3: _upgradeToV3,
  };

  // Version 1
  static Future<void> _createV1(Database db) async {
    await db.execute('''
      CREATE TABLE expense(
        id  INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        amount REAL NOT NULL,
        date TEXT NOT NULL,
        category  TEXT NOT NULL
      )
    ''');
  }

  // Version 2
  static Future<void> _upgradeToV2(Database db) async {
    await db.execute('''
          ALTER TABLE expense ADD COLUMN note TEXT
          ''');
  }

  // Version 3
  static Future<void> _upgradeToV3(Database db) async {
    await db.execute('''
      CREATE TABLE user(
        name TEXT NOT NULL
      )
    ''');
  }
}
