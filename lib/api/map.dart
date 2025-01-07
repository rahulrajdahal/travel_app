import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:travel_app/api/constants.dart';
import 'package:travel_app/models/geocode.dart';

final mabox_access_token = dotenv.get("MAPBOX_TOKEN");

Future getPlace(String query) async {
  try {
    final response = await http.get(Uri.parse(
      "${ApiConstants.baseMapUrl}${ApiConstants.geoCodeEndpoint}?q=Patan&country=NP&access_token=${mabox_access_token}",
    ));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((json) => Geocode.fromJson(json)).toList();
    } else {
      throw Exception("Failed to get searchQuery");
    }
  } catch (e) {
    print("Error searching for place ${e}");
  }
}
