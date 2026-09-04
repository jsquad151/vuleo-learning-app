import 'package:flutter/material.dart';

import '../../models/student_group.dart';
import '../../theme/app_theme.dart';
import '../../widgets/group_card.dart';

class GroupsTab extends StatelessWidget {
  const GroupsTab({
    super.key,
    required this.groups,
    required this.onAddGroup,
    required this.onOpenGroup,
  });

  final List<StudentGroup> groups;
  final ValueChanged<String> onAddGroup;
  final ValueChanged<StudentGroup> onOpenGroup;

  Future<void> _showAddGroupDialog(BuildContext context) async {
    final controller = TextEditingController();
    final name = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New Group'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Group name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.teacherColor,
              foregroundColor: Colors.white,
            ),
            child: const Text('Create'),
          ),
        ],
      ),
    );
    if (name != null && name.isNotEmpty) {
      onAddGroup(name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton.icon(
            onPressed: () => _showAddGroupDialog(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.teacherColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            icon: const Icon(Icons.add),
            label: const Text('New Group'),
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: groups.isEmpty
              ? const Center(
                  child: Text(
                    'No groups yet — create one to get started.',
                    style: TextStyle(color: Colors.black54),
                  ),
                )
              : GridView.builder(
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 1.0,
                      ),
                  itemCount: groups.length,
                  itemBuilder: (context, index) {
                    final group = groups[index];
                    return GroupCard(
                      group: group,
                      onTap: () => onOpenGroup(group),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
