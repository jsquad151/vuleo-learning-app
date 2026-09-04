import 'package:flutter/material.dart';

import '../data/lessons_data.dart';
import '../models/child_profile.dart';

class ChildProfileCard extends StatelessWidget {
  const ChildProfileCard({super.key, required this.child, required this.onTap});

  final ChildProfile child;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final completed = child.completedLessonsByTopic.values.fold<int>(
      0,
      (sum, v) => sum + v,
    );
    final total = mockTopics.fold<int>(
      0,
      (sum, topic) => sum + topic.lessons.length,
    );

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      elevation: 3,
      shadowColor: Colors.black.withValues(alpha: 0.1),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 32,
                backgroundColor: child.avatarColor,
                child: Icon(child.avatarIcon, color: Colors.white, size: 32),
              ),
              const SizedBox(height: 12),
              Text(
                child.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$completed/$total lessons complete',
                style: const TextStyle(color: Colors.black54, fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
