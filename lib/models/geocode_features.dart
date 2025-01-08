import 'package:travel_app/models/geocode_properties.dart';

class GeocodeFeature {
  const GeocodeFeature({required this.properties});

  factory GeocodeFeature.fromJson(Map<String, dynamic> json) {
    final properties = GeocodeProperties.fromJson(json['properties']);

    return GeocodeFeature(properties: properties);
  }

  final GeocodeProperties properties;
}
