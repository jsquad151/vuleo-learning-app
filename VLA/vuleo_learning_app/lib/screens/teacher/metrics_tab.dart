import 'package:flutter/material.dart';

import '../../data/lessons_data.dart';
import '../../data/quizzes_data.dart';
import '../../data/students_data.dart';
import '../../theme/app_theme.dart';
import '../../widgets/stat_tile.dart';
import '../../widgets/student_metric_row.dart';
import 'student_detail_screen.dart';

class MetricsTab extends StatelessWidget {
  const MetricsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final totalLessons = mockTopics.fold<int>(
      0,
      (sum, topic) => sum + topic.lessons.length,
    );
    final completionFractions = mockStudents.map((student) {
      final completed = student.completedLessonsByTopic.values.fold<int>(
        0,
        (sum, count) => sum + count,
      );
      return totalLessons == 0 ? 0.0 : completed / totalLessons;
    }).toList();
    final avgCompletion = completionFractions.isEmpty
        ? 0
        : (completionFractions.reduce((a, b) => a + b) /
                  completionFractions.length *
                  100)
              .round();

    final allScoreRatios = <double>[
      for (final student in mockStudents)
        for (var i = 0; i < mockTopics.length; i++)
          if (student.quizScoresByTopic[mockTopics[i].id] case final score?)
            score / mockQuizzes[i].questions.length,
    ];
    final avgQuizScore = allScoreRatios.isEmpty
        ? 0
        : (allScoreRatios.reduce((a, b) => a + b) /
                  allScoreRatios.length *
                  100)
              .round();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: StatTile(
                icon: Icons.groups_rounded,
                color: AppTheme.teacherColor,
                value: '${mockStudents.length}',
                label: 'Students',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StatTile(
                icon: Icons.menu_book_rounded,
                color: AppTheme.lessonsColor,
                value: '$avgCompletion%',
                label: 'Class avg. completion',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StatTile(
                icon: Icons.emoji_events_rounded,
                color: AppTheme.statsColor,
                value: '$avgQuizScore%',
                label: 'Class avg. quiz score',
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.separated(
            itemCount: mockStudents.length,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final student = mockStudents[index];
              return StudentMetricRow(
                student: student,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        StudentDetailScreen(student: student),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
