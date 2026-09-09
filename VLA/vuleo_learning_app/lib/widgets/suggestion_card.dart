import 'package:flutter/material.dart';

import '../models/topic_performance.dart';
import 'performance_level_style.dart';

/// A single actionable suggestion on the child's homepage, prompting them
/// toward a topic that needs attention.
class SuggestionCard extends StatelessWidget {
  const SuggestionCard({
    super.key,
    required this.performance,
    required this.onTap,
  });

  final TopicPerformance performance;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final topic = performance.topic;
    final level = performance.level;

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      elevation: 2,
      shadowColor: Colors.black.withValues(alpha: 0.1),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: topic.color.withValues(alpha: 0.15),
                child: Icon(topic.icon, color: topic.color, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(level.icon, size: 13, color: level.color),
                        const SizedBox(width: 4),
                        Text(
                          level.label,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 11,
                            color: level.color,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      topic.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      performance.suggestion,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: Colors.black26),
            ],
          ),
        ),
      ),
    );
  }
}
