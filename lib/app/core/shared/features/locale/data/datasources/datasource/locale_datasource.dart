import 'package:konsi_test/app/core/shared/models/address_model.dart';

abstract class LocaleDatasource {
  Future<List<AddressModel>> searchLocale(String search);
}
