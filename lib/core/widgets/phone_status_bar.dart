import 'package:flutter/material.dart';

class PhoneStatusBar extends StatelessWidget {
  final Color contentColor;

  const PhoneStatusBar({
    super.key,
    this.contentColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
