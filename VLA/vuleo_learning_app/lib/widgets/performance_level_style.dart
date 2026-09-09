import 'package:flutter/material.dart';

import '../models/topic_performance.dart';
import '../theme/app_theme.dart';

extension PerformanceLevelStyle on PerformanceLevel {
  Color get color {
    switch (this) {
      case PerformanceLevel.notStarted:
        return Colors.black38;
      case PerformanceLevel.needsPractice:
        return AppTheme.quizColor;
      case PerformanceLevel.onTrack:
        return AppTheme.parentColor;
      case PerformanceLevel.excelling:
        return AppTheme.lessonsColor;
    }
  }

  IconData get icon {
    switch (this) {
      case PerformanceLevel.notStarted:
        return Icons.radio_button_unchecked_rounded;
      case PerformanceLevel.needsPractice:
        return Icons.priority_high_rounded;
      case PerformanceLevel.onTrack:
        return Icons.trending_up_rounded;
      case PerformanceLevel.excelling:
        return Icons.star_rounded;
    }
  }

  String get label {
    switch (this) {
      case PerformanceLevel.notStarted:
        return 'Not started';
      case PerformanceLevel.needsPractice:
        return 'Needs practice';
      case PerformanceLevel.onTrack:
        return 'On track';
      case PerformanceLevel.excelling:
        return 'Excelling';
    }
  }
}
