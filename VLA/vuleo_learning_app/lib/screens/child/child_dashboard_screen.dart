import 'package:flutter/material.dart';

import '../../data/progress_data.dart';
import '../../data/topic_performance_data.dart';
import '../../models/topic_performance.dart';
import '../../routes/app_routes.dart';
import '../../theme/app_theme.dart';
import '../../widgets/selection_card.dart';
import '../../widgets/suggestion_card.dart';
import 'topic_lessons_screen.dart';

class ChildDashboardScreen extends StatelessWidget {
  const ChildDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final performances = computeTopicPerformance(
      mockCompletedLessonsByTopic,
      mockQuizScoresByTopic,
    );
    final suggestions = [
      ...performances.where((p) => p.level == PerformanceLevel.needsPractice),
      ...performances.where((p) => p.level == PerformanceLevel.notStarted),
    ].take(2).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('What do you want to do?')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          child: Column(
            children: [
              if (suggestions.isNotEmpty) ...[
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Suggested for You',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                for (final performance in suggestions) ...[
                  SuggestionCard(
                    performance: performance,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            TopicLessonsScreen(topic: performance.topic),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ] else ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.lessonsColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.celebration_rounded,
                        color: AppTheme.lessonsColor,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          "You're doing great across every topic — keep it up!",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppTheme.lessonsColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 20),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: SelectionCard(
                        icon: Icons.quiz_rounded,
                        label: 'Quiz',
                        color: AppTheme.quizColor,
                        onTap: () =>
                            Navigator.pushNamed(context, AppRoutes.childQuiz),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: SelectionCard(
                        icon: Icons.menu_book_rounded,
                        label: 'Lessons',
                        color: AppTheme.lessonsColor,
                        onTap: () => Navigator.pushNamed(
                          context,
                          AppRoutes.childLessons,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: SelectionCard(
                        icon: Icons.bar_chart_rounded,
                        label: 'Stats',
                        color: AppTheme.statsColor,
                        onTap: () =>
                            Navigator.pushNamed(context, AppRoutes.childStats),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
