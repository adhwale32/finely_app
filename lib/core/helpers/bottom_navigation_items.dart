import 'package:flutter/material.dart';

class BottomNavItem {
  final IconData icon;
  final String label;
  final bool isPlaceholder; // Whether to show placeholder snackbar

  BottomNavItem({
    required this.icon,
    required this.label,
    this.isPlaceholder = false,
  });

  static List<BottomNavItem> navItems = [
    BottomNavItem(icon: Icons.home, label: 'Home', isPlaceholder: true),
    BottomNavItem(icon: Icons.smart_toy, label: 'Finley AI', isPlaceholder: true),
    BottomNavItem(icon: Icons.pie_chart, label: 'Spending', isPlaceholder: false),
    BottomNavItem(icon: Icons.person_search, label: 'Meet Coach', isPlaceholder: true),
  ];
}
