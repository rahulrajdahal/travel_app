import 'package:equatable/equatable.dart';

sealed class MapboxSearchSuggestionsEvent extends Equatable {
  const MapboxSearchSuggestionsEvent();
}

final class MapboxSearchChanged extends MapboxSearchSuggestionsEvent {
  const MapboxSearchChanged({required this.query});

  final String query;

  @override
  List<Object> get props => [query];

  @override
  String toString() => "Search Query Changed {query: $query}";
}
