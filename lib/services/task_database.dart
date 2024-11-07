import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/task.dart';

class TaskDatabase {
  static final TaskDatabase instance = TaskDatabase._init();
  static Database? _database;

  TaskDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('tasks.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 2, // Version number for database upgrades
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';

    await db.execute('''
      CREATE TABLE tasks (
        id $idType,
        title $textType,
        description $textType,
        startDateTime $textType,
        completionDateTime $textType,
        isCompleted $boolType
      )
    ''');
  }

  Future _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Adding new columns for start and completion date-time
      await db.execute('ALTER TABLE tasks ADD COLUMN startDateTime TEXT');
      await db.execute('ALTER TABLE tasks ADD COLUMN completionDateTime TEXT');
    }
  }

  Future<void> createTask(Task task) async {
    final db = await instance.database;
    try {
      await db.insert('tasks', task.toMap());
    } catch (e) {
      print('Error creating task: $e');
    }
  }

  Future<List<Task>> readAllTasks() async {
    final db = await instance.database;
    try {
      final result = await db.query('tasks');
      return result.map((map) => Task.fromMap(map)).toList();
    } catch (e) {
      print('Error reading tasks: $e');
      return [];
    }
  }

  Future<void> updateTask(Task task) async {
    final db = await instance.database;
    try {
      await db.update(
        'tasks',
        task.toMap(),
        where: 'id = ?',
        whereArgs: [task.id],
      );
    } catch (e) {
      print('Error updating task: $e');
    }
  }

  Future<void> deleteTask(int id) async {
    final db = await instance.database;
    try {
      await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      print('Error deleting task: $e');
    }
  }

  Future<void> close() async {
    final db = await instance.database;
    try {
      await db.close();
    } catch (e) {
      print('Error closing database: $e');
    }
  }
}
