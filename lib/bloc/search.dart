import 'package:travel_app/bloc/map_client.dart';
import 'package:travel_app/cache/search_cache.dart';
import 'package:travel_app/models/search_places.dart';

class Search {
  const Search(this.cache, this.client);

  final SearchCache cache;
  final MapClient client;

  Future<SearchPlaces> searchPlaces(String query) async {
    final cacheResult = cache.get(query);
    if (cacheResult != null) {
      return cacheResult;
    }
    final result = await client.searchPlace(query);
    cache.set(query, result);
    return result;
  }
}
