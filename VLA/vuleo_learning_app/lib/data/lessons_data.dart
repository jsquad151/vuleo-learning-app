import 'package:flutter/material.dart';

import '../models/topic.dart';
import '../theme/app_theme.dart';

// Every lesson shares this demo question for now, since we don't have real
// per-lesson quiz content yet — it exists to exercise the branching
// video-pause-question-continue mechanic end to end.
const _demoQuestion = LessonQuestion(
  prompt: 'Ready to continue?',
  options: ["Yes, let's go!", 'Not yet'],
  correctIndex: 0,
);

List<Lesson> _lessons(String topicId, List<String> subtitles) {
  return List.generate(
    subtitles.length,
    (i) => Lesson(
      id: '$topicId-${i + 1}',
      title: 'Lesson ${i + 1}',
      subtitle: subtitles[i],
      question: _demoQuestion,
    ),
  );
}

final List<Topic> mockTopics = [
  Topic(
    id: 'numbers',
    title: 'Numbers & Counting',
    icon: Icons.pin_rounded,
    color: AppTheme.topicColors[0],
    lessons: _lessons('numbers', [
      'Counting 1 to 5',
      'Counting 6 to 10',
      'Number Shapes',
      'Bigger or Smaller',
      'Counting Objects',
      'Simple Addition',
      'Simple Subtraction',
      'Counting to 20',
      'Number Patterns',
    ]),
  ),
  Topic(
    id: 'letters',
    title: 'Letters & Phonics',
    icon: Icons.abc_rounded,
    color: AppTheme.topicColors[1],
    lessons: _lessons('letters', [
      'The Alphabet Song',
      'Letters A to E',
      'Letters F to J',
      'Letters K to O',
      'Letters P to T',
      'Letters U to Z',
      'Vowel Sounds',
      'Blending Sounds',
      'My First Words',
    ]),
  ),
  Topic(
    id: 'shapes',
    title: 'Shapes & Colors',
    icon: Icons.category_rounded,
    color: AppTheme.topicColors[2],
    lessons: _lessons('shapes', [
      'Circles and Squares',
      'Triangles and Rectangles',
      'Ovals and Stars',
      'Primary Colors',
      'Mixing Colors',
      'Shapes Around Us',
      'Big and Small Shapes',
      'Patterns with Shapes',
      'Shape Matching',
    ]),
  ),
  Topic(
    id: 'science',
    title: 'Science Explorers',
    icon: Icons.science_rounded,
    color: AppTheme.topicColors[3],
    lessons: _lessons('science', [
      'Animals Around Us',
      'Plants and Trees',
      'The Five Senses',
      'Weather and Seasons',
      'Day and Night',
      'Floating and Sinking',
      'Hot and Cold',
      'The Solar System',
      'Taking Care of Earth',
    ]),
  ),
  Topic(
    id: 'life-skills',
    title: 'Everyday Skills',
    icon: Icons.emoji_people_rounded,
    color: AppTheme.topicColors[4],
    lessons: _lessons('life-skills', [
      'Washing Hands',
      'Getting Dressed',
      'Healthy Eating',
      'Being Kind',
      'Sharing and Taking Turns',
      'Saying Please and Thank You',
      'Staying Safe',
      'Cleaning Up',
      'Working Together',
    ]),
  ),
];
