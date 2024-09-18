// ignore_for_file: public_member_api_docs, sort_constructors_first
//Default
import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String title;
  final String? description;
  final StackTrace? stackTrace;

  const Failure({
    required this.title,
    this.description,
    this.stackTrace,
  });

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [title, description, stackTrace];
}

class ServerFailure extends Failure {
  const ServerFailure({required super.title, super.stackTrace});
}

class DatabaseFailure extends Failure {
  const DatabaseFailure({required super.title, super.stackTrace});
}
