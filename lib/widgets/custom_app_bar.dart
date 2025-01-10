import 'package:flutter/material.dart';
import 'package:travel_app/size_config.dart';
import 'package:travel_app/widgets/search_box.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(24)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Travel",
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: getProportionateScreenWidth(24)),
          ),
          SizedBox(width: getProportionateScreenWidth(24)),
          Expanded(flex: 1, child: SearchBox()),
          SizedBox(width: getProportionateScreenWidth(24)),
          const Icon(Icons.menu)
        ],
      ),
    );
  }
}
