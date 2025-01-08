class GeocodeProperties {
  const GeocodeProperties({required this.name});

  factory GeocodeProperties.fromJson(Map<String, dynamic> json) {
    return GeocodeProperties(name: json['name']);
  }

  final String name;
}
