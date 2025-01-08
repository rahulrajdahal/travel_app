import 'package:travel_app/models/search_places.dart';

class SearchCache {
  final _cache = <String, SearchPlaces>{};

  SearchPlaces? get(String key) => _cache[key];

  void set(String key, SearchPlaces places) => _cache[key] = places;

  bool contains(String key) => _cache.containsKey(key);

  void remove(String key) => _cache.remove(key);
}
