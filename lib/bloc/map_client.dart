import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:travel_app/models/mapbox_error.dart';
import 'package:travel_app/models/mapbox_search_suggestions.dart';
import 'package:travel_app/models/search_places.dart';
import 'package:travel_app/models/search_places_error.dart';

class MapClient {
  MapClient({
    http.Client? httpClient,
    this.baseUrl = 'https://api.mapbox.com',
  }) : httpClient = httpClient ?? http.Client();

  final mapbox_access_token = dotenv.get("MAPBOX_TOKEN");

  final String baseUrl;
  final http.Client httpClient;

  Future<SearchPlaces> searchPlace(query) async {
    final response = await http.get(Uri.parse(
        "$baseUrl/search/searchbox/v1/suggest?q=$query&country=NP&session_token=[GENERATED-UUID]&access_token=$mapbox_access_token"));
    // "$baseUrl/search/searchbox/v1/suggest?q=$query&country=NP&access_token=$mapbox_access_token"));

    final results = json.decode(response.body) as Map<String, dynamic>;

    print(response.body);
    if (response.statusCode == 200) {
      return SearchPlaces.fromJson(results);
    } else {
      throw SearchPlacesError.fromJson(results);
    }
  }

  Future<MapboxSearchSuggestions> searchSuggestions(query) async {
    final response = await http.get(Uri.parse(
        "$baseUrl/search/searchbox/v1/suggest?q=$query&country=NP&session_token=[GENERATED-UUID]&access_token=$mapbox_access_token"));

    final results = json.decode(response.body) as Map<String, dynamic>;

    print(response.body);
    if (response.statusCode == 200) {
      return MapboxSearchSuggestions.fromJson(results);
    } else {
      throw MapboxError.fromJson(results);
    }
  }
}
