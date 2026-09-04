import '../models/quiz.dart';
import '../models/topic.dart';
import 'lessons_data.dart';
import 'progress_data.dart';

const _quizQuestions = <String, List<LessonQuestion>>{
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

final List<Quiz> mockQuizzes = mockTopics
    .map(
      (topic) => Quiz(
        id: '${topic.id}-quiz',
        title: '${topic.title} Quiz',
        icon: topic.icon,
        color: topic.color,
        unlocked:
            (mockCompletedLessonsByTopic[topic.id] ?? 0) >=
            topic.lessons.length,
        questions: _quizQuestions[topic.id] ?? const [],
      ),
    )
    .toList();
