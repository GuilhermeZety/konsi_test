import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:konsi_test/app/core/shared/models/address_model.dart';
import 'package:konsi_test/app/core/shared/services/geolocation/geolocation_service.dart';

part 'maps_state.dart';

class MapsCubit extends Cubit<MapsState> {
  MapsCubit() : super(MapsInitial());

  Set<Marker> markers = {};
  GoogleMapController? controller;
  LatLng? currentLocation;

  Future getCurrentLocation() async {
    emit(MapsLoading());
    var resp = await Modular.get<GeolocationService>().getCurrentLatLong();
    if (resp.isSuccess) {
      currentLocation = LatLng(resp.getSuccess!.$1, resp.getSuccess!.$2);
      markers = {
        Marker(
          markerId: const MarkerId('currentLocation'),
          position: currentLocation!,
          infoWindow: const InfoWindow(title: 'Sua Localização'),
          icon: BitmapDescriptor.defaultMarker,
        ),
      };
    }

    emit(MapsLoaded());
  }

  Future toAddress(AddressModel address) async {
    markers = {
      Marker(
        markerId: MarkerId(address.address),
        infoWindow: InfoWindow(title: address.cep, snippet: address.address),
        position: LatLng(address.latitude, address.longitude),
      ),
    };

    emit(MapsInitial());
    emit(MapsLoaded());
    controller!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(address.latitude, address.longitude),
          zoom: 17,
        ),
      ),
    );
  }
}
