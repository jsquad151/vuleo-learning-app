import 'package:flutter/material.dart';

import '../../models/child_profile.dart';
import '../../theme/app_theme.dart';
import '../../widgets/child_stats_view.dart';
import 'child_settings_view.dart';

class ChildDetailScreen extends StatelessWidget {
  const ChildDetailScreen({super.key, required this.child});

  final ChildProfile child;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(child.name),
          bottom: const TabBar(
            labelColor: AppTheme.parentColor,
            unselectedLabelColor: Colors.black54,
            indicatorColor: AppTheme.parentColor,
            tabs: [Tab(text: 'Stats'), Tab(text: 'Settings')],
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: TabBarView(
              children: [
                ChildStatsView(
                  completedLessonsByTopic: child.completedLessonsByTopic,
                  quizScoresByTopic: child.quizScoresByTopic,
                ),
                ChildSettingsView(child: child),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
