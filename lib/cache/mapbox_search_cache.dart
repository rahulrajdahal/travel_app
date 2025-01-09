import 'package:travel_app/models/mapbox_search_suggestions.dart';

class MapboxSearchCache {
  final _cache = <String, MapboxSearchSuggestions>{};

  MapboxSearchSuggestions? get(String query) => _cache[query];

  void set(String query, MapboxSearchSuggestions suggestions) =>
      _cache[query] = suggestions;

  bool contains(String query) => _cache.containsKey(query);

  void remove(String query) => _cache.remove(query);
}
