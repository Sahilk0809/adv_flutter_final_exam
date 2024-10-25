import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static DatabaseHelper databaseHelper = DatabaseHelper._();

  Database? _database;
  String databaseName = 'expense.db';
  String tableName = 'expense';

  Future<Database> get database async => _database ?? await initDatabase();

  Future<Database> initDatabase() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, databaseName);
    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        String sql = '''
        CREATE TABLE $tableName (
          id INTEGER NOT NULL,
          title TEXT NOT NULL,
          amount TEXT NOT NULL,
          date TEXT NOT NULL,
          category TEXT NOT NULL
        )
        ''';
        db.execute(sql);
      },
    );
  }

  Future<bool> expenseExist(int id) async {
    final db = await database;
    String sql = '''
    SELECT * FROM $tableName WHERE id = ?
    ''';
    List<Map<String, Object?>> result = await db.rawQuery(sql, [id]);
    return result.isNotEmpty;
  }

  Future<int> addExpenseToDatabase(
      int id, String title, String date, String amount, String category) async {
    final db = await database;
    String sql = '''
    INSERT INTO $tableName(
    id, title, amount, date, category
    ) VALUES (?, ?, ?, ?, ?)
    ''';
    List args = [id, title, amount, date, category];
    return await db.rawInsert(sql, args);
  }

  Future<List<Map<String, Object?>>> readAllExpense() async {
    final db = await database;
    String sql = '''
    SELECT * FROM $tableName
    ''';
    return await db.rawQuery(sql);
  }

  Future<List<Map<String, Object?>>> getExpenseByCategory(String category) async {
    final db = await database;
    String sql = '''
    SELECT * FROM $tableName WHERE category LIKE '%$category%'
    ''';
    return await db.rawQuery(sql);
  }

  Future<int> updateExpense(int id, String title, String amount, String date,
      String category) async {
    final db = await database;
    String sql = '''
    UPDATE $tableName SET title = ?, amount = ?, date = ?, category = ? WHERE id = ?
    ''';
    List args = [title, amount, date, category, id];
    return await db.rawUpdate(sql, args);
  }

  Future<int> deleteExpense(int id) async {
    final db = await database;
    String sql = '''
    DELETE FROM $tableName WHERE id = ?
    ''';
    List args = [id];
    return await db.rawDelete(sql, args);
  }
}
