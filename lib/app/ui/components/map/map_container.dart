import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:konsi_test/app/core/common/constants/app_colors.dart';
import 'package:konsi_test/app/core/common/extensions/widget/widget_extension.dart';
import 'package:konsi_test/app/core/shared/services/connection/connection_service.dart';
import 'package:konsi_test/app/ui/components/loader.dart';
import 'package:konsi_test/app/ui/components/map/cubit/maps_cubit.dart';

class MapContainer extends StatefulWidget {
  const MapContainer({super.key});

  @override
  State<MapContainer> createState() => _MapContainerState();
}

class _MapContainerState extends State<MapContainer> {
  MapsCubit cubit = Modular.get();
  bool hasConnection = false;

  StreamSubscription? streamSubscription;

  @override
  void initState() {
    if (cubit.markers.isEmpty) {
      cubit.getCurrentLocation();
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var resp = await Modular.get<ConnectionService>().connectionStream();
      streamSubscription = resp.listen((event) {
        hasConnection = event;
        if (mounted) setState(() {});
        log('connection: $event', name: 'connection');
      });
      // streamSubscription = (await Modular.get<ConnectionService>().connectionStream()).listen((event) {
      //   hasConnection = event;
      //   if (mounted) setState(() {});
      // });
    });
    super.initState();
  }

  @override
  void dispose() {
    streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: cubit,
      listener: (context, state) {
        //
      },
      builder: (context, state) {
        if (!hasConnection) {
          return const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.wifi_off_rounded, size: 50),
              SizedBox(height: 20),
              Text(
                'Sem conexão\nNão será possivel carregar o mapa\nVerifique sua conexão e tente novamente!',
                style: TextStyle(
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ).pH(1);
        }

        if (state is MapsLoading) {
          return const Center(
            child: Loader(
              size: 50,
            ),
          );
        }
        return Stack(
          children: [
            Positioned.fill(
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: cubit.markers.firstOrNull?.position ?? const LatLng(-5.930297, -42.716590),
                  zoom: 17,
                ),
                myLocationEnabled: true,
                rotateGesturesEnabled: false,
                scrollGesturesEnabled: false,
                tiltGesturesEnabled: false,
                zoomGesturesEnabled: false,
                compassEnabled: false,
                mapToolbarEnabled: false,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                // liteModeEnabled: true,
                onMapCreated: (controller) {
                  cubit.controller = controller;
                },
                markers: cubit.markers.isNotEmpty
                    ? cubit.markers
                    : {
                        Marker(
                          markerId: const MarkerId('currentLocation'),
                          position: cubit.currentLocation ?? const LatLng(-5.930297, -42.716590),
                        ),
                      },
              ),
            ),
            Builder(
              builder: (context) {
                String? title = cubit.markers.firstOrNull?.infoWindow.title ?? 'Localização';
                return Positioned.fill(
                  left: title.length > 9 ? 140 : 100,
                  bottom: 40,
                  child: Center(
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: AppColors.red_500,
                        fontSize: 14,
                      ),
                    ),
                  ).animate().fade(duration: 1000.ms),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
