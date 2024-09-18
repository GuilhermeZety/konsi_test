import 'dart:developer';

import 'package:konsi_test/app/core/common/errors/exceptions.dart';
import 'package:konsi_test/app/core/common/errors/failures.dart';
import 'package:konsi_test/app/core/common/features/fp.dart';
import 'package:konsi_test/app/core/shared/services/connection/connection_service_impl.dart';

class TreaterService {
  Future<Either<Failure, T>> call<T>(
    Future<T> Function() code, {
    String? errorIdentification,
    bool online = false,
  }) async {
    if (await isConnected || !online) {
      try {
        return Either.success(await code());
      } on ServerException catch (e, stt) {
        log(e.message ?? e.toString(), stackTrace: stt);

        return Either.failure(
          Failure(
            title: e.message ?? errorIdentification ?? '',
            stackTrace: stt,
          ),
        );
      } on Exception catch (e, stt) {
        log(e.toString(), stackTrace: stt);

        return Either.failure(
          Failure(
            title: e.toString(),
          ),
        );
      } on Failure catch (e, stt) {
        log(e.toString(), stackTrace: stt);

        return Either.failure(e);
      } catch (e, stt) {
        if (e is TypeError) {
          log(e.toString(), error: e, stackTrace: stt, name: 'TypeError');
        } else {
          log(e.toString(), error: e, stackTrace: stt);
        }
        if (e is ServerException) {
          return Either.failure(
            ServerFailure(
              title: e.message ?? '',
            ),
          );
        }
        return Either.failure(
          Failure(
            title: e.toString(),
          ),
        );
      }
    } else {
      return Either.failure(const Failure(title: 'Sem conexão com a internet'));
    }
  }

  Future<bool> isConnected = ConnectionServiceImpl().isConnected;
}
