import 'package:flutter/material.dart';

import 'topic.dart';

class Quiz {
  const Quiz({
    required this.id,
    required this.title,
    required this.icon,
    required this.color,
    required this.unlocked,
    required this.questions,
  });

  final String id;
  final String title;
  final IconData icon;
  final Color color;
  final bool unlocked;
  final List<LessonQuestion> questions;
}
