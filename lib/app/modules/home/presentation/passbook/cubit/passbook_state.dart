part of 'passbook_cubit.dart';

sealed class PassbookState extends Equatable {
  const PassbookState();

  @override
  List<Object> get props => [];
}

final class PassbookInitial extends PassbookState {}

final class PassbookError extends PassbookState {
  final String title;
  final String? description;

  const PassbookError({required this.title, this.description});
}

final class PassbookSearching extends PassbookState {}

final class PassbookSearched extends PassbookState {}
