import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:konsi_test/app/core/shared/features/record/domain/usecases/create_record.dart';
import 'package:konsi_test/app/core/shared/models/address_model.dart';

part 'review_record_state.dart';

class ReviewRecordCubit extends Cubit<ReviewRecordState> {
  ReviewRecordCubit() : super(ReviewRecordInitial());

  late AddressModel address;
  TextEditingController cepController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController complementController = TextEditingController();

  void initialize(AddressModel address) {
    this.address = address;
    cepController.text = address.cep;
    addressController.text = address.address;
    numberController.text = address.number ?? '';
    complementController.text = address.complement ?? '';
    emit(ReviewRecordLoaded());
  }

  Future createRecord() async {
    var response = await Modular.get<CreateRecord>()(
      CreateRecordParams(
        cep: cepController.text,
        address: addressController.text,
        number: numberController.text,
        complement: complementController.text,
        latitude: address.latitude,
        longitude: address.longitude,
      ),
    );

    response.fold(
      (failure) {
        emit(ReviewRecordError(title: failure.title, description: failure.description));
      },
      (success) {
        emit(ReviewRecordCreated());
      },
    );
  }
}
