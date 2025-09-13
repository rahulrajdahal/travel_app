import 'package:flutter/material.dart';
import 'package:travel_app/size_config.dart';
import 'package:travel_app/widgets/travel_card.dart';

class PopularPlaces extends StatelessWidget {
  const PopularPlaces({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Popular Places",
          style: TextStyle(
              fontSize: getProportionateScreenWidth(28),
              fontWeight: FontWeight.w700),
        ),
        SizedBox(height: getProportionateScreenHeight(14)),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(24)),
          child: SizedBox(
            height: getProportionateScreenHeight(200),
            child: GridView.count(
                crossAxisCount: MediaQuery.of(context).size.width > 680 ? 3 : 2,
                mainAxisSpacing: getProportionateScreenHeight(38),
                crossAxisSpacing: getProportionateScreenWidth(20),
                children: List.generate(100, (index) {
                  return TravelCard(
                    isRecent: (index == 0 || index == 1) ? true : false,
                  );
                })),
          ),
        )
      ],
    );
  }
}
