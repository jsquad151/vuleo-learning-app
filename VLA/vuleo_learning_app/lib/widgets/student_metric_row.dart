import 'package:flutter/material.dart';

import '../data/lessons_data.dart';
import '../models/child_profile.dart';

class StudentMetricRow extends StatelessWidget {
  const StudentMetricRow({
    super.key,
    required this.student,
    required this.onTap,
  });

  final ChildProfile student;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final totalLessons = mockTopics.fold<int>(
      0,
      (sum, topic) => sum + topic.lessons.length,
    );
    final completed = student.completedLessonsByTopic.values.fold<int>(
      0,
      (sum, count) => sum + count,
    );
    final fraction = totalLessons == 0 ? 0.0 : completed / totalLessons;
    final quizzesTaken = student.quizScoresByTopic.length;

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: student.avatarColor,
                child: Icon(student.avatarIcon, color: Colors.white, size: 18),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      student.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: fraction,
                        minHeight: 8,
                        backgroundColor: student.avatarColor.withValues(
                          alpha: 0.15,
                        ),
                        valueColor: AlwaysStoppedAnimation(
                          student.avatarColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              Text(
                '$completed/$totalLessons',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: student.avatarColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$quizzesTaken quiz${quizzesTaken == 1 ? '' : 'zes'}',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    color: student.avatarColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
