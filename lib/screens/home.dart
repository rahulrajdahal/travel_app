import 'package:flutter/material.dart';
import 'package:travel_app/bloc/map_client.dart';
import 'package:travel_app/bloc/mapbox_search.dart';
import 'package:travel_app/cache/mapbox_search_cache.dart';
import 'package:travel_app/size_config.dart';
import 'package:travel_app/widgets/search_box.dart';
import 'package:travel_app/widgets/travel_card.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final mapboxSearch = MapboxSearch(MapboxSearchCache(), MapClient());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Column(
      children: [
        SearchBox(),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(24)),
            child: ListView.separated(
              itemBuilder: (context, index) {
                return TravelCard(
                    isRecent: index == 0 || index == 1 ? true : false);
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: getProportionateScreenHeight(40));
              },
              itemCount: 10,
            ),
          ),
        ),
      ],
    )));
  }
}
