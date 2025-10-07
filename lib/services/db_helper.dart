import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static Database? _db;
  static final DbHelper instance = DbHelper._constructor();

  final String _expenseTableName = "expense";
  final String _expenseIdColumnName = "id";
  final String _expenseTitleColumnName = "title";
  final String _expenseAmountColumnName = "amount";
  final String _expenseDateColumnName = "date";
  final String _expenseCategoryColumnName = "category";

  DbHelper._constructor();

  Future<Database> get database async {
    if (_db == null) throw Exception("Call initDatabase");
    return _db!;
  }

  Future<Database> initDatabase() async {
    print("Init DB");
    if (_db != null) return _db!;
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "expense_db.db");
    _db = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) {
        print("Current Version $version");
        db.execute('''
      CREATE TABLE $_expenseTableName(
        $_expenseIdColumnName  INTEGER PRIMARY KEY AUTOINCREMENT,
        $_expenseTitleColumnName TEXT NOT NULL,
        $_expenseAmountColumnName REAL NOT NULL,
        $_expenseDateColumnName TEXT NOT NULL,
        $_expenseCategoryColumnName  TEXT NOT NULL
      )
    ''');
      },
    );
    return _db!;
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
