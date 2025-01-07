import 'package:flutter/material.dart';
import 'package:travel_app/api/map.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({super.key});

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  late Future<dynamic> queryResults;

  @override
  void initState() {
    super.initState();
    queryResults = getPlace('Pat');
  }

  static const List<String> _kOptions = <String>[
    'Kathmandu',
    'Patan',
    'Bhaktapur',
  ];

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      builder: (context, controller) {
        return SearchBar(
          controller: controller,
          leading: const Icon(Icons.search),
          hintText: "Search Destination...",
          onTap: () {
            controller.openView();
          },
          onChanged: (query) {
            controller.openView();
            controller.text = query;
          },
        );
      },
      suggestionsBuilder: (context, controller) {
        return List<ListTile>.generate(5, (index) {
          return ListTile(
            title: Text("item $index"),
            onTap: () {
              // handle selection
              controller.text = "item$index";
            },
          );
        });
        // return FutureBuilder(
        //   future: queryResults,
        //   builder: (context, snapshot) {
        //     return Text("Result");
        //   },
        // );
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
