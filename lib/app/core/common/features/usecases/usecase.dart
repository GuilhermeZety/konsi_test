import 'package:konsi_test/app/core/common/errors/failures.dart';
import 'package:konsi_test/app/core/common/features/fp.dart';

abstract class Usecase<ReturnType, Params> {
  Future<Either<Failure, ReturnType>> call(Params params);
}

class NoParams {}
