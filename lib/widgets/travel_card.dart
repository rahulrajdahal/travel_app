import 'package:flutter/material.dart';
import 'package:travel_app/size_config.dart';

class TravelCard extends StatelessWidget {
  final bool isRecent;

  const TravelCard({super.key, required this.isRecent});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(getProportionateScreenWidth(12)),
          child: Image.network(
            'https://imgs.search.brave.com/HbJ4HL0SU4OPzwsm9WwKY5rLEplyCwojeHHonkJu2cM/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXR0eWltYWdl/cy5jb20vaWQvOTE2/MjQyODA0L3Bob3Rv/L2JvdWRoYW5hdGgt/c3R1cGEta2F0aG1h/bmR1LW5lcGFsLWZl/YnJ1YXJ5LTI3LTIw/MTcuanBnP3M9NjEy/eDYxMiZ3PTAmaz0y/MCZjPUg4dU9QNFJM/TEpYd21HREV4d2V5/RGdlb2FiUUZFd0df/Z2Z5NVFtSGtXSjQ9',
            fit: BoxFit.cover,
            height: getProportionateScreenHeight(250),
            width: getProportionateScreenWidth(252),
            color: Colors.black38,
            colorBlendMode: BlendMode.overlay,
          ),
        ),
        if (isRecent)
          Positioned(
            top: getProportionateScreenHeight(8),
            right: getProportionateScreenWidth(12),
            child: Container(
                decoration: BoxDecoration(
                    color: (Colors.blue.shade200),
                    border: Border.all(
                        color: Colors.blue,
                        width: getProportionateScreenWidth(2)),
                    borderRadius:
                        BorderRadius.circular(getProportionateScreenWidth(16))),
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(8),
                    vertical: getProportionateScreenHeight(4)),
                child: Text(
                  "Recently Visited",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: getProportionateScreenWidth(14),
                      color: Colors.black),
                )),
          ),
        Positioned(
          bottom: getProportionateScreenHeight(0),
          left: getProportionateScreenHeight(0),
          right: getProportionateScreenHeight(0),
          child: Container(
            height: getProportionateScreenHeight(140),
            width: getProportionateScreenWidth(252),
            decoration: BoxDecoration(
                color: Colors.black54, borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(4),
                ),
                ListTile(
                  minVerticalPadding: getProportionateScreenHeight(2),
                  dense: true,
                  visualDensity: VisualDensity.compact,
                  leading: Icon(
                    Icons.place,
                    size: getProportionateScreenWidth(32),
                    color: Colors.white60,
                  ),
                  title: Text("Kathmandu",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: getProportionateScreenWidth(32))),
                ),
                ListTile(
                  minVerticalPadding: getProportionateScreenHeight(2),
                  dense: true,
                  visualDensity: VisualDensity.compact,
                  leading: const Icon(
                    Icons.description,
                    color: Colors.white60,
                  ),
                  title: Text("The beautiful capital of Nepal.",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: getProportionateScreenWidth(12))),
                ),
                ListTile(
                  minVerticalPadding: getProportionateScreenHeight(2),
                  dense: true,
                  visualDensity: VisualDensity.compact,
                  leading: const Icon(
                    Icons.star,
                    color: Colors.white60,
                  ),
                  title: Text("5",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: getProportionateScreenWidth(12))),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
