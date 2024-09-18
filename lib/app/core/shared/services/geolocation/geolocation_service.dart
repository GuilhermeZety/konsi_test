import 'package:flutter_modular/flutter_modular.dart';
import 'package:geolocator/geolocator.dart';
import 'package:konsi_test/app/core/common/errors/failures.dart';
import 'package:konsi_test/app/core/common/features/fp.dart';
import 'package:konsi_test/app/core/shared/services/connection/connection_service.dart';

class GeolocationService {
  Future<Either<Failure, bool>> verifyPermissions() async {
    try {
      LocationPermission permission;

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Either.failure(
            const Failure(
              title: 'O acesso à localização foi negado',
            ),
          );
        }
      }

      if (permission == LocationPermission.deniedForever) {
        await Geolocator.openLocationSettings();
        return Either.failure(
          const Failure(
            title: 'O acesso à localização foi negado permanentemente!',
          ),
        );
      }

      return Either.success(true);
    } catch (err) {
      return Either.failure(
        const Failure(
          title: 'Erro ao verificar permissões',
        ),
      );
    }
  }

  Future<Either<Failure, (double lat, double long)>> getCurrentLatLong({
    LocationAccuracy desiredAccuracy = LocationAccuracy.low,
  }) async {
    return treat<(double lat, double long)>(() async {
      var permissions = await verifyPermissions();

      if (permissions.isFailure) return Either.failure(permissions.getFailure!);

      final position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(
          accuracy: desiredAccuracy,
          distanceFilter: 100,
        ),
      );
      return Either.success(
        (
          position.latitude,
          position.longitude,
        ),
      );
    });
  }

  Future<Either<Failure, T>> treat<T>(
    Future<Either<Failure, T>> Function() function, {
    bool connected = true,
  }) async {
    try {
      if (!(connected && (await Modular.get<ConnectionService>().isConnected))) {
        return Either.failure(
          const Failure(
            title: 'Sem conexão com a internet!',
          ),
        );
      }
      return await function();
    } catch (err) {
      return Either.failure(
        const Failure(
          title: 'Erro ao buscar localização pelo endereço!',
        ),
      );
    }
  }
}
