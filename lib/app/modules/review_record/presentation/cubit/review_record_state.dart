part of 'review_record_cubit.dart';

sealed class ReviewRecordState extends Equatable {
  const ReviewRecordState();

  @override
  List<Object> get props => [];
}

final class ReviewRecordInitial extends ReviewRecordState {}

final class ReviewRecordLoaded extends ReviewRecordState {}

final class ReviewRecordCreated extends ReviewRecordState {}

final class ReviewRecordError extends ReviewRecordState {
  final String title;
  final String? description;
  const ReviewRecordError({
    required this.title,
    required this.description,
  });
}
