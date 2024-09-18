import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:konsi_test/app/core/shared/features/record/data/model/record_model.dart';
import 'package:konsi_test/app/core/shared/features/record/domain/usecases/record_list.dart';
import 'package:konsi_test/app/core/shared/models/paginated_model.dart';

part 'passbook_state.dart';

class PassbookCubit extends Cubit<PassbookState> {
  PassbookCubit() : super(PassbookInitial());

  int currentPage = 1;
  List<RecordModel> viwedRecords = [];
  Paginated<RecordModel>? pagination;
  TextEditingController searchController = TextEditingController();

  Future initialize() async {
    await getRecords();
  }

  Future getRecords() async {
    if (viwedRecords.isEmpty) {
      emit(PassbookSearching());
    }
    var response = await Modular.get<RecordList>()(RecordListParams(search: searchController.text, page: currentPage));

    if (response.getSuccess != null) {
      pagination = response.getSuccess;
      //
      if (currentPage > 1) {
        viwedRecords.addAll(pagination!.itens);
      } else {
        viwedRecords = pagination!.itens;
      }
    }
    emit(PassbookInitial());
    emit(PassbookSearched());
  }

  Future nextPage() async {
    if (pagination?.nextPage == true) {
      currentPage = currentPage + 1;
      await getRecords();
    }
  }
}
