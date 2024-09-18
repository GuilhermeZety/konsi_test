part of 'maps_section_cubit.dart';

sealed class MapsSectionState extends Equatable {
  const MapsSectionState();

  @override
  List<Object> get props => [];
}

final class MapsSectionInitial extends MapsSectionState {}

final class MapsSectionLoaded extends MapsSectionState {}

final class MapsSectionError extends MapsSectionState {
  final String title;
  final String? description;

  const MapsSectionError({
    required this.title,
    this.description,
  });
}
