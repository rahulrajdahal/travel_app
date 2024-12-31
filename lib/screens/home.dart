import 'package:flutter/material.dart';
import 'package:travel_app/size_config.dart';
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
          child: Padding(
            padding: EdgeInsets.only(
                left: getProportionateScreenWidth(24),
                right: getProportionateScreenWidth(24)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      "Popular Places",
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(28),
                          fontWeight: FontWeight.w700),
                    ),
                    TextButton(
                      onPressed: () => {},
                      child: Text(
                        "More",
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(12),
                            fontWeight: FontWeight.w400,
                            color: Colors.blue[800]),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(280),
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return const TravelCard();
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(width: getProportionateScreenWidth(4));
                      },
                      itemCount: 10),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
