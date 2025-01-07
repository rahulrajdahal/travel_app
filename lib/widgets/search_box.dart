import 'package:flutter/material.dart';
import 'package:travel_app/api/map.dart';
import 'package:travel_app/models/geocode.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({super.key});

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  late Future<Geocode> queryResults;

  @override
  void initState() {
    super.initState();
    queryResults = getPlace('Patan');
  }

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      builder: (context, controller) {
        return SearchBar(
          controller: controller,
          leading: const Icon(Icons.search),
          hintText: "Search Destination...",
          // onTap: () {
          //   controller.openView();
          // },
          onChanged: (query) {
            controller.openView();
            print(query);
            queryResults = getPlace(query);
          },

          // onSubmitted: (query) {
          //   // controller.closeView();
          //   // queryResults = getPlace(query);
          // },
        );
      },
      suggestionsBuilder: (context, controller) {
        return List.generate(5, (index) {
          return FutureBuilder(
              future: queryResults,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text("Error Loading Suggestions.");
                } else if (snapshot.hasData) {
                  return Text(
                      "${snapshot.data!.features![index].properties!.name}");
                }
                return const Center(child: CircularProgressIndicator());
              });
        });
      },
    );
  }
}

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
