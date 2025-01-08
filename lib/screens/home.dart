import 'package:flutter/material.dart';
import 'package:travel_app/size_config.dart';
import 'package:travel_app/widgets/recent_visits.dart';
import 'package:travel_app/widgets/search_box.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                Expanded(child: SearchBox()),
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
            // const PopularPlaces(),
          ],
        )),
      ),
    );
  }
}
