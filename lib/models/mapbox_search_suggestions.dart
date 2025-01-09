import 'package:travel_app/models/mapbox_search_suggestion.dart';

class MapboxSearchSuggestions {
  const MapboxSearchSuggestions({required this.suggestions});

  factory MapboxSearchSuggestions.fromJson(Map<String, dynamic> json) {
    final suggestions = (json['suggestions'] as List<dynamic>)
        .map((suggestion) => MapboxSearchSuggestion.fromJson(suggestion))
        .toList();

    return MapboxSearchSuggestions(suggestions: suggestions);
  }

  final List<MapboxSearchSuggestion> suggestions;
}
