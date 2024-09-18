import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:googlemaps_flutter_webservices/geocoding.dart';
import 'package:konsi_test/app/core/shared/features/record/record_logic.dart';
import 'package:konsi_test/app/core/shared/services/connection/connection_service.dart';
import 'package:konsi_test/app/core/shared/services/connection/connection_service_impl.dart';
import 'package:konsi_test/app/core/shared/services/database/database_service.dart';
import 'package:konsi_test/app/core/shared/services/geolocation/geolocation_service.dart';
import 'package:konsi_test/app/modules/home/home_module.dart';
import 'package:konsi_test/app/modules/not_connected/presentation/not_connected_page.dart';
import 'package:konsi_test/app/modules/not_found/presentation/not_found_page.dart';
import 'package:konsi_test/app/modules/review_record/presentation/review_record_page.dart';
import 'package:konsi_test/app/modules/splash/presentation/splash_page.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton<ConnectionService>(() => ConnectionServiceImpl());
    i.addSingleton<DatabaseService>(() => DatabaseService());
    i.addSingleton<GoogleMapsGeocoding>(() => GoogleMapsGeocoding(apiKey: dotenv.env['GOOGLE_MAPS_KEY']));

    i.addLazySingleton<GeolocationService>(() => GeolocationService());
    RecordLogic.binds(i); // Normalmente seria colocado no módulo especifico, porém esse projeto tem somente uma funcionalidade, não tem necessidade!
  }

  @override
  void routes(RouteManager r) {
    // MODULES

    r.module(
      '/home/',
      module: HomeModule(),
      transition: TransitionType.fadeIn,
      duration: 1000.ms,
    );

    // CHILDS
    r.child(
      '/',
      child: (args) => const SplashPage(),
      transition: TransitionType.fadeIn,
      duration: 500.ms,
    );
    r.child(
      '/review_record/',
      child: (args) => ReviewRecordPage(
        address: r.args.data,
      ),
      transition: TransitionType.fadeIn,
      duration: 500.ms,
    );
    r.child(
      '/not_connected/',
      child: (args) => const NotConnectedPage(),
      transition: TransitionType.fadeIn,
      duration: 800.ms,
    );
    r.wildcard(
      child: (args) => const NotFoundPage(),
      transition: TransitionType.fadeIn,
      duration: 800.ms,
    );
  }
}
