import 'package:flutter/material.dart';
import 'package:travel_app/size_config.dart';
import 'package:travel_app/widgets/travel_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Travel App"),
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
    );
  }
}
