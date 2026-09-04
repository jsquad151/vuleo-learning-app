import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'routes/app_routes.dart';
import 'screens/child/child_dashboard_screen.dart';
import 'screens/child/lessons_topics_screen.dart';
import 'screens/child/quiz_list_screen.dart';
import 'screens/child/stats_screen.dart';
import 'screens/parent/parent_dashboard_screen.dart';
import 'screens/role_selection_screen.dart';
import 'screens/teacher/teacher_dashboard_screen.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(const VuleoApp());
}

class VuleoApp extends StatelessWidget {
  const VuleoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vuleo Learning',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: AppRoutes.roleSelection,
      routes: {
        AppRoutes.roleSelection: (context) => const RoleSelectionScreen(),
        AppRoutes.childDashboard: (context) => const ChildDashboardScreen(),
        AppRoutes.childQuiz: (context) => const QuizListScreen(),
        AppRoutes.childLessons: (context) => const LessonsTopicsScreen(),
        AppRoutes.childStats: (context) => const StatsScreen(),
        AppRoutes.parentDashboard: (context) => const ParentDashboardScreen(),
        AppRoutes.teacherDashboard: (context) =>
            const TeacherDashboardScreen(),
      },
    );
  }
}
