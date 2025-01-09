import 'package:travel_app/bloc/map_client.dart';
import 'package:travel_app/cache/mapbox_search_cache.dart';
import 'package:travel_app/models/mapbox_search_suggestions.dart';

class MapboxSearch {
  const MapboxSearch(this.cache, this.client);

  final MapboxSearchCache cache;
  final MapClient client;

  Future<MapboxSearchSuggestions> searchSuggestions(String query) async {
    final cacheResult = cache.get(query);
    if (cacheResult != null) {
      return cacheResult;
    }
    final result = await client.searchSuggestions(query);
    print(query);
    print(result);
    cache.set(query, result);
    return result;
  }
}
