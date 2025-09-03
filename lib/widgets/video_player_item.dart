// File path: lib/widgets/video_player_item.dart
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:ilibrary_app/models/book.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerItem extends StatefulWidget {
  final Book book;
  const VideoPlayerItem({super.key, required this.book});

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;
  bool _isInitialized = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    if (widget.book.videoUrl != null && widget.book.videoUrl!.isNotEmpty) {
      _initializeVideoPlayer();
    } else {
      setState(() => _isInitialized = true);
    }
  }

  Future<void> _initializeVideoPlayer() async {
    try {
      if (widget.book.videoUrl!.startsWith('http')) {
        _videoController =
            VideoPlayerController.networkUrl(Uri.parse(widget.book.videoUrl!));
      } else {
        _videoController = VideoPlayerController.asset(widget.book.videoUrl!);
      }

      await _videoController!.initialize();
      _chewieController = ChewieController(
        videoPlayerController: _videoController!,
        autoPlay: true,
        looping: true,
        showControls: false,
        aspectRatio: _videoController!.value.aspectRatio,
      );
    } catch (e) {
      print(
          "Error initializing video player for '${widget.book.videoUrl}': $e");
      if (mounted) {
        setState(() {
          _error = "لا يمكن تشغيل هذا الفيديو.";
        });
      }
    }

    if (mounted) setState(() => _isInitialized = true);
  }

  @override
  void dispose() {
    _videoController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Center(
          child: CircularProgressIndicator(color: Colors.white));
    }

    if (_error != null) {
      return _buildErrorWidget();
    }

    if (_chewieController != null &&
        _chewieController!.videoPlayerController.value.isInitialized) {
      return Chewie(controller: _chewieController!);
    }

    // Fallback to showing the cover image
    return Image.asset(widget.book.coverImageUrl, fit: BoxFit.cover);
  }

  Widget _buildErrorWidget() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(widget.book.coverImageUrl, fit: BoxFit.cover),
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(_error!,
                style: const TextStyle(color: Colors.white, fontSize: 16)),
          ),
        ),
      ],
    );
  }
}
