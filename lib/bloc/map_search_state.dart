import 'package:equatable/equatable.dart';
import 'package:travel_app/models/geocode_features.dart';

sealed class MapSearchState extends Equatable {
  const MapSearchState();

  @override
  List<Object> get props => [];
}

final class MapSearchStateEmpty extends MapSearchState {}

final class MapSearchStateLoading extends MapSearchState {}

final class MapSearchStateSuccess extends MapSearchState {
  const MapSearchStateSuccess(this.places);

  final List<GeocodeFeature> places;

  @override
  List<Object> get props => [places];

  @override
  String toString() => 'SearchStateSuccess {places: ${places.length}}';
}

final class MapSearchStateError extends MapSearchState {
  const MapSearchStateError(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
