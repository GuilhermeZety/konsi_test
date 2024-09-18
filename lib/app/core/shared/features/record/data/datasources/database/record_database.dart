import 'package:konsi_test/app/core/shared/features/record/data/model/record_model.dart';
import 'package:konsi_test/app/core/shared/models/paginated_model.dart';

abstract class RecordDatabase {
  Future<bool> hasRecords();
  Future<bool> toggleFavorite(int recordId, bool value);
  Future<bool> createRecord(String cep, String address, String? number, String? complement, double? latitude, double? longitude);
  Future<Paginated<RecordModel>> recordList(String search, int page);
}
