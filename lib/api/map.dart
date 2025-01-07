import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:travel_app/api/constants.dart';
import 'package:travel_app/models/geocode.dart';

final mapbox_access_token = dotenv.get("MAPBOX_TOKEN");

Future<Geocode> getPlace(String query) async {
  final response = await http.get(Uri.parse(
    "${ApiConstants.baseMapUrl}${ApiConstants.geoCodeEndpoint}?q=$query&country=NP&access_token=$mapbox_access_token",
  ));

  if (response.statusCode == 200) {
    return geocodeFromJson(response.body);
  } else {
    throw Exception("Failed to get searchQuery");
  }
}
