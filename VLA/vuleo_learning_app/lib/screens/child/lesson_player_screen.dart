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
  bool _answered = false;
  int? _selectedOptionIndex;

  @override
  void initState() {
    super.initState();
    _loadAndPlay(_segmentAsset);
  }

  Future<void> _loadAndPlay(String asset) async {
    final oldController = _controller;
    oldController?.removeListener(_onVideoTick);
    _transitioning = false;
    setState(() {
      _controller = null;
      _isLoading = true;
    });
    await oldController?.dispose();

    final controller = VideoPlayerController.asset(asset);
    try {
      await controller.initialize();
      controller.addListener(_onVideoTick);
      await controller.play();
    } catch (_) {
      await controller.dispose();
      if (mounted) setState(() => _isLoading = false);
      return;
    }

    if (!mounted) {
      await controller.dispose();
      return;
    }

    setState(() {
      _controller = controller;
      _isLoading = false;
    });
  }

  void _onVideoTick() {
    final controller = _controller;
    if (controller == null || _transitioning) return;
    final value = controller.value;
    if (value.isBuffering) return;
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
    if (_phase != _LessonPhase.question || _answered) return;
    _answered = true;
    final correct = index == widget.lesson.question.correctIndex;
    setState(() => _selectedOptionIndex = index);

    Future.delayed(const Duration(milliseconds: 500), () {
      _answered = false;
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

  bool get _videoActive =>
      _phase == _LessonPhase.segment ||
      _phase == _LessonPhase.correctContinue ||
      _phase == _LessonPhase.tryAgain;

  @override
  Widget build(BuildContext context) {
    final controller = _controller;
    final showControls =
        controller != null &&
        controller.value.isInitialized &&
        !_isLoading &&
        _videoActive;

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
            if (showControls)
              Positioned(
                left: 16,
                right: 16,
                bottom: 16,
                child: _VideoControls(controller: controller),
              ),
          ],
        ),
      ),
    );
  }
}

/// Play/pause button plus a scrub bar for [controller].
///
/// video_player's own scrub-while-playing gesture is unreliable on the web
/// target (dragging can reset playback to the start), so this pauses before
/// each seek and only resumes once the drag ends — the standard workaround
/// for that platform quirk.
class _VideoControls extends StatefulWidget {
  const _VideoControls({required this.controller});

  final VideoPlayerController controller;

  @override
  State<_VideoControls> createState() => _VideoControlsState();
}

class _VideoControlsState extends State<_VideoControls> {
  bool _wasPlayingBeforeScrub = false;

  void _seek(double milliseconds) {
    widget.controller.seekTo(Duration(milliseconds: milliseconds.round()));
  }

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;
    return ValueListenableBuilder<VideoPlayerValue>(
      valueListenable: controller,
      builder: (context, value, child) {
        final durationMs = value.duration.inMilliseconds.toDouble();
        final positionMs = value.position.inMilliseconds.toDouble().clamp(
          0.0,
          durationMs < 0 ? 0.0 : durationMs,
        );

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.45),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: () =>
                    value.isPlaying ? controller.pause() : controller.play(),
                icon: Icon(
                  value.isPlaying
                      ? Icons.pause_rounded
                      : Icons.play_arrow_rounded,
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: durationMs <= 0
                    ? const SizedBox.shrink()
                    : SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          trackHeight: 4,
                          thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 6,
                          ),
                          overlayShape: const RoundSliderOverlayShape(
                            overlayRadius: 14,
                          ),
                        ),
                        child: Slider(
                          value: positionMs,
                          min: 0,
                          max: durationMs,
                          activeColor: AppTheme.lessonsColor,
                          inactiveColor: Colors.white24,
                          onChangeStart: (_) {
                            _wasPlayingBeforeScrub = value.isPlaying;
                            controller.pause();
                          },
                          onChanged: _seek,
                          onChangeEnd: (newValue) {
                            _seek(newValue);
                            if (_wasPlayingBeforeScrub) controller.play();
                          },
                        ),
                      ),
              ),
            ],
          ),
        );
      },
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
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
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
        backgroundColor: selected
            ? AppTheme.lessonsColor
            : AppTheme.parentColor,
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text('Back to Lessons'),
          ),
        ],
      ),
    );
  }
}
