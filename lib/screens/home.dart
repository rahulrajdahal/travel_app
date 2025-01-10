import 'package:flutter/material.dart';
import 'package:travel_app/widgets/custom_app_bar.dart';
import 'package:travel_app/widgets/popular_places.dart';
import 'package:travel_app/widgets/recent_visits.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
