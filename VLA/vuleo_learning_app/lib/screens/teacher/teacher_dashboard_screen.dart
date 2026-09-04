import 'package:flutter/material.dart';

import '../../data/groups_data.dart';
import '../../models/student_group.dart';
import '../../theme/app_theme.dart';
import 'group_detail_screen.dart';
import 'groups_tab.dart';
import 'metrics_tab.dart';

class TeacherDashboardScreen extends StatefulWidget {
  const TeacherDashboardScreen({super.key});

  @override
  State<TeacherDashboardScreen> createState() =>
      _TeacherDashboardScreenState();
}

class _TeacherDashboardScreenState extends State<TeacherDashboardScreen> {
  final List<StudentGroup> _groups = buildMockGroups();

  void _addGroup(String name) {
    setState(() {
      final color =
          AppTheme.topicColors[_groups.length % AppTheme.topicColors.length];
      _groups.add(
        StudentGroup(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          name: name,
          color: color,
        ),
      );
    });
  }

  Future<void> _openGroup(StudentGroup group) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GroupDetailScreen(group: group)),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Teacher Dashboard'),
          bottom: const TabBar(
            labelColor: AppTheme.teacherColor,
            unselectedLabelColor: Colors.black54,
            indicatorColor: AppTheme.teacherColor,
            tabs: [Tab(text: 'Metrics'), Tab(text: 'Groups')],
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: TabBarView(
              children: [
                const MetricsTab(),
                GroupsTab(
                  groups: _groups,
                  onAddGroup: _addGroup,
                  onOpenGroup: _openGroup,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
