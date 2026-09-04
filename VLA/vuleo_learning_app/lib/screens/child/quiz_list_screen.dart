import 'package:flutter/material.dart';

import '../../data/quizzes_data.dart';
import '../../widgets/quiz_card.dart';
import 'quiz_player_screen.dart';

class QuizListScreen extends StatelessWidget {
  const QuizListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choose a Quiz')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.0,
            ),
            itemCount: mockQuizzes.length,
            itemBuilder: (context, index) {
              final quiz = mockQuizzes[index];
              return QuizCard(
                quiz: quiz,
                onTap: () {
                  if (!quiz.unlocked) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Complete more lessons to unlock this quiz!',
                        ),
                      ),
                    );
                    return;
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizPlayerScreen(quiz: quiz),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
