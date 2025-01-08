class SearchPlacesError implements Exception {
  const SearchPlacesError({required this.message});

  factory SearchPlacesError.fromJson(Map<String, dynamic> json) {
    return SearchPlacesError(
      message: json['message'] as String,
    );
  }

  final String message;
}
