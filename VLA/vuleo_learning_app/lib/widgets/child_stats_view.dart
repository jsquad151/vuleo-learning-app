import 'package:flutter/material.dart';

import '../data/lessons_data.dart';
import '../data/quizzes_data.dart';
import '../theme/app_theme.dart';
import 'stat_tile.dart';
import 'topic_progress_row.dart';

/// The KPI tiles + per-topic progress list, driven by whichever child's
/// progress maps are passed in — reused by the child's own Stats screen and
/// by the parent's per-child detail view.
class ChildStatsView extends StatelessWidget {
  const ChildStatsView({
    super.key,
    required this.completedLessonsByTopic,
    required this.quizScoresByTopic,
  });

  final Map<String, int> completedLessonsByTopic;
  final Map<String, int> quizScoresByTopic;

  @override
  Widget build(BuildContext context) {
    final totalLessons = mockTopics.fold<int>(
      0,
      (sum, topic) => sum + topic.lessons.length,
    );
    final completedLessons = completedLessonsByTopic.values.fold<int>(
      0,
      (sum, count) => sum + count,
    );
    final quizzesTaken = quizScoresByTopic.length;
    final scoreRatios = <double>[
      for (var i = 0; i < mockTopics.length; i++)
        if (quizScoresByTopic[mockTopics[i].id] case final score?)
          score / mockQuizzes[i].questions.length,
    ];
    final averageScore = scoreRatios.isEmpty
        ? 0
        : (scoreRatios.reduce((a, b) => a + b) / scoreRatios.length * 100)
              .round();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: StatTile(
                icon: Icons.menu_book_rounded,
                color: AppTheme.lessonsColor,
                value: '$completedLessons/$totalLessons',
                label: 'Lessons completed',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StatTile(
                icon: Icons.quiz_rounded,
                color: AppTheme.quizColor,
                value: '$quizzesTaken',
                label: 'Quizzes taken',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StatTile(
                icon: Icons.emoji_events_rounded,
                color: AppTheme.statsColor,
                value: '$averageScore%',
                label: 'Average score',
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.separated(
            itemCount: mockTopics.length,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final topic = mockTopics[index];
              final quiz = mockQuizzes[index];
              final quizScore = quizScoresByTopic[topic.id];
              return TopicProgressRow(
                topic: topic,
                completedLessons: completedLessonsByTopic[topic.id] ?? 0,
                quizScore: quizScore,
                quizTotal: quizScore == null ? null : quiz.questions.length,
              );
            },
          ),
        ),
      ],
    );
  }
}
