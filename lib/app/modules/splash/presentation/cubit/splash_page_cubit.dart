import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:konsi_test/app/core/common/features/usecases/usecase.dart';
import 'package:konsi_test/app/core/shared/features/record/domain/usecases/has_records.dart';
import 'package:konsi_test/app/core/shared/services/connection/connection_service.dart';

part 'splash_page_state.dart';

class SplashPageCubit extends Cubit<SplashPageState> {
  SplashPageCubit() : super(SplashPageInitial());

  void initialize() async {
    //Valor fixo para não pular instantaneamente a splash
    await Future.delayed(2.seconds);
    if (await hasConnection) {
      emit(SplashPageSuccess());
      return;
    }

    await verifyRecords();
  }

  Future verifyRecords() async {
    var response = await Modular.get<HasRecords>()(NoParams());

    response.fold(
      (failure) {
        emit(SplashPageError(title: failure.title, description: failure.description));
        return;
      },
      (success) {
        if (success) {
          emit(SplashPageSuccess());
          return;
        }

        emit(SplashPageNoHasConnection());
      },
    );
  }

  Future<bool> get hasConnection => Modular.get<ConnectionService>().isConnected;
}
