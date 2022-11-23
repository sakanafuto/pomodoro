// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:pomodoro/component/pupup/popup_painter.dart';

class CustomPopUp extends StatelessWidget {
  const CustomPopUp({
    super.key,
    required this.color,
    required this.text,
    this.xcoord = 0.5,
    this.height = 60,
  });

  final Color color;
  final String text;
  final double xcoord;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: CustomPaint(
        painter: PopUpPainter(color, xcoord),
        child: Padding(
          padding: EdgeInsets.only(top: 2 * height / 5),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ),
      ),
    );
  }
}
