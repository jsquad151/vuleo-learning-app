import 'package:flutter/material.dart';

import '../../data/progress_data.dart';
import '../../widgets/child_stats_view.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Stats')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: ChildStatsView(
            completedLessonsByTopic: mockCompletedLessonsByTopic,
            quizScoresByTopic: mockQuizScoresByTopic,
          ),
        ),
      ),
    );
  }
}
