import 'package:flutter/material.dart';

class MenuModel {
  final IconData icon;
  final IconData iconSelected;
  final String label;

  MenuModel({
    required this.label,
    required this.icon,
    required this.iconSelected,
  });
}
