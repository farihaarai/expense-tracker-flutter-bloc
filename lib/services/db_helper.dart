import 'package:expense_tracker_bloc/services/db_migrations.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static Database? _db;
  static final bool _resetDB = true;
  static final String _dbName = "expense_db.db";
  static const int _currentVersion = 3;
  static final DbHelper instance = DbHelper._constructor();

  final String _expenseTableName = "expense";
  // final String _expenseIdColumnName = "id";
  // final String _expenseTitleColumnName = "title";
  // final String _expenseAmountColumnName = "amount";
  // final String _expenseDateColumnName = "date";
  // final String _expenseCategoryColumnName = "category";

  DbHelper._constructor();

  Future<Database> get database async {
    if (_db == null) throw Exception("Call initDatabase");
    return _db!;
  }

  Future<Database> initDatabase() async {
    print("Init DB");
    if (_db != null) return _db!;
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, _dbName);
    if (_resetDB) {
      await deleteDatabase(databasePath);
    }
    _db = await openDatabase(
      databasePath,
      version: _currentVersion,
      onCreate: _onCreate,
      //   (db, version) async {
      //     print("Current Version $version");

      //     // version 1
      //     await db.execute('''
      //   CREATE TABLE $_expenseTableName(
      //     $_expenseIdColumnName  INTEGER PRIMARY KEY AUTOINCREMENT,
      //     $_expenseTitleColumnName TEXT NOT NULL,
      //     $_expenseAmountColumnName REAL NOT NULL,
      //     $_expenseDateColumnName TEXT NOT NULL,
      //     $_expenseCategoryColumnName  TEXT NOT NULL
      //   )
      // ''');
      //   },
      onUpgrade: _onUpgrade,
      // (db, oldVersion, newVersion) async {
      //   print("upgrading database from $oldVersion to $newVersion");

      //   // version 2
      //   if (oldVersion < 2) {
      //     await db.execute('''
      //     ALTER TABLE expense ADD COLUMN note TEXT
      //     ''');
      //     print("Added 'note' column in version 2");
      //   }
      // },
    );
    return _db!;
  }

  Future<void> _onCreate(Database db, int version) async {
    print('Creating DB up to version $version');
    for (int v = 1; v <= version; v++) {
      final migration = DbMigrations.migrations[v];
      if (migration != null) {
        await migration(db);
      }
    }
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print('Upgrading DB from $oldVersion → $newVersion');
    for (int v = oldVersion + 1; v <= newVersion; v++) {
      final migration = DbMigrations.migrations[v];
      if (migration != null) {
        await migration(db);
      }
    }
  }

  Future<int> insertExpense(Map<String, dynamic> expense) async {
    final db = await database;
    return await db.insert(
      _expenseTableName,
      expense,
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<List<Map<String, dynamic>>> getAllExpenses() async {
    final db = await database;
    return await db.query(_expenseTableName, orderBy: 'date DESC');
  }

  Future<int> updateExpense(Map<String, dynamic> expense) async {
    final db = await database;
    return await db.update(
      _expenseTableName,
      expense,
      where: 'id = ?',
      whereArgs: [expense['id']],
    );
  }

  Future<int> deleteExpense(int id) async {
    final db = await database;
    return await db.delete(_expenseTableName, where: 'id=?', whereArgs: [id]);
  }
}
