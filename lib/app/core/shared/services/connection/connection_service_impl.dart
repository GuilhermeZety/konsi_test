import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:konsi_test/app/core/shared/services/connection/connection_service.dart';

class ConnectionServiceImpl extends ConnectionService {
  @override
  Future<bool> get isConnected async => [
        ConnectivityResult.mobile,
        ConnectivityResult.wifi,
      ].contains(
        (await Connectivity().checkConnectivity()).first,
      );

  @override
  Future<Stream<bool>> connectionStream() async => Connectivity().onConnectivityChanged.map<bool>(
        (event) => event.first == ConnectivityResult.mobile || event.first == ConnectivityResult.wifi,
      );
}
