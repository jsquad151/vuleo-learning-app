import 'package:flutter/material.dart';

/// A badge a child has earned, shown on the child's own Stats screen and on
/// the parent/teacher views of that child.
class ChildBadge {
  const ChildBadge({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.earnedOn,
    this.isMonthly = false,
  });

  final String title;
  final String description;
  final IconData icon;
  final Color color;

  /// The date this badge was awarded. For a monthly badge this is any date
  /// within the awarded month — [periodLabel] collapses it to "Month YYYY".
  final DateTime earnedOn;
  final bool isMonthly;

  static const _monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  /// "August 2026" for a monthly badge, "Aug 20, 2026" for a one-off badge.
  String get periodLabel {
    final month = _monthNames[earnedOn.month - 1];
    if (isMonthly) return '$month ${earnedOn.year}';
    return '${month.substring(0, 3)} ${earnedOn.day}, ${earnedOn.year}';
  }
}
