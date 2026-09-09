import 'package:flutter/material.dart';

import '../../data/badges_data.dart';
import '../../data/progress_data.dart';
import '../../theme/app_theme.dart';
import '../../widgets/child_badges_view.dart';
import '../../widgets/child_stats_view.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Your Stats'),
          bottom: const TabBar(
            labelColor: AppTheme.childColor,
            unselectedLabelColor: Colors.black54,
            indicatorColor: AppTheme.childColor,
            tabs: [Tab(text: 'Stats'), Tab(text: 'Badges')],
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: TabBarView(
              children: [
                ChildStatsView(
                  completedLessonsByTopic: mockCompletedLessonsByTopic,
                  quizScoresByTopic: mockQuizScoresByTopic,
                ),
                ChildBadgesView(badges: emmaBadges),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
