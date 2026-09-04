import 'package:flutter/material.dart';

import '../../models/quiz.dart';
import '../../theme/app_theme.dart';

enum _AnswerState { neutral, correct, incorrect }

class QuizPlayerScreen extends StatefulWidget {
  const QuizPlayerScreen({super.key, required this.quiz});

  final Quiz quiz;

  @override
  State<QuizPlayerScreen> createState() => _QuizPlayerScreenState();
}

class _QuizPlayerScreenState extends State<QuizPlayerScreen> {
  int _index = 0;
  int _score = 0;
  int? _selected;
  bool _answered = false;

  void _select(int optionIndex) {
    if (_answered) return;
    final question = widget.quiz.questions[_index];
    setState(() {
      _selected = optionIndex;
      _answered = true;
      if (optionIndex == question.correctIndex) _score++;
    });
  }

  void _next() {
    setState(() {
      _index++;
      _selected = null;
      _answered = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final quiz = widget.quiz;

    if (_index >= quiz.questions.length) {
      return _QuizResultsView(quiz: quiz, score: _score);
    }

    final question = quiz.questions[_index];

    return Scaffold(
      appBar: AppBar(title: Text(quiz.title)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 12),
          child: Column(
            children: [
              Text(
                'Question ${_index + 1} of ${quiz.questions.length}',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: Colors.black54),
              ),
              const SizedBox(height: 8),
              Text(
                question.prompt,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Expanded(
                child: Center(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 16,
                    runSpacing: 12,
                    children: [
                      for (var i = 0; i < question.options.length; i++)
                        _AnswerButton(
                          label: question.options[i],
                          state: !_answered
                              ? _AnswerState.neutral
                              : i == question.correctIndex
                              ? _AnswerState.correct
                              : i == _selected
                              ? _AnswerState.incorrect
                              : _AnswerState.neutral,
                          color: quiz.color,
                          onTap: () => _select(i),
                        ),
                    ],
                  ),
                ),
              ),
              if (_answered)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: ElevatedButton(
                    onPressed: _next,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: quiz.color,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      _index + 1 < quiz.questions.length
                          ? 'Next'
                          : 'See Results',
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

class _AnswerButton extends StatelessWidget {
  const _AnswerButton({
    required this.label,
    required this.state,
    required this.color,
    required this.onTap,
  });

  final String label;
  final _AnswerState state;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color background;
    switch (state) {
      case _AnswerState.correct:
        background = AppTheme.lessonsColor;
      case _AnswerState.incorrect:
        background = AppTheme.quizColor;
      case _AnswerState.neutral:
        background = color;
    }

    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: background,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
    );
  }
}

class _QuizResultsView extends StatelessWidget {
  const _QuizResultsView({required this.quiz, required this.score});

  final Quiz quiz;
  final int score;

  @override
  Widget build(BuildContext context) {
    final total = quiz.questions.length;
    return Scaffold(
      appBar: AppBar(title: Text(quiz.title)),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.emoji_events_rounded, size: 48, color: quiz.color),
              const SizedBox(height: 12),
              const Text(
                'Quiz Complete!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 8),
              Text(
                'You scored $score out of $total',
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: quiz.color,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text('Back to Quizzes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
