import 'dart:async';
import 'package:better_player_enhanced/better_player.dart';
import 'package:flutter/material.dart';
import 'package:ilibrary_app/models/book.dart';

class MediaPlayerItem extends StatefulWidget {
  final Book book;
  final BetterPlayerController controller;
  final bool isVisible;

  const MediaPlayerItem({
    super.key,
    required this.book,
    required this.controller,
    required this.isVisible,
  });

  @override
  State<MediaPlayerItem> createState() => _MediaPlayerItemState();
}

class _MediaPlayerItemState extends State<MediaPlayerItem> {
  bool _showPlayPauseIcon = false;
  Timer? _iconVisibilityTimer;
  bool _isPlaying = false;
  final StreamController<BetterPlayerEvent> _eventController =
      StreamController.broadcast();

  @override
  void initState() {
    super.initState();
    widget.controller.addEventsListener(_onBetterPlayerEvent);
    _syncPlaybackState();
  }

  void _onBetterPlayerEvent(BetterPlayerEvent event) {
    if (mounted) {
      _eventController.add(event);
      if (event.betterPlayerEventType == BetterPlayerEventType.play) {
        if (!_isPlaying) setState(() => _isPlaying = true);
      } else if (event.betterPlayerEventType == BetterPlayerEventType.pause) {
        if (_isPlaying) setState(() => _isPlaying = false);
      }
    }
  }

  @override
  void didUpdateWidget(covariant MediaPlayerItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isVisible != oldWidget.isVisible) {
      _syncPlaybackState();
    }
  }

  void _syncPlaybackState() {
    if (widget.isVisible) {
      widget.controller.play();
    } else {
      widget.controller.pause();
    }
  }

  void _togglePlayback() {
    if (widget.controller.isPlaying() ?? false) {
      widget.controller.pause();
    } else {
      widget.controller.play();
    }
    _showTemporaryIcon();
  }

  void _showTemporaryIcon() {
    setState(() => _showPlayPauseIcon = true);
    _iconVisibilityTimer?.cancel();
    _iconVisibilityTimer = Timer(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() => _showPlayPauseIcon = false);
      }
    });
  }

  @override
  void dispose() {
    widget.controller.removeEventsListener(_onBetterPlayerEvent);
    _eventController.close();
    _iconVisibilityTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _togglePlayback,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _buildMediaPlayer(),
          _buildPlayPauseOverlay(),
          _buildProgressBar(),
        ],
      ),
    );
  }

  Widget _buildMediaPlayer() {
    return widget.book.videoUrl != null
        ? BetterPlayer(controller: widget.controller)
        : Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(widget.book.coverImageUrl),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(color: Colors.black.withOpacity(0.2)),
          );
  }

  Widget _buildPlayPauseOverlay() {
    return AnimatedOpacity(
      opacity: _showPlayPauseIcon ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
        child: Icon(
          _isPlaying ? Icons.pause : Icons.play_arrow,
          color: Colors.white,
          size: 60,
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: StreamBuilder<BetterPlayerEvent>(
        stream: _eventController.stream,
        builder: (context, snapshot) {
          final event = snapshot.data;
          if (event?.betterPlayerEventType != BetterPlayerEventType.progress) {
            return const SizedBox.shrink();
          }
          final position =
              event?.parameters?['progress'] as Duration? ?? Duration.zero;
          final duration =
              event?.parameters?['duration'] as Duration? ?? Duration.zero;

          double progress = 0.0;
          if (position.inMilliseconds > 0 && duration.inMilliseconds > 0) {
            progress = position.inMilliseconds / duration.inMilliseconds;
          }

          return LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.white12,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            minHeight: 2,
          );
        },
      ),
    );
  }
}
