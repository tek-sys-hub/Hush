import 'package:flutter/services.dart';

class PermissionService {
  static const MethodChannel _channel = MethodChannel('com.example.hush/permissions');

  static Future<bool> checkUsageStats() async {
    try {
      final bool? hasPerm = await _channel.invokeMethod<bool>('checkUsageStats');
      return hasPerm ?? false;
    } catch (_) {
      return false;
    }
  }

  static Future<void> requestUsageStats() async {
    try {
      await _channel.invokeMethod('requestUsageStats');
    } catch (_) {}
  }

  static Future<bool> checkOverlay() async {
    try {
      final bool? hasPerm = await _channel.invokeMethod<bool>('checkOverlay');
      return hasPerm ?? false;
    } catch (_) {
      return false;
    }
  }

  static Future<void> requestOverlay() async {
    try {
      await _channel.invokeMethod('requestOverlay');
    } catch (_) {}
  }

  static Future<bool> checkNotification() async {
    try {
      final bool? hasPerm = await _channel.invokeMethod<bool>('checkNotification');
      return hasPerm ?? false;
    } catch (_) {
      return false;
    }
  }

  static Future<void> requestNotification() async {
    try {
      await _channel.invokeMethod('requestNotification');
    } catch (_) {}
  }

  static Future<bool> checkDeviceAdmin() async {
    try {
      final bool? hasPerm = await _channel.invokeMethod<bool>('checkDeviceAdmin');
      return hasPerm ?? false;
    } catch (_) {
      return false;
    }
  }

  static Future<void> requestDeviceAdmin() async {
    try {
      await _channel.invokeMethod('requestDeviceAdmin');
    } catch (_) {}
  }
}
