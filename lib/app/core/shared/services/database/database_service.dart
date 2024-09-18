import 'dart:developer';

import 'package:konsi_test/app/core/common/constants/app_constants.dart';
import 'package:konsi_test/app/core/common/errors/exceptions.dart';
import 'package:konsi_test/app/core/shared/services/database/database_tables.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  DatabaseService._();
  static final DatabaseService _instance = DatabaseService._();
  factory DatabaseService() => DatabaseService._instance;

  //onlyDebug
  bool forceRecreate = false;

  late Database database;

  Future<void> initialize() async {
    await _initializeDB();
    if (forceRecreate) {
      final Database db = await openDatabase(
        AppConstants.dbPath,
        version: AppConstants.dbVersion,
      );
      await truncateDB(db);
      await _createTables(db);
    }
  }

  /// It creates the tables in the database.
  Future<void> _initializeDB() async {
    final Database db = await openDatabase(
      AppConstants.dbPath,
      version: AppConstants.dbVersion,
      onUpgrade: _onUpgrade,
      onOpen: (db) async {
        await _createTables(db);
      },
      onCreate: (db, version) async {
        await _createTables(db);
      },
    );
    database = db;
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (newVersion != oldVersion) {
      log('new db version identified!!!');
      await truncateDB(db);
      // 3. Criar novamente as tabelas necessárias
      await _createTables(db);
    }
  }

  Future truncateDB(Database db) async {
    // 1. Obter a lista de tabelas existentes no banco de dados
    List<Map<String, dynamic>> tables = await db.rawQuery(
      'SELECT name FROM sqlite_master WHERE type = "table" AND name NOT LIKE "sqlite_%"',
    );

    // 2. Excluir todas as tabelas
    Batch batch = db.batch();
    for (var table in tables) {
      var tableName = table['name'];
      log('deleting table: $tableName');
      batch.execute('DROP TABLE IF EXISTS $tableName');
    }
    await batch.commit(noResult: true);
  }

  Future<void> _createTables(Database db) async {
    await db.transaction(
      (database) async => DatabaseTables.createTables(database),
    );
  }

  Future<bool> batch(String table, Iterable<Map<String, dynamic>> listData) async {
    try {
      final batch = database.batch();

      for (var element in listData) {
        batch.insert(
          table,
          element,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      await batch.commit();

      return true;
    } catch (e) {
      throw DBException(message: e.toString());
    }
  }
}

/// An extension method that is used to count the number of rows in a table.
extension Count on Database {
  Future<int> count(String table, {String? aditionalWhere}) async {
    try {
      var response = await query(table, columns: ['count()'], where: aditionalWhere);
      return (response.first['count()'] as num).toInt();
    } catch (err) {
      return 0;
    }
  }
}
