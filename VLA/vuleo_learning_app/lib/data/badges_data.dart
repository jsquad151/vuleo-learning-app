import 'package:flutter/material.dart';

import '../models/child_badge.dart';
import '../theme/app_theme.dart';

// Mock badge history per child. There's no persistence or scoring engine
// yet, so these stand in for badges a real system would compute — the child
// role's Badges tab, and the parent/teacher per-child Badges tab, all read
// from here.

final List<ChildBadge> emmaBadges = [
  ChildBadge(
    title: 'Class Star',
    description: 'Highest average quiz score in class this month.',
    icon: Icons.emoji_events_rounded,
    color: AppTheme.statsColor,
    earnedOn: DateTime(2026, 8, 31),
    isMonthly: true,
  ),
  ChildBadge(
    title: 'On a Roll',
    description: 'Completed a lesson every day for 7 days straight.',
    icon: Icons.local_fire_department_rounded,
    color: AppTheme.quizColor,
    earnedOn: DateTime(2026, 8, 20),
  ),
  ChildBadge(
    title: 'Perfect Score',
    description: 'Scored 100% on the Letters & Phonics quiz.',
    icon: Icons.star_rounded,
    color: AppTheme.topicColors[3],
    earnedOn: DateTime(2026, 7, 2),
  ),
  ChildBadge(
    title: 'Topic Master',
    description: 'Completed every lesson in Numbers & Counting.',
    icon: Icons.military_tech_rounded,
    color: AppTheme.lessonsColor,
    earnedOn: DateTime(2026, 6, 15),
  ),
];

final List<ChildBadge> noahBadges = [
  ChildBadge(
    title: 'Most Improved',
    description: 'Biggest quiz score improvement in class this month.',
    icon: Icons.trending_up_rounded,
    color: AppTheme.parentColor,
    earnedOn: DateTime(2026, 8, 31),
    isMonthly: true,
  ),
  ChildBadge(
    title: 'On a Roll',
    description: 'Completed a lesson every day for 7 days straight.',
    icon: Icons.local_fire_department_rounded,
    color: AppTheme.quizColor,
    earnedOn: DateTime(2026, 8, 5),
  ),
  ChildBadge(
    title: 'Topic Master',
    description: 'Completed every lesson in Shapes & Colors.',
    icon: Icons.military_tech_rounded,
    color: AppTheme.lessonsColor,
    earnedOn: DateTime(2026, 7, 10),
  ),
];

final List<ChildBadge> liamBadges = [
  ChildBadge(
    title: 'Class Star',
    description: 'Highest average quiz score in class this month.',
    icon: Icons.emoji_events_rounded,
    color: AppTheme.statsColor,
    earnedOn: DateTime(2026, 7, 31),
    isMonthly: true,
  ),
  ChildBadge(
    title: 'Quiz Whiz',
    description: 'Took a quiz in every topic.',
    icon: Icons.psychology_rounded,
    color: AppTheme.teacherColor,
    earnedOn: DateTime(2026, 8, 1),
  ),
  ChildBadge(
    title: 'Perfect Score',
    description: 'Scored 100% on the Numbers & Counting quiz.',
    icon: Icons.star_rounded,
    color: AppTheme.topicColors[3],
    earnedOn: DateTime(2026, 6, 20),
  ),
  ChildBadge(
    title: 'Topic Master',
    description: 'Completed every lesson in Science Explorers.',
    icon: Icons.military_tech_rounded,
    color: AppTheme.lessonsColor,
    earnedOn: DateTime(2026, 5, 30),
  ),
  ChildBadge(
    title: 'On a Roll',
    description: 'Completed a lesson every day for 7 days straight.',
    icon: Icons.local_fire_department_rounded,
    color: AppTheme.quizColor,
    earnedOn: DateTime(2026, 8, 25),
  ),
];

const List<ChildBadge> oliviaBadges = <ChildBadge>[];

final List<ChildBadge> avaBadges = [
  ChildBadge(
    title: 'On a Roll',
    description: 'Completed a lesson every day for 7 days straight.',
    icon: Icons.local_fire_department_rounded,
    color: AppTheme.quizColor,
    earnedOn: DateTime(2026, 8, 10),
  ),
];

final List<ChildBadge> masonBadges = [
  ChildBadge(
    title: 'Topic Master',
    description: 'Completed every lesson in Numbers & Counting.',
    icon: Icons.military_tech_rounded,
    color: AppTheme.lessonsColor,
    earnedOn: DateTime(2026, 7, 15),
  ),
];
