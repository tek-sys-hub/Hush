import 'package:flutter/material.dart';

class AppInfo {
  final String id;
  final String name;
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  bool isLocked;

  AppInfo({
    required this.id,
    required this.name,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    this.isLocked = false,
  });

  AppInfo copyWith({
    String? id,
    String? name,
    IconData? icon,
    Color? iconColor,
    Color? iconBgColor,
    bool? isLocked,
  }) {
    return AppInfo(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      iconColor: iconColor ?? this.iconColor,
      iconBgColor: iconBgColor ?? this.iconBgColor,
      isLocked: isLocked ?? this.isLocked,
    );
  }
}
