import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'widgets/wave_background_painter.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback? onContinue;
  final Duration delay;

  const SplashScreen({
    super.key,
    this.onContinue,
    this.delay = const Duration(milliseconds: 2500),
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer(widget.delay, () {
      _triggerContinue();
    });
  }

  void _triggerContinue() {
    if (!_navigated && mounted) {
      _navigated = true;
      _timer?.cancel();
      widget.onContinue?.call();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            // Bottom dune waves
            Positioned.fill(
              child: CustomPaint(
                painter: WaveBackgroundPainter(),
              ),
            ),

            // Content
            Column(
              children: [
                const Spacer(flex: 2),

                // Center App Logo
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    color: AppColors.backgroundBadge,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.15),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 28),

                // Title
                const Text(
                  'Hush',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                    letterSpacing: -0.4,
                  ),
                ),
                const SizedBox(height: 8),

                // Subtitle
                const Text(
                  'Keep your apps private',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textSecondary,
                  ),
                ),

                const Spacer(flex: 3),

                // Home Indicator Bar
                GestureDetector(
                  onTap: _triggerContinue,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    width: 140,
                    height: 5,
                    decoration: BoxDecoration(
                      color: AppColors.primaryDark.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),

            // Tap anywhere trigger to proceed immediately
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: AppColors.primary.withValues(alpha: 0.05),
                  highlightColor: Colors.transparent,
                  onTap: _triggerContinue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
