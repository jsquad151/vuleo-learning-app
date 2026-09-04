// Mock progress data. There's no persistence yet, so this stands in for a
// child's real lesson/quiz history — the Stats screen displays it, and the
// Quiz section uses it to decide which quizzes are unlocked.

/// Lessons completed per topic id, out of that topic's total lesson count.
const Map<String, int> mockCompletedLessonsByTopic = {
  'numbers': 9,
  'letters': 9,
  'shapes': 4,
  'science': 0,
  'life-skills': 0,
};

/// Most recent quiz score (correct answers) per topic id, for quizzes
/// already taken. A topic with no entry hasn't had its quiz attempted.
const Map<String, int> mockQuizScoresByTopic = {'numbers': 4, 'letters': 5};
