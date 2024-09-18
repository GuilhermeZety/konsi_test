import 'package:konsi_test/app/core/common/errors/failures.dart';
import 'package:konsi_test/app/core/common/features/fp.dart';
import 'package:konsi_test/app/core/shared/features/record/data/datasources/database/record_database.dart';
import 'package:konsi_test/app/core/shared/features/record/data/model/record_model.dart';
import 'package:konsi_test/app/core/shared/features/record/domain/repositories/record_repository.dart';
import 'package:konsi_test/app/core/shared/models/paginated_model.dart';
import 'package:konsi_test/app/core/shared/services/treater/treater_service.dart';

class RecordRepositoryImpl extends RecordRepository {
  final RecordDatabase database;

  RecordRepositoryImpl({
    required this.database,
  });

  @override
  Future<Either<Failure, bool>> hasRecords() async {
    return TreaterService()<bool>(
      () async {
        return await database.hasRecords();
      },
      errorIdentification: 'Erro ao verificar se há registros',
    );
  }

  @override
  Future<Either<Failure, bool>> createRecord(String cep, String address, String? number, String? complement, double? latitude, double? longitude) async {
    return TreaterService()<bool>(
      () async {
        return await database.createRecord(cep, address, number, complement, latitude, longitude);
      },
      errorIdentification: 'Erro ao criar um novo registro',
    );
  }

  @override
  Future<Either<Failure, bool>> toggleFavorite(int recordId, bool value) async {
    return TreaterService()<bool>(
      () async {
        return await database.toggleFavorite(recordId, value);
      },
      errorIdentification: 'Erro ao alterar o favorito do registro',
    );
  }

  @override
  Future<Either<Failure, Paginated<RecordModel>>> recordList(String search, int page) async {
    return TreaterService()<Paginated<RecordModel>>(
      () async {
        return await database.recordList(search, page);
      },
      errorIdentification: 'Erro ao listar os registros',
    );
  }
}
