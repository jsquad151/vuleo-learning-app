import 'package:flutter/material.dart';

class ChildProfile {
  const ChildProfile({
    required this.id,
    required this.name,
    required this.avatarIcon,
    required this.avatarColor,
    required this.completedLessonsByTopic,
    required this.quizScoresByTopic,
  });

  final String id;
  final String name;
  final IconData avatarIcon;
  final Color avatarColor;
  final Map<String, int> completedLessonsByTopic;
  final Map<String, int> quizScoresByTopic;
}
