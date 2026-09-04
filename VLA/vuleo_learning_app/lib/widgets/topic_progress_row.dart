import 'package:flutter/material.dart';

import '../models/topic.dart';

class TopicProgressRow extends StatelessWidget {
  const TopicProgressRow({
    super.key,
    required this.topic,
    required this.completedLessons,
    this.quizScore,
    this.quizTotal,
  });

  final Topic topic;
  final int completedLessons;
  final int? quizScore;
  final int? quizTotal;

  @override
  Widget build(BuildContext context) {
    final total = topic.lessons.length;
    final fraction = total == 0 ? 0.0 : completedLessons / total;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: topic.color,
            child: Icon(topic.icon, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  topic.title,
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
                    backgroundColor: topic.color.withValues(alpha: 0.15),
                    valueColor: AlwaysStoppedAnimation(topic.color),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          Text(
            '$completedLessons/$total',
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: Colors.black54,
            ),
          ),
          if (quizScore != null) ...[
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: topic.color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Quiz $quizScore/$quizTotal',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: topic.color,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
