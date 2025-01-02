import 'package:flutter/material.dart';
import 'package:travel_app/size_config.dart';
import 'package:travel_app/widgets/popular_places.dart';
import 'package:travel_app/widgets/recent_visits.dart';
import 'package:travel_app/widgets/travel_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<String> _kOptions = <String>[
    'Kathmandu',
    'Patan',
    'Bhaktapur',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: getProportionateScreenHeight(60),
          flexibleSpace: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(24),
              vertical: getProportionateScreenHeight(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Travel",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: getProportionateScreenWidth(24)),
                ),
                SizedBox(width: getProportionateScreenWidth(24)),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(
                          getProportionateScreenWidth(20))),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(4)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.search),
                        SizedBox(width: getProportionateScreenWidth(4)),
                        SizedBox(
                          width: getProportionateScreenWidth(120),
                          child: Autocomplete(
                            fieldViewBuilder: (BuildContext context,
                                TextEditingController controller,
                                FocusNode focusNode,
                                VoidCallback onFieldSubmitted) {
                              return TextFormField(
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                                controller: controller,
                                focusNode: focusNode,
                                onFieldSubmitted: (String value) {
                                  onFieldSubmitted();
                                },
                              );
                            },
                            optionsBuilder:
                                (TextEditingValue textEditingValue) {
                              if (textEditingValue.text == '') {
                                return const Iterable<String>.empty();
                              }
                              return _kOptions.where((String option) {
                                return option.contains(
                                    textEditingValue.text.toLowerCase());
                              });
                            },
                            onSelected: (String selection) {
                              debugPrint('You just selected $selection');
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: getProportionateScreenWidth(24)),
                Icon(Icons.menu),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            const RecentVisits(),
            SizedBox(height: getProportionateScreenHeight(40)),
            const PopularPlaces(),
          ],
        )),
      ),
    );
  }
}
