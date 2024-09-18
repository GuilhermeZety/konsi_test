import 'package:konsi_test/app/core/common/errors/failures.dart';
import 'package:konsi_test/app/core/common/features/fp.dart';
import 'package:konsi_test/app/core/shared/features/record/data/model/record_model.dart';
import 'package:konsi_test/app/core/shared/models/paginated_model.dart';

abstract class RecordRepository {
  Future<Either<Failure, bool>> hasRecords();
  Future<Either<Failure, bool>> createRecord(String cep, String address, String? number, String? complement, double? latitude, double? longitude);
  Future<Either<Failure, Paginated<RecordModel>>> recordList(String search, int page);
  Future<Either<Failure, bool>> toggleFavorite(int recordId, bool value);
}
