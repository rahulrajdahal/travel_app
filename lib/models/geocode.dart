class Geocode {
  final String type;
  final List features;

  Geocode({required this.type, required this.features});

  factory Geocode.fromJson(Map<String, dynamic> json) {
    return Geocode(type: json['type'], features: json['features']);
  }
}
