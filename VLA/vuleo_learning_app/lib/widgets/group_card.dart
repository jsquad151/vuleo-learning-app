import 'package:flutter/material.dart';

import '../data/students_data.dart';
import '../models/student_group.dart';

class GroupCard extends StatelessWidget {
  const GroupCard({super.key, required this.group, required this.onTap});

  final StudentGroup group;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final members = mockStudents
        .where((student) => group.studentIds.contains(student.id))
        .toList();
    const maxAvatars = 4;

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      elevation: 2,
      shadowColor: Colors.black.withValues(alpha: 0.08),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: group.color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      group.name,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                '${members.length} student${members.length == 1 ? '' : 's'}',
                style: const TextStyle(color: Colors.black54, fontSize: 12),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 32,
                child: Stack(
                  children: [
                    for (
                      var i = 0;
                      i < members.length && i < maxAvatars;
                      i++
                    )
                      Positioned(
                        left: i * 22.0,
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: members[i].avatarColor,
                          child: Icon(
                            members[i].avatarIcon,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    if (members.length > maxAvatars)
                      Positioned(
                        left: maxAvatars * 22.0,
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.black45,
                          child: Text(
                            '+${members.length - maxAvatars}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
