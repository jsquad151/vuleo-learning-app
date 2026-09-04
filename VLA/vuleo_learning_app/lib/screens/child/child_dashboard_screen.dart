import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';
import '../../theme/app_theme.dart';
import '../../widgets/selection_card.dart';

class ChildDashboardScreen extends StatelessWidget {
  const ChildDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('What do you want to do?')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
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
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutes.childLessons),
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
      ),
    );
  }
}
