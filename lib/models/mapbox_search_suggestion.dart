class MapboxSearchSuggestion {
  const MapboxSearchSuggestion({required this.name});

  factory MapboxSearchSuggestion.fromJson(json) {
    return MapboxSearchSuggestion(name: json['name']);
  }

  final String name;
}
