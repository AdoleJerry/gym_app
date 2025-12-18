import 'package:flutter/material.dart';

class QuickActionItem {
  final IconData icon;
  final String label;
  final Color color;

  const QuickActionItem({
    required this.icon,
    required this.label,
    required this.color,
  });
}

class Workout {
  final String name;
  final String difficulty;
  final String duration;
  final String image;
  final Color color;

  Workout({
    required this.name,
    required this.difficulty,
    required this.duration,
    required this.image,
    required this.color,
  });
}
