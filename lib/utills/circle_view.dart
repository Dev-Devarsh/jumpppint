import 'package:flutter/material.dart';

class CircleView extends StatelessWidget {
  late Color color;
  late double size;

  CircleView({Key? key, required this.color,required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: size,
        height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
