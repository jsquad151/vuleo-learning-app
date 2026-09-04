import 'package:flutter/material.dart';

import '../../data/students_data.dart';
import '../../models/student_group.dart';

class GroupDetailScreen extends StatefulWidget {
  const GroupDetailScreen({super.key, required this.group});

  final StudentGroup group;

  @override
  State<GroupDetailScreen> createState() => _GroupDetailScreenState();
}

class _GroupDetailScreenState extends State<GroupDetailScreen> {
  void _toggle(String studentId, bool selected) {
    setState(() {
      if (selected) {
        widget.group.studentIds.add(studentId);
      } else {
        widget.group.studentIds.remove(studentId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.group.name)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: ListView.separated(
            itemCount: mockStudents.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final student = mockStudents[index];
              final selected = widget.group.studentIds.contains(student.id);
              return Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                child: CheckboxListTile(
                  value: selected,
                  onChanged: (value) => _toggle(student.id, value ?? false),
                  activeColor: widget.group.color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  secondary: CircleAvatar(
                    backgroundColor: student.avatarColor,
                    child: Icon(student.avatarIcon, color: Colors.white),
                  ),
                  title: Text(
                    student.name,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
