import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class DBHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    print("_database :$_database");
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'auth.db');
    print("path for sqllite:$getDatabasesPath()");
    print("path for sqllite:$path");
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        print("Creating users table");
        await db.execute(
          'CREATE TABLE users(id INTEGER PRIMARY KEY, username TEXT, password TEXT)',
        );
        // Insert a test user
        await db.insert('users', {'username': 'test', 'password': 'pass'});
        print("Inserted test user: test/pass");
      },
      onOpen: (db) async {
        // Debug: Check existing users
        final users = await db.query('users');
        print("Current users in database: $users");
      },
    );
  }

  // Insert new user
  Future<void> insertUser(String username, String password) async {
    final db = await database;
    await db.insert('users', {'username': username, 'password': password});
    print("Inserted user: $username");
  }

  // Get user by username and password
  Future<Map<String, dynamic>?> getUser(String username, String password) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );
    print("Query result for $username/$password: $result");
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }
}