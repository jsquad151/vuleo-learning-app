import 'package:flutter/material.dart';

import '../models/child_badge.dart';
import 'badge_card.dart';

/// The badge list, driven by whichever child's badges are passed in —
/// reused by the child's own Badges tab and by the parent/teacher per-child
/// Badges tab.
class ChildBadgesView extends StatelessWidget {
  const ChildBadgesView({super.key, required this.badges});

  final List<ChildBadge> badges;

  @override
  Widget build(BuildContext context) {
    if (badges.isEmpty) {
      return const Center(
        child: Text(
          'No badges earned yet — keep learning!',
          style: TextStyle(color: Colors.black54),
        ),
      );
    }

    return ListView.separated(
      itemCount: badges.length,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) => BadgeCard(badge: badges[index]),
    );
  }
}
