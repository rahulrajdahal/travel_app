import 'package:flutter/material.dart';
import 'package:travel_app/bloc/map_client.dart';
import 'package:travel_app/bloc/mapbox_search.dart';
import 'package:travel_app/cache/mapbox_search_cache.dart';
import 'package:travel_app/widgets/custom_app_bar.dart';
import 'package:travel_app/widgets/popular_places.dart';
import 'package:travel_app/widgets/recent_visits.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final mapboxSearch = MapboxSearch(MapboxSearchCache(), MapClient());

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppBar(),
              RecentVisits(),
              PopularPlaces(),
            ],
          ),
        ),
      ),
    );
  }
}
