import '../models/quiz.dart';
import 'lessons_data.dart';
import 'progress_data.dart';

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
        questions: topicQuestions[topic.id] ?? const [],
      ),
    )
    .toList();
