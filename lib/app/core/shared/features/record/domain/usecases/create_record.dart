// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:konsi_test/app/core/common/errors/failures.dart';
import 'package:konsi_test/app/core/common/features/fp.dart';
import 'package:konsi_test/app/core/common/features/usecases/usecase.dart';
import 'package:konsi_test/app/core/shared/features/record/domain/repositories/record_repository.dart';

class CreateRecord extends Usecase<bool, CreateRecordParams> {
  final RecordRepository repository;

  CreateRecord({
    required this.repository,
  });

  @override
  Future<Either<Failure, bool>> call(CreateRecordParams params) async {
    return await repository.createRecord(params.cep, params.address, params.number, params.complement, params.latitude, params.longitude);
  }
}

class CreateRecordParams {
  final String cep;
  final String address;
  final String? number;
  final String? complement;
  final double? latitude;
  final double? longitude;

  CreateRecordParams({
    required this.cep,
    required this.address,
    this.number,
    this.complement,
    this.latitude,
    this.longitude,
  });
}
