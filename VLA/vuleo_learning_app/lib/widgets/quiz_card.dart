import 'package:flutter/material.dart';

import '../models/quiz.dart';

class QuizCard extends StatelessWidget {
  const QuizCard({super.key, required this.quiz, required this.onTap});

  final Quiz quiz;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final locked = !quiz.unlocked;
    return Material(
      color: locked ? Colors.blueGrey.shade300 : quiz.color,
      borderRadius: BorderRadius.circular(24),
      elevation: locked ? 0 : 4,
      shadowColor: quiz.color.withValues(alpha: 0.4),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                locked ? Icons.lock_rounded : quiz.icon,
                size: 36,
                color: Colors.white,
              ),
              const SizedBox(height: 8),
              Text(
                quiz.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                locked ? 'Locked' : '${quiz.questions.length} questions',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.85),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
