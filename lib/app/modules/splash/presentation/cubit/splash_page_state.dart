part of 'splash_page_cubit.dart';

sealed class SplashPageState extends Equatable {
  const SplashPageState();

  @override
  List<Object> get props => [];
}

final class SplashPageError extends SplashPageState {
  final String title;
  final String? description;
  const SplashPageError({required this.title, this.description});
}

final class SplashPageInitial extends SplashPageState {}

final class SplashPageNoHasConnection extends SplashPageState {}

final class SplashPageSuccess extends SplashPageState {}
