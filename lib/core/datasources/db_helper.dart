
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' ;
import 'dart:async';

class DBHelper {
  static Database? _database;

  Future<Database> get database async{
    if(_database !=null) return _database!;
    _database = await initDatabase();
    return _database!;
  }
  
  Future<Database> initDatabase() async{
     String path = join(await getDatabasesPath(), 'auth.db');
    return await openDatabase(path, version: 1, onCreate: (db, version) {
      db.execute(
        'CREATE TABLE users(id INTEGER PRIMARY KEY, username TEXT, password TEXT)',
      );
    });
  }
   // Insert new user
  Future<void> insertUser(String username, String password) async {
    final db = await database;
    await db.insert('users', {'username': username, 'password': password});
  }

  // Get user by username and password
  Future<Map<String, dynamic>?> getUser(String username, String password) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }
}