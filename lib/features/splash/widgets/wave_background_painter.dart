import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class WaveBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Layer 1 - Lowest/Background wave
    final paint1 = Paint()
      ..color = AppColors.wave1.withValues(alpha: 0.85)
      ..style = PaintingStyle.fill;

    final path1 = Path();
    path1.moveTo(0, h * 0.72);
    path1.cubicTo(
      w * 0.25,
      h * 0.65,
      w * 0.75,
      h * 0.80,
      w,
      h * 0.73,
    );
    path1.lineTo(w, h);
    path1.lineTo(0, h);
    path1.close();
    canvas.drawPath(path1, paint1);

    // Layer 2 - Middle wave
    final paint2 = Paint()
      ..color = AppColors.wave2.withValues(alpha: 0.75)
      ..style = PaintingStyle.fill;

    final path2 = Path();
    path2.moveTo(0, h * 0.79);
    path2.cubicTo(
      w * 0.35,
      h * 0.85,
      w * 0.65,
      h * 0.72,
      w,
      h * 0.82,
    );
    path2.lineTo(w, h);
    path2.lineTo(0, h);
    path2.close();
    canvas.drawPath(path2, paint2);

    // Layer 3 - Foreground wave
    final paint3 = Paint()
      ..color = AppColors.wave3.withValues(alpha: 0.60)
      ..style = PaintingStyle.fill;

    final path3 = Path();
    path3.moveTo(0, h * 0.84);
    path3.cubicTo(
      w * 0.30,
      h * 0.78,
      w * 0.70,
      h * 0.90,
      w,
      h * 0.88,
    );
    path3.lineTo(w, h);
    path3.lineTo(0, h);
    path3.close();
    canvas.drawPath(path3, paint3);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
