import 'package:flutter/material.dart';
import 'core/theme/app_colors.dart';
import 'core/theme/app_theme.dart';
import 'features/splash/splash_screen.dart';
import 'features/onboarding/starter_package_screen.dart';
import 'features/permissions/permissions_screen.dart';
import 'features/app_selection/select_apps_screen.dart';
import 'features/pin/set_pin_screen.dart';
import 'features/pin/confirm_pin_screen.dart';
import 'features/dashboard/dashboard_screen.dart';
import 'features/settings/settings_screen.dart';
import 'features/lock_screen/app_unlock_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const HushApp());
}

class HushApp extends StatelessWidget {
  const HushApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hush',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const HushAppShell(),
    );
  }
}

class HushAppShell extends StatefulWidget {
  const HushAppShell({super.key});

  @override
  State<HushAppShell> createState() => _HushAppShellState();
}

class _HushAppShellState extends State<HushAppShell> {
  int _currentScreenIndex = 0;
  String _savedPin = '1234';
  String _activeAppToUnlock = 'WhatsApp';
  IconData _activeAppIcon = Icons.chat_bubble_rounded;

  void _goToScreen(int index) {
    setState(() {
      _currentScreenIndex = index;
    });
  }

  Widget _buildCurrentScreen() {
    switch (_currentScreenIndex) {
      case 0:
        return SplashScreen(
          onContinue: () => _goToScreen(1),
        );
      case 1:
        return StarterPackageScreen(
          onContinue: () => _goToScreen(2),
          onBack: () => _goToScreen(0),
        );
      case 2:
        return PermissionsScreen(
          onContinue: () => _goToScreen(3),
          onBack: () => _goToScreen(1),
        );
      case 3:
        return SelectAppsScreen(
          onNext: () => _goToScreen(4),
          onBack: () => _goToScreen(2),
        );
      case 4:
        return SetPinScreen(
          onPinEntered: (pin) {
            setState(() {
              _savedPin = pin;
            });
            _goToScreen(5);
          },
          onBack: () => _goToScreen(3),
        );
      case 5:
        return ConfirmPinScreen(
          originalPin: _savedPin,
          onPinConfirmed: () => _goToScreen(6),
          onBack: () => _goToScreen(4),
        );
      case 6:
        return DashboardScreen(
          onOpenSettings: () => _goToScreen(7),
          onOpenSelectApps: () => _goToScreen(3),
          onSelectAppToUnlock: (appName, icon) {
            setState(() {
              _activeAppToUnlock = appName;
              _activeAppIcon = icon;
            });
            _goToScreen(8);
          },
        );
      case 7:
        return SettingsScreen(
          onBack: () => _goToScreen(6),
          onChangePin: () => _goToScreen(4),
          onAppLock: () => _goToScreen(3),
          onPermissions: () => _goToScreen(2),
        );
      case 8:
        return AppUnlockScreen(
          appName: _activeAppToUnlock,
          appIcon: _activeAppIcon,
          expectedPin: _savedPin,
          onUnlocked: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('$_activeAppToUnlock unlocked! Opening app...'),
                backgroundColor: AppColors.primary,
                duration: const Duration(seconds: 2),
              ),
            );
            _goToScreen(6);
          },
          onClose: () => _goToScreen(6),
        );
      default:
        return SplashScreen(
          onContinue: () => _goToScreen(1),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > 560;

        Widget screenContent = _buildCurrentScreen();

        if (isDesktop) {
          return Scaffold(
            backgroundColor: const Color(0xFFE5DFC9).withValues(alpha: 0.3),
            body: Center(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 24),
                width: 410,
                height: 860,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(44),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.25),
                    width: 8,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.18),
                      blurRadius: 36,
                      offset: const Offset(0, 16),
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: screenContent,
              ),
            ),
          );
        }

        return screenContent;
      },
    );
  }
}
