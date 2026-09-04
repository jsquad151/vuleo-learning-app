import 'package:flutter/material.dart';

import '../models/child_profile.dart';
import '../theme/app_theme.dart';
import 'children_data.dart';

// The teacher's roster includes Emma and Noah (the same two children a
// parent sees on their dashboard, with the same progress data) plus a
// larger class of additional mock students.
final List<ChildProfile> mockStudents = [
  ...mockChildren,
  ChildProfile(
    id: 'liam',
    name: 'Liam',
    avatarIcon: Icons.face_2_rounded,
    avatarColor: AppTheme.topicColors[2],
    completedLessonsByTopic: const {
      'numbers': 9,
      'letters': 9,
      'shapes': 9,
      'science': 9,
      'life-skills': 9,
    },
    quizScoresByTopic: const {
      'numbers': 5,
      'letters': 4,
      'shapes': 5,
      'science': 4,
      'life-skills': 5,
    },
  ),
  ChildProfile(
    id: 'olivia',
    name: 'Olivia',
    avatarIcon: Icons.face_4_rounded,
    avatarColor: AppTheme.topicColors[3],
    completedLessonsByTopic: const {
      'numbers': 0,
      'letters': 0,
      'shapes': 0,
      'science': 0,
      'life-skills': 0,
    },
    quizScoresByTopic: const {},
  ),
  ChildProfile(
    id: 'ava',
    name: 'Ava',
    avatarIcon: Icons.face_5_rounded,
    avatarColor: AppTheme.topicColors[4],
    completedLessonsByTopic: const {
      'numbers': 5,
      'letters': 3,
      'shapes': 0,
      'science': 0,
      'life-skills': 0,
    },
    quizScoresByTopic: const {},
  ),
  ChildProfile(
    id: 'mason',
    name: 'Mason',
    avatarIcon: Icons.face_rounded,
    avatarColor: AppTheme.topicColors[0],
    completedLessonsByTopic: const {
      'numbers': 9,
      'letters': 2,
      'shapes': 6,
      'science': 0,
      'life-skills': 3,
    },
    quizScoresByTopic: const {'numbers': 3},
  ),
];
