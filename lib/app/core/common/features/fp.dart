import 'package:konsi_test/app/core/common/errors/failures.dart';

class Either<Error extends Failure, Success> {
  final Success? _success;
  final Error? _failure;

  Either.success(Success success)
      : _success = success,
        _failure = null;
  Either.failure(Error failure)
      : _failure = failure,
        _success = null;

  bool get isSuccess => _success != null;
  bool get isFailure => _failure != null;

  Success? get getSuccess => _success;
  Error? get getFailure => _failure;

  Success getSuccessOr(Success Function() ifFailure) => fold((_) => ifFailure(), id);

  Value id<Value>(Value a) => a;

  ReturnValue fold<ReturnValue>(ReturnValue Function(Error l) ifFailure, ReturnValue Function(Success r) ifSuccess) {
    if (isFailure && _failure == null) throw FPException('Is failure but failure is NULL');
    if (isSuccess && _success == null) throw FPException('Is success but success is NULL');

    return isSuccess ? ifSuccess(_success as Success) : ifFailure(_failure as Error);
  }
}

class FPException implements Exception {
  final String message;
  FPException(this.message);
}
