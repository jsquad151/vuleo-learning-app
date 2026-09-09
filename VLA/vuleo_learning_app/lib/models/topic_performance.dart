import 'topic.dart';

/// How a child is doing on one topic, derived from their lesson completion
/// and quiz score.
enum PerformanceLevel { notStarted, needsPractice, onTrack, excelling }

/// A child's computed standing on one topic — drives the "needs practice" /
/// "excelling" suggestions on the child's homepage, and the status shown to
/// parents and teachers on that child's profile.
class TopicPerformance {
  const TopicPerformance({
    required this.topic,
    required this.level,
    required this.completedLessons,
    required this.totalLessons,
    this.quizScore,
    this.quizTotal,
  });

  final Topic topic;
  final PerformanceLevel level;
  final int completedLessons;
  final int totalLessons;
  final int? quizScore;
  final int? quizTotal;

  bool get hasQuizScore => quizScore != null && quizTotal != null;

  /// A short explanation of why this topic landed at its level, e.g. for
  /// display alongside the level badge.
  String get detail {
    if (level == PerformanceLevel.notStarted) {
      return 'No lessons started yet in ${topic.title}.';
    }
    if (hasQuizScore) {
      switch (level) {
        case PerformanceLevel.needsPractice:
          return 'Scored $quizScore/$quizTotal on the quiz — could use more practice.';
        case PerformanceLevel.excelling:
          return 'Scored $quizScore/$quizTotal on the quiz — excellent work!';
        case PerformanceLevel.onTrack:
        case PerformanceLevel.notStarted:
          return 'Scored $quizScore/$quizTotal on the quiz — solid progress.';
      }
    }
    return '$completedLessons/$totalLessons lessons complete — quiz not taken yet.';
  }

  /// What to do next, shown as the actionable suggestion for this topic.
  String get suggestion {
    switch (level) {
      case PerformanceLevel.notStarted:
        return 'Start the ${topic.title} lessons.';
      case PerformanceLevel.needsPractice:
        return 'Review the ${topic.title} lessons, then retake the quiz.';
      case PerformanceLevel.onTrack:
        return completedLessons >= totalLessons
            ? 'Take the ${topic.title} quiz to test what you\'ve learned.'
            : 'Keep going with the next ${topic.title} lesson.';
      case PerformanceLevel.excelling:
        return 'Keep it up in ${topic.title}!';
    }
  }
}
