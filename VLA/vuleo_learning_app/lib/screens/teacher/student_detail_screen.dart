import 'package:flutter/material.dart';

import '../../models/child_profile.dart';
import '../../widgets/child_stats_view.dart';

class StudentDetailScreen extends StatelessWidget {
  const StudentDetailScreen({super.key, required this.student});

  final ChildProfile student;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(student.name)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: ChildStatsView(
            completedLessonsByTopic: student.completedLessonsByTopic,
            quizScoresByTopic: student.quizScoresByTopic,
          ),
        ),
      ),
    );
  }
}
