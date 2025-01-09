import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/bloc/map_client.dart';
import 'package:travel_app/bloc/map_search_bloc.dart';
import 'package:travel_app/bloc/map_search_event.dart';
import 'package:travel_app/bloc/map_search_state.dart';
import 'package:travel_app/bloc/search.dart';
import 'package:travel_app/cache/search_cache.dart';
import 'package:travel_app/models/geocode_features.dart';

class SearchBox extends StatelessWidget {
  final search = Search(SearchCache(), MapClient());

  SearchBox({super.key});

  // const SearchBox({required this.search, super.key});

  // final Search search;

  // late MapSearchBloc _mapSearchBloc;

  // @override
  // void initState() {
  //   super.initState();
  //   _mapSearchBloc = MapSearchBloc(search: search);
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MapSearchBloc(search: search),
      child: Column(
        children: [
          Expanded(child: _SearchBar()),
          _SearchBody(),
        ],
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
  late MapSearchBloc _mapSearchBloc;

  @override
  void initState() {
    super.initState();
    _mapSearchBloc = context.read<MapSearchBloc>();
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
        _mapSearchBloc.add(SearchChanged(text: text));
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
    _mapSearchBloc.add(const SearchChanged(text: ''));
  }
}

class _SearchBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapSearchBloc, MapSearchState>(
      builder: (context, state) {
        return switch (state) {
          MapSearchStateEmpty() => const Text('Please enter a term to begin'),
          MapSearchStateLoading() => const CircularProgressIndicator.adaptive(),
          MapSearchStateError() => Text(state.error),
          MapSearchStateSuccess() => state.places.isEmpty
              ? const Text('No Results')
              : Expanded(child: _SearchResults(items: state.places)),
        };
      },
    );
  }
}

class _SearchResults extends StatelessWidget {
  const _SearchResults({required this.items});

  final List<GeocodeFeature> items;

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

  final GeocodeFeature item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // leading: CircleAvatar(
      //   child: Image.network(item.owner.avatarUrl),
      // ),
      title: Text(item.properties.name),
      // onTap: () => launchUrl(Uri.parse(item.htmlUrl)),
    );
  }
}


// class SearchBox extends StatefulWidget {
//   const SearchBox({super.key});

//   @override
//   State<SearchBox> createState() => _SearchBoxState();
// }

// class _SearchBoxState extends State<SearchBox> {
//   late Future<Geocode> queryResults;
//   Timer? _debounce;

//   // _onSearchChanged(String query) {
//   //   if (_debounce?.isActive ?? false) {
//   //     _debounce?.cancel();
//   //   }
//   //   _debounce = Timer(const Duration(microseconds: 500), () {
//   //     queryResults = getPlace(query);
//   //   });
//   // }

//   @override
//   void initState() {
//     super.initState();
//     queryResults = getPlace('Nepal');
//   }

//   @override
//   void dispose() {
//     _debounce?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SearchAnchor(
//       builder: (context, controller) {
//         return SearchBar(
//           controller: controller,
//           leading: const Icon(Icons.search),
//           hintText: "Search Destination...",
//           onTap: () {
//             controller.openView();
//           },
//           onChanged: (String query) {
//             if (_debounce?.isActive ?? false) {
//               _debounce?.cancel();
//             }
//             _debounce = Timer(const Duration(microseconds: 500), () {
//               queryResults = getPlace(query);
//             });

//             controller.openView();
//           },
//         );
//       },
//       suggestionsBuilder: (context, controller) {
// return [
//   FutureBuilder(
//       future: queryResults,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           if (snapshot.hasError) {
//             return const Text("Error Loading Suggestions.");
//           } else if (snapshot.hasData) {
//             var list = snapshot.data!.features;
//             if (list != null) {
//               return ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: list.length,
//                   itemBuilder: (context, index) {
//                     return Text("${list[index].properties!.name}");
//                   });
//             }
//           }
//         }

//         return const Center(child: CircularProgressIndicator());
//       })
// ];
//       },
//       // suggestionsBuilder: (context, controller) {
//       //   return List.generate(5, (index) {
//       //     return FutureBuilder(
//       //         future: queryResults,
//       //         builder: (context, snapshot) {
//       //           if (snapshot.hasError) {
//       //             return const Text("Error Loading Suggestions.");
//       //           } else if (snapshot.hasData) {
//       //             return Text(
//       //                 "${snapshot.data!.features![index].properties!.name}");
//       //           }
//       //           return const Center(child: CircularProgressIndicator());
//       //         });
//       //   });
//       // },
//     );
//   }
// }

// Container(
//       decoration: BoxDecoration(
//           border: Border.all(color: Colors.black),
//           borderRadius: BorderRadius.circular(getProportionateScreenWidth(20))),
//       child: Padding(
//         padding:
//             EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(4)),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const Icon(Icons.search),
//             SizedBox(width: getProportionateScreenWidth(4)),
//             SizedBox(
//               width: getProportionateScreenWidth(120),
//               child: Autocomplete(
//                 fieldViewBuilder: (BuildContext context,
//                     TextEditingController controller,
//                     FocusNode focusNode,
//                     VoidCallback onFieldSubmitted) {
//                   return TextFormField(
//                     decoration: InputDecoration(border: InputBorder.none),
//                     controller: controller,
//                     focusNode: focusNode,
//                     onFieldSubmitted: (String value) {
//                       onFieldSubmitted();
//                     },
//                   );
//                 },
//                 optionsBuilder: (TextEditingValue textEditingValue) {
//                   if (textEditingValue.text == '') {
//                     return const Iterable<String>.empty();
//                   }
//                   queryResults = getPlace(textEditingValue.text);
//                   return queryResults.then((places) {
//                     return places.map((place) {
//                       return ListTile(
//                         title: Text(place.name),
//                         onTap: () {
//                           // Navigate to map view with selected place
//                         },
//                       );
//                     }).toList();
//                   });
//                   // return _kOptions.where((String option) {
//                   //   return option.contains(textEditingValue.text.toLowerCase());
//                   // });
//                 },
//                 onSelected: (option) {
//                   debugPrint("onsel");
//                 },

//                 // onSelected: (String selection) async {
//                 //   debugPrint('You just selected $selection $queryResults');
//                 // },
//               ),
//             ),
//           ],
//         ),
//       ),
//     )
