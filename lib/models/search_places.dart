import 'package:travel_app/models/geocode_features.dart';

class SearchPlaces {
  const SearchPlaces({required this.features});

  factory SearchPlaces.fromJson(Map<String, dynamic> json) {
    final features = (json['features'] as List<dynamic>)
        .map((dynamic feature) =>
            GeocodeFeature.fromJson(feature as Map<String, dynamic>))
        .toList();

    return SearchPlaces(features: features);
  }

  final List<GeocodeFeature> features;
}
