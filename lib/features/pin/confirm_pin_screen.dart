import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/custom_back_button.dart';
import '../../core/widgets/phone_status_bar.dart';
import 'widgets/numeric_keypad.dart';
import 'widgets/pin_dots_indicator.dart';

class ConfirmPinScreen extends StatefulWidget {
  final String? originalPin;
  final VoidCallback? onPinConfirmed;
  final VoidCallback? onBack;

  const ConfirmPinScreen({
    super.key,
    this.originalPin,
    this.onPinConfirmed,
    this.onBack,
  });

  @override
  State<ConfirmPinScreen> createState() => _ConfirmPinScreenState();
}

class _ConfirmPinScreenState extends State<ConfirmPinScreen> {
  String _currentPin = '';
  bool _hasError = false;

  void _handleDigit(String digit) {
    if (_currentPin.length < 4) {
      setState(() {
        _hasError = false;
        _currentPin += digit;
      });

      if (_currentPin.length == 4) {
        // Validate if originalPin is provided
        if (widget.originalPin != null && _currentPin != widget.originalPin) {
          setState(() {
            _hasError = true;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('PIN does not match. Please try again.'),
              backgroundColor: AppColors.primaryDark,
              duration: Duration(seconds: 2),
            ),
          );
          Future.delayed(const Duration(milliseconds: 600), () {
            if (mounted) {
              setState(() {
                _currentPin = '';
                _hasError = false;
              });
            }
          });
        } else {
          // Success
          Future.delayed(const Duration(milliseconds: 250), () {
            if (mounted) {
              widget.onPinConfirmed?.call();
            }
          });
        }
      }
    }
  }

  void _handleDelete() {
    if (_currentPin.isNotEmpty) {
      setState(() {
        _hasError = false;
        _currentPin = _currentPin.substring(0, _currentPin.length - 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const PhoneStatusBar(),

            // Top Navigation Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  CustomBackButton(onPressed: widget.onBack),
                  const Spacer(),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Title & Subtitle
            const Text(
              'Confirm Password',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Re-enter your 4-digit PIN.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 36),

            // PIN Dots Indicator
            PinDotsIndicator(
              pinLength: _currentPin.length,
              hasError: _hasError,
            ),

            const Spacer(),

            // Keypad
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
