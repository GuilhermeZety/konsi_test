import 'package:flutter_modular/flutter_modular.dart';
import 'package:konsi_test/app/core/shared/features/locale/data/datasources/datasource/locale_datasource.dart';
import 'package:konsi_test/app/core/shared/features/locale/data/datasources/datasource/locale_maps_webservice_datasource_impl.dart';
import 'package:konsi_test/app/core/shared/features/locale/data/repositories/locale_repository_impl.dart';
import 'package:konsi_test/app/core/shared/features/locale/domain/repositories/locale_repository.dart';
import 'package:konsi_test/app/core/shared/features/locale/domain/usecases/search_locale.dart';

class LocaleLogic {
  static void binds(Injector i) {
    i.addLazySingleton<LocaleDatasource>(
      () => LocaleMapWebserviceDatasourceImpl(
        geocoding: Modular.get(),
      ),
    );
    i.addLazySingleton<LocaleRepository>(
      () => LocaleRepositoryImpl(
        datasource: Modular.get(),
      ),
    );
    i.addLazySingleton<SearchLocale>(
      () => SearchLocale(
        repository: Modular.get(),
      ),
    );
  }
}
