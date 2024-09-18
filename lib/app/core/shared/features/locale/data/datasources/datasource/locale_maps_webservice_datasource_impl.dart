import 'package:googlemaps_flutter_webservices/geocoding.dart';
import 'package:konsi_test/app/core/shared/features/locale/data/datasources/datasource/locale_datasource.dart';
import 'package:konsi_test/app/core/shared/models/address_model.dart';

class LocaleMapWebserviceDatasourceImpl extends LocaleDatasource {
  LocaleMapWebserviceDatasourceImpl({
    required this.geocoding,
  });

  final GoogleMapsGeocoding geocoding;

  @override
  Future<List<AddressModel>> searchLocale(String search) async {
    try {
      var value = search.replaceAll('-', '').padRight(8, '0');
      GeocodingResponse response = await geocoding.searchByAddress(value);

      if (response.results.isEmpty) {
        return [];
      }

      List<GeocodingResult> results = response.results;

      String getProperties(GeocodingResult geocoding, String type, {bool longName = true}) {
        for (var component in geocoding.addressComponents) {
          if (component.types.contains(type)) {
            return longName ? component.longName : component.shortName;
          }
        }
        return 'N/A';
      }

      return results
          .map(
            (result) => AddressModel(
              address: result.formattedAddress ?? 'Não Identificado',
              cep: getProperties(result, 'postal_code'),
              latitude: result.geometry.location.lat,
              longitude: result.geometry.location.lng,
            ),
          )
          .toList();
    } catch (err) {
      rethrow;
    }
  }
}
