import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../models/topic.dart';
import '../../theme/app_theme.dart';

enum _LessonPhase { segment, question, correctContinue, tryAgain, complete }

/// Plays a lesson as a sequence of video clips with a question in between.
///
/// What looks like the video "pausing" for a question is actually one clip
/// ending, then a different follow-up clip (correct-continue vs. try-again)
/// starting once the question is answered.
class LessonPlayerScreen extends StatefulWidget {
  const LessonPlayerScreen({super.key, required this.lesson});

  final Lesson lesson;

  @override
  State<LessonPlayerScreen> createState() => _LessonPlayerScreenState();
}

class _LessonPlayerScreenState extends State<LessonPlayerScreen> {
  static const _segmentAsset = 'assets/videos/lesson_segment.mp4';
  static const _correctAsset = 'assets/videos/correct_continue.mp4';
  static const _tryAgainAsset = 'assets/videos/try_again.mp4';

  VideoPlayerController? _controller;
  _LessonPhase _phase = _LessonPhase.segment;
  bool _isLoading = true;
  bool _transitioning = false;
  int? _selectedOptionIndex;

  @override
  void initState() {
    super.initState();
    _loadAndPlay(_segmentAsset);
  }

  Future<void> _loadAndPlay(String asset) async {
    final oldController = _controller;
    setState(() => _isLoading = true);
    _transitioning = false;

    final controller = VideoPlayerController.asset(asset);
    await controller.initialize();
    await oldController?.dispose();

    if (!mounted) {
      await controller.dispose();
      return;
    }

    controller.addListener(_onVideoTick);
    await controller.play();

    setState(() {
      _controller = controller;
      _isLoading = false;
    });
  }

  void _onVideoTick() {
    final controller = _controller;
    if (controller == null || _transitioning) return;
    final value = controller.value;
    if (value.duration > Duration.zero &&
        value.position >= value.duration - const Duration(milliseconds: 200)) {
      _transitioning = true;
      _onClipFinished();
    }
  }

  void _onClipFinished() {
    switch (_phase) {
      case _LessonPhase.segment:
        setState(() => _phase = _LessonPhase.question);
      case _LessonPhase.correctContinue:
        setState(() => _phase = _LessonPhase.complete);
      case _LessonPhase.tryAgain:
        setState(() {
          _phase = _LessonPhase.question;
          _selectedOptionIndex = null;
        });
      case _LessonPhase.question:
      case _LessonPhase.complete:
        break;
    }
  }

  void _answer(int index) {
    if (_phase != _LessonPhase.question) return;
    final correct = index == widget.lesson.question.correctIndex;
    setState(() => _selectedOptionIndex = index);

    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      if (correct) {
        setState(() => _phase = _LessonPhase.correctContinue);
        _loadAndPlay(_correctAsset);
      } else {
        setState(() => _phase = _LessonPhase.tryAgain);
        _loadAndPlay(_tryAgainAsset);
      }
    });
  }

  @override
  void dispose() {
    _controller?.removeListener(_onVideoTick);
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.lesson.title),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (controller != null && controller.value.isInitialized)
              AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: VideoPlayer(controller),
              ),
            if (_isLoading)
              const CircularProgressIndicator(color: Colors.white),
            if (_phase == _LessonPhase.tryAgain && !_isLoading)
              const _StatusBanner(
                text: "Let's try that again!",
                color: AppTheme.quizColor,
              ),
            if (_phase == _LessonPhase.correctContinue && !_isLoading)
              const _StatusBanner(
                text: 'Great job!',
                color: AppTheme.lessonsColor,
              ),
            if (_phase == _LessonPhase.question)
              _QuestionCard(
                question: widget.lesson.question,
                selectedIndex: _selectedOptionIndex,
                onSelect: _answer,
              ),
            if (_phase == _LessonPhase.complete)
              _CompleteCard(onDone: () => Navigator.pop(context)),
          ],
        ),
      ),
    );
  }
}

class _StatusBanner extends StatelessWidget {
  const _StatusBanner({required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 16,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class _QuestionCard extends StatelessWidget {
  const _QuestionCard({
    required this.question,
    required this.selectedIndex,
    required this.onSelect,
  });

  final LessonQuestion question;
  final int? selectedIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 48),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            question.prompt,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 20),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 16,
            runSpacing: 12,
            children: [
              for (var i = 0; i < question.options.length; i++)
                _OptionButton(
                  label: question.options[i],
                  selected: selectedIndex == i,
                  onTap: () => onSelect(i),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _OptionButton extends StatelessWidget {
  const _OptionButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: selected ? AppTheme.lessonsColor : AppTheme.parentColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
    );
  }
}

class _CompleteCard extends StatelessWidget {
  const _CompleteCard({required this.onDone});

  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.celebration_rounded,
            size: 48,
            color: AppTheme.lessonsColor,
          ),
          const SizedBox(height: 12),
          const Text(
            'Lesson Complete!',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onDone,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.lessonsColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: const Text('Back to Lessons'),
          ),
        ],
      ),
    );
  }
}
