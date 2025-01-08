import "package:equatable/equatable.dart";

sealed class MapSearchEvent extends Equatable {
  const MapSearchEvent();
}

final class SearchChanged extends MapSearchEvent {
  const SearchChanged({required this.text});

  final String text;

  @override
  List<Object> get props => [text];

  @override
  String toString() => 'SearchChanged {text: $text}';
}
