import 'package:flutter/material.dart';

import '../models/child_profile.dart';
import '../theme/app_theme.dart';
import 'progress_data.dart';

// A parent may have more than one child. Emma reuses the same mock progress
// data shown on the child role's own Stats screen; Noah is a second profile
// with different numbers to demonstrate switching between children.
final List<ChildProfile> mockChildren = [
  ChildProfile(
    id: 'emma',
    name: 'Emma',
    avatarIcon: Icons.face_3_rounded,
    avatarColor: AppTheme.topicColors[0],
    completedLessonsByTopic: mockCompletedLessonsByTopic,
    quizScoresByTopic: mockQuizScoresByTopic,
  ),
  ChildProfile(
    id: 'noah',
    name: 'Noah',
    avatarIcon: Icons.face_6_rounded,
    avatarColor: AppTheme.topicColors[1],
    completedLessonsByTopic: const {
      'numbers': 3,
      'letters': 9,
      'shapes': 9,
      'science': 2,
      'life-skills': 5,
    },
    quizScoresByTopic: const {'letters': 3, 'shapes': 4},
  ),
];
