import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:travel_app/bloc/mapbox_search.dart';
import 'package:travel_app/bloc/mapbox_search_suggestions_event.dart';
import 'package:travel_app/bloc/mapbox_search_suggestions_state.dart';
import 'package:travel_app/models/mapbox_error.dart';

const _duration = Duration(milliseconds: 500);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class MapboxSearchSuggestionsBloc
    extends Bloc<MapboxSearchSuggestionsEvent, MapboxSearchSuggestionsState> {
  MapboxSearchSuggestionsBloc({required this.mapboxSearch})
      : super(MapboxSearchSuggestionsStateEmpty()) {
    on<MapboxSearchChanged>(_onSearchChanged, transformer: debounce(_duration));
  }

  final MapboxSearch mapboxSearch;

  Future<void> _onSearchChanged(MapboxSearchChanged event,
      Emitter<MapboxSearchSuggestionsState> emit) async {
    final searchQuery = event.query;

    if (searchQuery.isEmpty) {
      return emit(MapboxSearchSuggestionsStateEmpty());
    }

    emit(MapboxSearchSuggestionsStateLoading());

    try {
      final suggestions = await mapboxSearch.searchSuggestions(searchQuery);
      emit(MapboxSearchSuggestionsStateSuccess(suggestions.suggestions));
    } catch (e) {
      emit(e is MapboxError
          ? MapboxSearchSuggestionsStateError(e.message)
          : const MapboxSearchSuggestionsStateError("Something went wrong."));
    }
  }
}
