import '../models/quiz.dart';
import '../models/topic.dart';
import '../models/topic_performance.dart';
import 'lessons_data.dart';
import 'quizzes_data.dart';

/// Derives each topic's [TopicPerformance] from a child's raw progress maps
/// — the same maps [ChildStatsView] is driven by, so this reflects whichever
/// child's data is passed in.
List<TopicPerformance> computeTopicPerformance(
  Map<String, int> completedLessonsByTopic,
  Map<String, int> quizScoresByTopic,
) {
  return [
    for (var i = 0; i < mockTopics.length; i++)
      _performanceFor(
        mockTopics[i],
        mockQuizzes[i],
        completedLessonsByTopic,
        quizScoresByTopic,
      ),
  ];
}

TopicPerformance _performanceFor(
  Topic topic,
  Quiz quiz,
  Map<String, int> completedLessonsByTopic,
  Map<String, int> quizScoresByTopic,
) {
  final completed = completedLessonsByTopic[topic.id] ?? 0;
  final total = topic.lessons.length;
  final quizScore = quizScoresByTopic[topic.id];
  final quizTotal = quiz.questions.length;

  final PerformanceLevel level;
  if (completed == 0) {
    level = PerformanceLevel.notStarted;
  } else if (quizScore != null && quizTotal > 0) {
    final fraction = quizScore / quizTotal;
    if (fraction < 0.6) {
      level = PerformanceLevel.needsPractice;
    } else if (fraction >= 0.8) {
      level = PerformanceLevel.excelling;
    } else {
      level = PerformanceLevel.onTrack;
    }
  } else {
    level = PerformanceLevel.onTrack;
  }

  return TopicPerformance(
    topic: topic,
    level: level,
    completedLessons: completed,
    totalLessons: total,
    quizScore: quizScore,
    quizTotal: quizScore == null ? null : quizTotal,
  );
}
