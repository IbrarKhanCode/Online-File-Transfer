import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final String image;
  const CustomContainer({super.key, required this.image});

  @override
  Widget build(BuildContext context) {

    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Container(
      height: h * .06,
      width: w * .15,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.contain,
              image: AssetImage(image)),
      ),
    );
  }
}
