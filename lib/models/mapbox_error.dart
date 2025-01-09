class MapboxError implements Exception {
  const MapboxError({required this.message});

  factory MapboxError.fromJson(Map<String, dynamic> json) {
    return MapboxError(
      message: json['message'] as String,
    );
  }

  final String message;
}
