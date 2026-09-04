import 'package:flutter/material.dart';

class LessonQuestion {
  const LessonQuestion({
    required this.prompt,
    required this.options,
    required this.correctIndex,
  });

  final String prompt;
  final List<String> options;
  final int correctIndex;
}

class Lesson {
  const Lesson({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.question,
  });

  final String id;
  final String title;
  final String subtitle;
  final LessonQuestion question;
}

class Topic {
  const Topic({
    required this.id,
    required this.title,
    required this.icon,
    required this.color,
    required this.lessons,
  });

  final String id;
  final String title;
  final IconData icon;
  final Color color;
  final List<Lesson> lessons;
}
