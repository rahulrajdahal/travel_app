import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:travel_app/bloc/map_search_event.dart';
import 'package:travel_app/bloc/map_search_state.dart';
import 'package:travel_app/bloc/search.dart';
import 'package:travel_app/models/search_places_error.dart';

const _duration = Duration(milliseconds: 500);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class MapSearchBloc extends Bloc<MapSearchEvent, MapSearchState> {
  MapSearchBloc({required this.search}) : super(MapSearchStateEmpty()) {
    on<SearchChanged>(_onSearchChanged, transformer: debounce(_duration));
  }

  final Search search;

  Future<void> _onSearchChanged(
      SearchChanged event, Emitter<MapSearchState> emit) async {
    final searchQuery = event.text;

    if (searchQuery.isEmpty) {
      return emit(MapSearchStateEmpty());
    }

    emit(MapSearchStateLoading());

    try {
      final places = await search.searchPlaces(searchQuery);
      emit(MapSearchStateSuccess(places.features));
    } catch (e) {
      emit(e is SearchPlacesError
          ? MapSearchStateError(e.message)
          : const MapSearchStateError("Something went wrong."));
    }
  }
}
