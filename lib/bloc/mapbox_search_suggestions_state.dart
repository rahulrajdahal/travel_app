import 'package:equatable/equatable.dart';
import 'package:travel_app/models/mapbox_search_suggestion.dart';

sealed class MapboxSearchSuggestionsState extends Equatable {
  const MapboxSearchSuggestionsState();

  @override
  List<Object> get props => [];
}

final class MapboxSearchSuggestionsStateEmpty
    extends MapboxSearchSuggestionsState {}

final class MapboxSearchSuggestionsStateLoading
    extends MapboxSearchSuggestionsState {}

final class MapboxSearchSuggestionsStateSuccess
    extends MapboxSearchSuggestionsState {
  const MapboxSearchSuggestionsStateSuccess(this.suggestions);

  final List<MapboxSearchSuggestion> suggestions;

  @override
  List<Object> get props => [suggestions];

  @override
  String toString() =>
      'SearchSuggestionsStateSuccess {suggestions: ${suggestions.length}}';
}

final class MapboxSearchSuggestionsStateError
    extends MapboxSearchSuggestionsState {
  const MapboxSearchSuggestionsStateError(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
