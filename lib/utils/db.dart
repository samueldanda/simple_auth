import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static final DatabaseHelper db = DatabaseHelper._();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDatabase();
    return _database;
  }

  Future<Database> initDatabase() async {
    final path = join(await getDatabasesPath(), 'app_data.db');
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  void _createDb(Database db, int version) async {
    if (kDebugMode) {
      print('CREATING TABLES');
    }

    await db.execute('''
      CREATE TABLE user(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        firstName TEXT,
        lastName TEXT,
        email TEXT,
        mobileNumber TEXT,
        password TEXT
      )
    ''');

    // New key-value table
    await db.execute('''
      CREATE TABLE settings(
        key TEXT PRIMARY KEY,
        value TEXT
      )
    ''');
  }

  Future<bool> insertUser(Map<String, dynamic> user) async {
    final db = await database;
    await db?.delete('user');
    var i = await db?.insert('user', user, conflictAlgorithm: ConflictAlgorithm.replace);
    return i != null && i > 0;
  }

  Future<Map<String, dynamic>?> getUser() async {
    final db = await database;
    final List<Map<String, Object?>>? maps = await db?.query('user');
    return maps!.isNotEmpty ? maps.first : null;
  }

  Future<Map<String, dynamic>?> authenticateUser(String identifier, String password) async {
    final db = await database;

    final List<Map<String, Object?>>? results = await db?.query(
      'user',
      where: '(email = ? OR mobileNumber = ?) AND password = ?',
      whereArgs: [identifier, identifier, password],
    );

    if (results!.isNotEmpty) {
      return results.first;
    }
    return null;
  }

  Future<void> saveKeyValue(String key, String value) async {
    final db = await database;
    await db?.insert(
      'settings',
      {'key': key, 'value': value},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<String?> getValueForKey(String key) async {
    final db = await database;
    final List<Map<String, Object?>>? maps = await db?.query(
      'settings',
      where: 'key = ?',
      whereArgs: [key],
    );
    if (maps!.isNotEmpty) {
      return maps.first['value'] as String?;
    }
    return null;
  }

  Future<void> deleteKey(String key) async {
    final db = await database;
    await db?.delete(
      'settings',
      where: 'key = ?',
      whereArgs: [key],
    );
  }
}
