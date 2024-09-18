import 'package:konsi_test/app/core/common/errors/failures.dart';
import 'package:konsi_test/app/core/common/features/fp.dart';
import 'package:konsi_test/app/core/shared/features/locale/data/datasources/datasource/locale_datasource.dart';
import 'package:konsi_test/app/core/shared/features/locale/domain/repositories/locale_repository.dart';
import 'package:konsi_test/app/core/shared/models/address_model.dart';
import 'package:konsi_test/app/core/shared/services/treater/treater_service.dart';

class LocaleRepositoryImpl extends LocaleRepository {
  final LocaleDatasource datasource;

  LocaleRepositoryImpl({
    required this.datasource,
  });

  @override
  Future<Either<Failure, List<AddressModel>>> searchLocale(String search) async {
    return TreaterService()<List<AddressModel>>(
      () async {
        return await datasource.searchLocale(search);
      },
      online: true,
      errorIdentification: 'Erro ao buscar os locais',
    );
  }
}
