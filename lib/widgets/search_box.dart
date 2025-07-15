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
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(24),
          vertical: getProportionateScreenHeight(16),
        ),
        child: _Search(),
      ),
    );
  }
}

class _Search extends StatefulWidget {
  @override
  State<_Search> createState() => _SearchState();
}

class _SearchState extends State<_Search> {
  final _textController = TextEditingController();
  late MapboxSearchSuggestionsBloc _mapSearchSuggestionsBloc;
  late bool showResults = false;

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
    return Column(
      children: [
        Focus(
          onFocusChange: (hasFocus) {
            if (hasFocus) {
              setState(() {
                showResults = true;
              });
            } else {
              setState(() {
                showResults = false;
              });
            }
          },
          child: TextField(
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
              border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(getProportionateScreenWidth(20)),
                  borderSide: BorderSide(
                    width: getProportionateScreenWidth(4),
                    color: Colors.blue,
                  )),
            ),
          ),
        ),
        if (showResults)
          Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: getProportionateScreenHeight(12)),
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(24),
                  vertical: getProportionateScreenHeight(12)),
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: Colors.blue,
                  ),
                  borderRadius:
                      BorderRadius.circular(getProportionateScreenWidth(8))),
              child: _SearchBody()),
      ],
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
            const Center(child: CircularProgressIndicator.adaptive()),
          MapboxSearchSuggestionsStateError() => Text(state.error),
          MapboxSearchSuggestionsStateSuccess() => state.suggestions.isEmpty
              ? const Text('No Results')
              : _SearchResults(items: state.suggestions),
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
    return SizedBox(
      height: 200,
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return _SearchResultItem(item: items[index]);
        },
      ),
    );
  }
}

class _SearchResultItem extends StatelessWidget {
  const _SearchResultItem({required this.item});

  final MapboxSearchSuggestion item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        item.name,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
