// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:konsi_test/app/core/common/errors/failures.dart';
import 'package:konsi_test/app/core/common/features/fp.dart';
import 'package:konsi_test/app/core/common/features/usecases/usecase.dart';
import 'package:konsi_test/app/core/shared/features/record/data/model/record_model.dart';
import 'package:konsi_test/app/core/shared/features/record/domain/repositories/record_repository.dart';
import 'package:konsi_test/app/core/shared/models/paginated_model.dart';

class RecordList extends Usecase<Paginated<RecordModel>, RecordListParams> {
  final RecordRepository repository;

  RecordList({
    required this.repository,
  });

  @override
  Future<Either<Failure, Paginated<RecordModel>>> call(RecordListParams params) async {
    return await repository.recordList(params.search, params.page);
  }
}

class RecordListParams {
  final String search;
  final int page;

  RecordListParams({
    required this.search,
    required this.page,
  });
}
