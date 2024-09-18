part of 'maps_cubit.dart';

sealed class MapsState extends Equatable {
  const MapsState();

  @override
  List<Object> get props => [];
}

final class MapsInitial extends MapsState {}

final class MapsLoading extends MapsState {}

final class MapsLoaded extends MapsState {}
