import 'package:konsi_test/app/core/common/errors/failures.dart';
import 'package:konsi_test/app/core/common/features/fp.dart';
import 'package:konsi_test/app/core/shared/models/address_model.dart';

abstract class LocaleRepository {
  Future<Either<Failure, List<AddressModel>>> searchLocale(String search);
}
