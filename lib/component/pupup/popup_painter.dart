// Flutter imports:
import 'package:flutter/material.dart';

class PopUpPainter extends CustomPainter {
  PopUpPainter(this.color, this.xcoord);
  final Color color;
  final double xcoord;

  @override
  void paint(Canvas canvas, Size size) {
    final x = size.width * xcoord;

    final points = [
      Offset(x, 0),
      Offset(x, size.height / 4),
      Offset(x - size.width * 0.05, 2 * size.height / 5),
      Offset(x - size.width * 0.1, 2 * size.height / 5),
      Offset(x + size.width * 0.1, 2 * size.height / 5),
      Offset(x + size.width * 0.05, 2 * size.height / 5),
    ];
    final arc = Path();
    final paintfill = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(size.width / 2, 7 * size.height / 10),
          width: size.width,
          height: 3 * size.height / 5,
        ),
        const Radius.circular(45),
      ),
      paintfill,
    );
    arc.moveTo(points[0].dx, points[0].dy);
    bezierCurve(arc, points[1], points[2], points[3]);
    arc.arcToPoint(points[4]);
    bezierCurve(arc, points[5], points[1], points[0]);
    arc.close();

    canvas.drawPath(arc, paintfill);
  }

  void bezierCurve(Path arc, Offset x1, Offset x2, Offset end) {
    arc.cubicTo(x1.dx, x1.dy, x2.dx, x2.dy, end.dx, end.dy);
  }

  @override
  bool shouldRepaint(covariant PopUpPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.xcoord != xcoord;
}
