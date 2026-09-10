import 'package:flutter/material.dart';

import '../models/topic.dart';
import '../theme/app_theme.dart';

// Each topic's question bank, used both for the video-pause question in its
// lessons (cycled across lessons so the video mechanic exercises real
// topic content) and for that topic's end-of-lessons quiz — see
// quizzes_data.dart.
const topicQuestions = <String, List<LessonQuestion>>{
  'numbers': [
    LessonQuestion(
      prompt: 'What number comes after 3?',
      options: ['4', '2', '6'],
      correctIndex: 0,
    ),
    LessonQuestion(
      prompt: 'How many fingers are on one hand?',
      options: ['3', '5', '10'],
      correctIndex: 1,
    ),
    LessonQuestion(
      prompt: 'Which number is bigger?',
      options: ['4', '7'],
      correctIndex: 1,
    ),
    LessonQuestion(
      prompt: 'What is 2 + 2?',
      options: ['3', '5', '4'],
      correctIndex: 2,
    ),
    LessonQuestion(
      prompt: 'Which number is the smallest?',
      options: ['9', '5', '1'],
      correctIndex: 2,
    ),
  ],
  'letters': [
    LessonQuestion(
      prompt: "What letter comes after 'A'?",
      options: ['C', 'B', 'D'],
      correctIndex: 1,
    ),
    LessonQuestion(
      prompt: 'Which letter is a vowel?',
      options: ['B', 'E', 'T'],
      correctIndex: 1,
    ),
    LessonQuestion(
      prompt: "What sound does 'S' make?",
      options: ['sss', 'buh', 'muh'],
      correctIndex: 0,
    ),
    LessonQuestion(
      prompt: "Which word starts with 'C'?",
      options: ['Dog', 'Sun', 'Cat'],
      correctIndex: 2,
    ),
    LessonQuestion(
      prompt: 'How many letters are in the alphabet?',
      options: ['20', '26', '30'],
      correctIndex: 1,
    ),
  ],
  'shapes': [
    LessonQuestion(
      prompt: 'Which shape has 3 sides?',
      options: ['Circle', 'Triangle', 'Square'],
      correctIndex: 1,
    ),
    LessonQuestion(
      prompt: 'What color do blue and yellow make?',
      options: ['Green', 'Purple', 'Orange'],
      correctIndex: 0,
    ),
    LessonQuestion(
      prompt: 'Which shape is round?',
      options: ['Square', 'Triangle', 'Circle'],
      correctIndex: 2,
    ),
    LessonQuestion(
      prompt: 'How many sides does a square have?',
      options: ['3', '4', '5'],
      correctIndex: 1,
    ),
    LessonQuestion(
      prompt: 'What color is the sun?',
      options: ['Blue', 'Yellow', 'Purple'],
      correctIndex: 1,
    ),
  ],
  'science': [
    LessonQuestion(
      prompt: 'What do plants need to grow?',
      options: ['Water and sunlight', 'Candy', 'Rocks'],
      correctIndex: 0,
    ),
    LessonQuestion(
      prompt: 'Which animal lives in water?',
      options: ['Dog', 'Fish', 'Bird'],
      correctIndex: 1,
    ),
    LessonQuestion(
      prompt: 'What comes after day?',
      options: ['Night', 'Morning', 'Noon'],
      correctIndex: 0,
    ),
    LessonQuestion(
      prompt: 'Which season is the coldest?',
      options: ['Summer', 'Winter', 'Spring'],
      correctIndex: 1,
    ),
    LessonQuestion(
      prompt: 'What do we use to see?',
      options: ['Ears', 'Nose', 'Eyes'],
      correctIndex: 2,
    ),
  ],
  'life-skills': [
    LessonQuestion(
      prompt: 'What should you do before eating?',
      options: ['Wash your hands', 'Jump around', 'Watch TV'],
      correctIndex: 0,
    ),
    LessonQuestion(
      prompt: 'What do you say when someone helps you?',
      options: ['Goodbye', 'Thank you', 'Nothing'],
      correctIndex: 1,
    ),
    LessonQuestion(
      prompt: 'What should you do with toys after playing?',
      options: ['Leave them', 'Hide them', 'Clean up'],
      correctIndex: 2,
    ),
    LessonQuestion(
      prompt: "What do you wear when it's cold?",
      options: ['A jacket', 'Shorts', 'Sandals'],
      correctIndex: 0,
    ),
    LessonQuestion(
      prompt: 'How do we stay safe crossing the street?',
      options: ['Run fast', 'Look both ways', 'Close your eyes'],
      correctIndex: 1,
    ),
  ],
};

List<Lesson> _lessons(String topicId, List<String> subtitles) {
  final questions = topicQuestions[topicId] ?? const [];
  return List.generate(
    subtitles.length,
    (i) => Lesson(
      id: '$topicId-${i + 1}',
      title: 'Lesson ${i + 1}',
      subtitle: subtitles[i],
      question: questions[i % questions.length],
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
