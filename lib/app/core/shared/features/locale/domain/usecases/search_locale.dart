// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:konsi_test/app/core/common/errors/failures.dart';
import 'package:konsi_test/app/core/common/features/fp.dart';
import 'package:konsi_test/app/core/common/features/usecases/usecase.dart';
import 'package:konsi_test/app/core/shared/features/locale/domain/repositories/locale_repository.dart';
import 'package:konsi_test/app/core/shared/models/address_model.dart';

class SearchLocale extends Usecase<List<AddressModel>, SearchLocaleParams> {
  final LocaleRepository repository;

  SearchLocale({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<AddressModel>>> call(SearchLocaleParams params) async {
    return await repository.searchLocale(
      params.search,
    );
  }
}

class SearchLocaleParams {
  final String search;

  SearchLocaleParams({
    required this.search,
  });
}
