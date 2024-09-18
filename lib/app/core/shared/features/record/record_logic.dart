import 'package:flutter_modular/flutter_modular.dart';
import 'package:konsi_test/app/core/shared/features/record/data/datasources/database/record_database.dart';
import 'package:konsi_test/app/core/shared/features/record/data/datasources/database/record_database_impl.dart';
import 'package:konsi_test/app/core/shared/features/record/data/repositories/record_repository_impl.dart';
import 'package:konsi_test/app/core/shared/features/record/domain/repositories/record_repository.dart';
import 'package:konsi_test/app/core/shared/features/record/domain/usecases/create_record.dart';
import 'package:konsi_test/app/core/shared/features/record/domain/usecases/has_records.dart';
import 'package:konsi_test/app/core/shared/features/record/domain/usecases/record_list.dart';
import 'package:konsi_test/app/core/shared/features/record/domain/usecases/toggle_favorite.dart';

class RecordLogic {
  static void binds(Injector i) {
    i.addLazySingleton<RecordDatabase>(
      () => RecordDatabaseImpl(
        databaseService: Modular.get(),
      ),
    );
    i.addLazySingleton<RecordRepository>(
      () => RecordRepositoryImpl(
        database: Modular.get(),
      ),
    );
    i.addLazySingleton<HasRecords>(
      () => HasRecords(
        repository: Modular.get(),
      ),
    );
    i.addLazySingleton<CreateRecord>(
      () => CreateRecord(
        repository: Modular.get(),
      ),
    );
    i.addLazySingleton<RecordList>(
      () => RecordList(
        repository: Modular.get(),
      ),
    );
    i.addLazySingleton<ToggleFavorite>(
      () => ToggleFavorite(
        repository: Modular.get(),
      ),
    );
  }

  static String query({String? where, int? limit, int? offset, String? orderBy}) => '''
    SELECT 
    records.*,

    address.id as address_id,
    address.cep as address_cep,
    address.address as address_address,
    address.number as address_number,
    address.complement as address_complement,
    address.latitude as address_latitude,
    address.longitude as address_longitude

    FROM 
    records

    JOIN address ON address.id = records.address_id
    
    ${where != null ? 'WHERE $where' : ''}

    ${orderBy != null ? 'ORDER BY $orderBy' : ''}

    ${limit != null ? 'LIMIT $limit' : ''}

    ${offset != null ? 'OFFSET $offset' : ''}
  ''';

  static Map<String, dynamic> toMap(Map<String, dynamic> old) {
    return {
      'id': old['id'],
      'favorited': old['favorited'],
      'address': {
        'id': old['address_id'],
        'cep': old['address_cep'],
        'address': old['address_address'],
        'number': old['address_number'],
        'complement': old['address_complement'],
        'latitude': old['address_latitude'],
        'longitude': old['address_longitude'],
      },
    };
  }
}
