import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static AppDatabase instance = AppDatabase._initial();
  Database? _db;
  AppDatabase._initial();

  Future<Database> getDatabase() async {
    // return existing database or initialize it
    return _db ??= await _initializer();
  }

  Future<Database> _initializer() async {
    String dbRoot = await getDatabasesPath();
    String dbName = 'weather_database1.db';
    final dbPath = join(dbRoot, dbName);
    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await _onCreate(db, version);
      },
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE weather(
        cityName TEXT PRIMARY KEY,
        temperature REAL,
        description TEXT,
        humidity INTEGER,
        windSpeed REAL,
        rainChance INTEGER,
        latitude REAL,
        longitude REAL,
        countryCode TEXT
      )
    ''');
  }
}
