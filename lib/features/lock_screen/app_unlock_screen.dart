import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../pin/widgets/numeric_keypad.dart';
import '../pin/widgets/pin_dots_indicator.dart';

class AppUnlockScreen extends StatefulWidget {
  final String appName;
  final IconData appIcon;
  final String expectedPin;
  final VoidCallback? onUnlocked;
  final VoidCallback? onClose;

  const AppUnlockScreen({
    super.key,
    this.appName = 'WhatsApp',
    this.appIcon = Icons.chat_bubble_rounded,
    this.expectedPin = '1234',
    this.onUnlocked,
    this.onClose,
  });

  @override
  State<AppUnlockScreen> createState() => _AppUnlockScreenState();
}

class _AppUnlockScreenState extends State<AppUnlockScreen> {
  String _enteredPin = '';
  bool _hasError = false;
  bool _isUnlocked = false;

  void _handleDigit(String digit) {
    if (_enteredPin.length < 4 && !_isUnlocked) {
      setState(() {
        _hasError = false;
        _enteredPin += digit;
      });

      if (_enteredPin.length == 4) {
        if (_enteredPin == widget.expectedPin || widget.expectedPin.isEmpty) {
          // Success
          setState(() {
            _isUnlocked = true;
          });
          Future.delayed(const Duration(milliseconds: 300), () {
            if (mounted) {
              widget.onUnlocked?.call();
            }
          });
        } else {
          // Wrong PIN
          setState(() {
            _hasError = true;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Incorrect PIN. Try entering 1234 or your configured PIN.'),
              duration: Duration(seconds: 2),
              backgroundColor: AppColors.primaryDark,
            ),
          );
          Future.delayed(const Duration(milliseconds: 500), () {
            if (mounted) {
              setState(() {
                _enteredPin = '';
                _hasError = false;
              });
            }
          });
        }
      }
    }
  }

  void _handleDelete() {
    if (_enteredPin.isNotEmpty && !_isUnlocked) {
      setState(() {
        _hasError = false;
        _enteredPin = _enteredPin.substring(0, _enteredPin.length - 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundAlt,
      body: SafeArea(
        child: Column(
          children: [
            // Optional close / back handle
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: IconButton(
                  onPressed: widget.onClose ?? () => Navigator.maybePop(context),
                  icon: const Icon(
                    Icons.close_rounded,
                    color: AppColors.textSecondary,
                    size: 22,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // App Icon in mocha rounded square
            AnimatedScale(
              duration: const Duration(milliseconds: 300),
              scale: _isUnlocked ? 1.1 : 1.0,
              child: Container(
                width: 76,
                height: 76,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.25),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    widget.appIcon,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // App Title
            Text(
              widget.appName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 6),

            // Subtitle
            Text(
              _isUnlocked ? 'Unlocked successfully!' : 'This app is locked',
              style: TextStyle(
                fontSize: 14,
                color: _isUnlocked ? Colors.green.shade700 : AppColors.textSecondary,
                fontWeight: _isUnlocked ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
            const SizedBox(height: 36),

            // 4 PIN Dots Indicator
            PinDotsIndicator(
              pinLength: _enteredPin.length,
              hasError: _hasError,
            ),

            const Spacer(),

            // Numeric Keypad
            NumericKeypad(
              onDigitPressed: _handleDigit,
              onDeletePressed: _handleDelete,
            ),
            const SizedBox(height: 36),
          ],
        ),
      ),
    );
  }
}
