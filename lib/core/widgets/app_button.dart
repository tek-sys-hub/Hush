import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double height;
  final Color? backgroundColor;
  final Color? textColor;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.height = 54,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.primary,
          foregroundColor: textColor ?? AppColors.textLight,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
        child: Text(text),
      ),
    );
  }
}
