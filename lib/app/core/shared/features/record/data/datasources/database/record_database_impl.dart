import 'package:konsi_test/app/core/shared/features/record/data/datasources/database/record_database.dart';
import 'package:konsi_test/app/core/shared/features/record/data/model/record_model.dart';
import 'package:konsi_test/app/core/shared/features/record/record_logic.dart';
import 'package:konsi_test/app/core/shared/models/paginated_model.dart';
import 'package:konsi_test/app/core/shared/services/database/database_service.dart';
import 'package:sqflite/sqflite.dart';

class RecordDatabaseImpl extends RecordDatabase {
  final DatabaseService databaseService;

  RecordDatabaseImpl({
    required this.databaseService,
  });

  @override
  Future<bool> hasRecords() async {
    Database database = databaseService.database;

    return await database.count('records') > 0;
  }

  @override
  Future<bool> toggleFavorite(int recordId, bool value) async {
    Database database = databaseService.database;

    await database.update(
      'records',
      {
        'favorited': value ? 1 : 0,
      },
      where: 'id = ?',
      whereArgs: [recordId],
    );

    return true;
  }

  @override
  Future<bool> createRecord(String cep, String address, String? number, String? complement, double? latitude, double? longitude) async {
    Database database = databaseService.database;

    var adressId = await database.insert('address', {
      'cep': cep,
      'address': address,
      'number': number,
      'complement': complement,
      'latitude': latitude,
      'longitude': longitude,
    });

    await database.insert('records', {
      'address_id': adressId,
    });

    return true;
  }

  @override
  Future<Paginated<RecordModel>> recordList(String search, int page) async {
    Database database = databaseService.database;

    var response = await database.rawQuery(
      RecordLogic.query(
        where: search.isNotEmpty ? "address.cep like '%$search%' or address.address like '%$search%'" : null,
        orderBy: 'records.favorited desc',
        limit: 10,
        offset: ((page - 1) * 10),
      ),
    );

    return Paginated.fromMap(
      {
        'data': response.map((e) => RecordLogic.toMap(e)),
        'next_page': response.length == 10,
      },
      RecordModel.fromMap,
    );
  }
}
