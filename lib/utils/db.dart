import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static final DatabaseHelper db = DatabaseHelper._();

  static Database? _database;

  // Update the database version
  static const int _dbVersion = 2;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDatabase();
    return _database;
  }

  Future<Database> initDatabase() async {
    final path = join(await getDatabasesPath(), 'app_data.db');
    return await openDatabase(
        path,
        version: _dbVersion,
        onCreate: _createDb,
        onUpgrade: _upgradeDb
    );
  }

  // Creating tables during initial database creation
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

    // Creating settings table
    await db.execute('''
      CREATE TABLE settings(
        key TEXT PRIMARY KEY,
        value TEXT
      )
    ''');
  }

  // Database upgrade logic for migrations
  void _upgradeDb(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Add the settings table in version 2
      await db.execute('''
        CREATE TABLE settings(
          key TEXT PRIMARY KEY,
          value TEXT
        )
      ''');
    }
    // Future migrations can be added here
    // e.g., if (oldVersion < 3) { ... }
  }

  // User management methods
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

  // Settings management methods
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
