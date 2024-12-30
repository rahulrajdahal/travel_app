import 'package:flutter/material.dart';

class TravelCard extends StatelessWidget {
  const TravelCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
          'https://example.com/image.jpg',
          fit: BoxFit.cover,
        )
      ],
    );
  }
}
