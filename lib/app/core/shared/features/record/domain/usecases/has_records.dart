import 'package:konsi_test/app/core/common/errors/failures.dart';
import 'package:konsi_test/app/core/common/features/fp.dart';
import 'package:konsi_test/app/core/common/features/usecases/usecase.dart';
import 'package:konsi_test/app/core/shared/features/record/domain/repositories/record_repository.dart';

class HasRecords extends Usecase<bool, NoParams> {
  final RecordRepository repository;

  HasRecords({
    required this.repository,
  });

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.hasRecords();
  }
}
