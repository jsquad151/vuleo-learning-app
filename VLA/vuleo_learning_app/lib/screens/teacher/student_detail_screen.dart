import 'package:flutter/material.dart';

import '../../models/child_profile.dart';
import '../../theme/app_theme.dart';
import '../../widgets/child_badges_view.dart';
import '../../widgets/child_stats_view.dart';

class StudentDetailScreen extends StatelessWidget {
  const StudentDetailScreen({super.key, required this.student});

  final ChildProfile student;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(student.name),
          bottom: const TabBar(
            labelColor: AppTheme.teacherColor,
            unselectedLabelColor: Colors.black54,
            indicatorColor: AppTheme.teacherColor,
            tabs: [Tab(text: 'Stats'), Tab(text: 'Badges')],
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: TabBarView(
              children: [
                ChildStatsView(
                  completedLessonsByTopic: student.completedLessonsByTopic,
                  quizScoresByTopic: student.quizScoresByTopic,
                ),
                ChildBadgesView(badges: student.badges),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
