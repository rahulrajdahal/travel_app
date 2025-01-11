import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/bloc/map_client.dart';
import 'package:travel_app/bloc/mapbox_search.dart';
import 'package:travel_app/bloc/mapbox_search_suggestions_bloc.dart';
import 'package:travel_app/bloc/mapbox_search_suggestions_event.dart';
import 'package:travel_app/bloc/mapbox_search_suggestions_state.dart';
import 'package:travel_app/cache/mapbox_search_cache.dart';
import 'package:travel_app/models/mapbox_search_suggestion.dart';
import 'package:travel_app/size_config.dart';

class SearchBox extends StatelessWidget {
  SearchBox({super.key});

  final mapboxSearch = MapboxSearch(MapboxSearchCache(), MapClient());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MapboxSearchSuggestionsBloc(mapboxSearch: mapboxSearch),
      child: SizedBox(
        height: getProportionateScreenHeight(60),
        child: Column(
          children: [
            Expanded(child: _SearchBar()),
            _SearchBody(),
          ],
        ),
      ),
    );
  }
}

class _SearchBar extends StatefulWidget {
  @override
  State<_SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<_SearchBar> {
  final _textController = TextEditingController();
  late MapboxSearchSuggestionsBloc _mapSearchSuggestionsBloc;

  @override
  void initState() {
    super.initState();
    _mapSearchSuggestionsBloc = context.read<MapboxSearchSuggestionsBloc>();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textController,
      autocorrect: false,
      onChanged: (text) {
        _mapSearchSuggestionsBloc.add(MapboxSearchChanged(query: text));
      },
      decoration: InputDecoration(
        hintText: 'Search for places',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: GestureDetector(
            onTap: _onClearTapped, child: const Icon(Icons.clear)),
        border: InputBorder.none,
      ),
    );
  }

  void _onClearTapped() {
    _textController.clear();
    _mapSearchSuggestionsBloc.add(const MapboxSearchChanged(query: ''));
  }
}

class _SearchBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapboxSearchSuggestionsBloc,
        MapboxSearchSuggestionsState>(
      builder: (context, state) {
        return switch (state) {
          MapboxSearchSuggestionsStateEmpty() =>
            const Text('Please enter a term to begin'),
          MapboxSearchSuggestionsStateLoading() =>
            const CircularProgressIndicator.adaptive(),
          MapboxSearchSuggestionsStateError() => Text(state.error),
          MapboxSearchSuggestionsStateSuccess() => state.suggestions.isEmpty
              ? const Text('No Results')
              : Expanded(child: _SearchResults(items: state.suggestions)),
        };
      },
    );
  }
}

class _SearchResults extends StatelessWidget {
  const _SearchResults({required this.items});

  final List<MapboxSearchSuggestion> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return _SearchResultItem(item: items[index]);
      },
    );
  }
}

class _SearchResultItem extends StatelessWidget {
  const _SearchResultItem({required this.item});

  final MapboxSearchSuggestion item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.name),
    );
  }
}
