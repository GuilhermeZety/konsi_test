import 'package:konsi_test/app/core/common/errors/failures.dart';
import 'package:konsi_test/app/core/common/features/fp.dart';
import 'package:konsi_test/app/core/common/features/usecases/usecase.dart';
import 'package:konsi_test/app/core/shared/features/record/domain/repositories/record_repository.dart';

class ToggleFavorite extends Usecase<bool, ToggleFavoriteParams> {
  final RecordRepository repository;

  ToggleFavorite({
    required this.repository,
  });

  @override
  Future<Either<Failure, bool>> call(ToggleFavoriteParams params) async {
    return await repository.toggleFavorite(params.recordId, params.value);
  }
}

class ToggleFavoriteParams {
  final int recordId;
  final bool value;

  ToggleFavoriteParams({required this.recordId, required this.value});
}
