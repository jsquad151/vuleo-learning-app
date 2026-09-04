import 'package:flutter/material.dart';

import '../../data/children_data.dart';
import '../../widgets/child_profile_card.dart';
import 'child_detail_screen.dart';

class ParentDashboardScreen extends StatelessWidget {
  const ParentDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Children')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          child: Row(
            children: [
              for (var i = 0; i < mockChildren.length; i++) ...[
                if (i > 0) const SizedBox(width: 20),
                Expanded(
                  child: ChildProfileCard(
                    child: mockChildren[i],
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ChildDetailScreen(child: mockChildren[i]),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
