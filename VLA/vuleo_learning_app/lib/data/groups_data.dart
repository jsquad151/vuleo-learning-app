import '../models/student_group.dart';
import '../theme/app_theme.dart';

/// Seed data for a fresh session — the teacher screen keeps its own mutable
/// copy so edits during the session don't rewrite this constant list.
List<StudentGroup> buildMockGroups() => [
  StudentGroup(
    id: 'g1',
    name: 'Morning Class',
    color: AppTheme.topicColors[0],
    studentIds: ['emma', 'liam', 'olivia'],
  ),
  StudentGroup(
    id: 'g2',
    name: 'Afternoon Class',
    color: AppTheme.topicColors[1],
    studentIds: ['noah', 'ava', 'mason'],
  ),
];
