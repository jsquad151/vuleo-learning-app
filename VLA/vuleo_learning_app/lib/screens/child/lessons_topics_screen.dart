import 'package:flutter/material.dart';

import '../../data/lessons_data.dart';
import '../../widgets/topic_card.dart';
import 'topic_lessons_screen.dart';

class LessonsTopicsScreen extends StatelessWidget {
  const LessonsTopicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choose a Topic')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.0,
            ),
            itemCount: mockTopics.length,
            itemBuilder: (context, index) {
              final topic = mockTopics[index];
              return TopicCard(
                topic: topic,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TopicLessonsScreen(topic: topic),
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
