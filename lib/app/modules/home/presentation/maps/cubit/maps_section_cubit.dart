import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:konsi_test/app/core/shared/features/locale/domain/usecases/search_locale.dart';
import 'package:konsi_test/app/core/shared/models/address_model.dart';
import 'package:konsi_test/app/ui/components/map/cubit/maps_cubit.dart';

part 'maps_section_state.dart';

class MapsSectionCubit extends Cubit<MapsSectionState> {
  MapsSectionCubit() : super(MapsSectionInitial());

  final mapCubit = Modular.get<MapsCubit>();

  List<AddressModel> locales = [];

  AddressModel? selected;

  TextEditingController searchController = TextEditingController();

  Future<void> search(String? value) async {
    if (value == null || value.isEmpty) {
      locales = [];
      selected = null;
      emit(MapsSectionInitial());
      emit(MapsSectionLoaded());
      return;
    }
    var resp = await Modular.get<SearchLocale>()(SearchLocaleParams(search: value));

    resp.fold(
      (failure) {
        emit(MapsSectionError(title: failure.title, description: failure.description));
        selected = null;
      },
      (success) {
        locales = success;
        emit(MapsSectionInitial());
        emit(MapsSectionLoaded());
      },
    );
    return;
    // var locale = resp.getSuccess?.firstOrNull;
    // if (locale != null) {
    //   await mapCubit.toAddress(locale);
    //   emit(MapsSectionInitial());
    //   emit(MapsSectionLoaded());
    // }
  }

  Future select(AddressModel address) async {
    locales = [];
    selected = address;
    emit(MapsSectionInitial());
    emit(MapsSectionLoaded());
    mapCubit.toAddress(address);
  }

  Future removeSelected() async {
    selected = null;
    emit(MapsSectionInitial());
    emit(MapsSectionLoaded());
    search(searchController.text);
  }

  Future clear() async {
    selected = null;
    locales = [];
    searchController.clear();
    emit(MapsSectionInitial());
    emit(MapsSectionLoaded());
  }

  @override
  Future<void> close() {
    searchController.dispose();
    return super.close();
  }
}
