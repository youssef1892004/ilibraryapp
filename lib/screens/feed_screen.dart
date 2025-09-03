import 'package:better_player_enhanced/better_player.dart';
import 'package:flutter/material.dart';
import 'package:ilibrary_app/models/book.dart';
import 'package:ilibrary_app/widgets/video_player_item.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final List<Book> staticBooks = const [
    Book(
      id: '1',
      title: 'فيديو محلي',
      author: 'المكتبة الرقمية',
      coverImageUrl: 'assets/images/1.jpg',
      videoUrl: 'assets/videos/1.mp4',
    ),
    Book(
      id: '2',
      title: 'صوت فقط',
      author: 'علي بن جابر الفيفي',
      coverImageUrl: 'assets/images/2.png',
      videoUrl:
          'https://res.cloudinary.com/dqd7mlvat/video/upload/v1756754270/video_2025-09-01_21-42-07_tcfarc.mp4',
    ),
    Book(
      id: '3',
      title: 'فيديو من Cloudinary',
      author: 'مصدر سحابي',
      coverImageUrl: 'assets/images/3.png',
      videoUrl:
          'https://res.cloudinary.com/dqd7mlvat/video/upload/v1756754329/video_2025-09-01_21-42-00_hndszo.mp4',
    ),
    Book(
      id: '4',
      title: 'فيديو آخر من Cloudinary',
      author: 'مصدر سحابي',
      coverImageUrl: 'assets/images/4.png',
      videoUrl:
          'https://res.cloudinary.com/dqd7mlvat/video/upload/v1756754344/video_2025-09-01_21-41-52_pykrnc.mp4',
    ),
    Book(
      id: '5',
      title: 'فيديو آخر من Cloudinary',
      author: 'مصدر سحابي',
      coverImageUrl: 'assets/images/4.png',
      videoUrl:
          'https://res.cloudinary.com/dqd7mlvat/video/upload/v1756754325/video_2025-09-01_21-41-40_h9xjui.mp4',
    ),
  ];

  late PageController _pageController;
  final Map<int, BetterPlayerController> _controllers = {};
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _preInitializeController(0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _controllers.forEach((_, controller) => controller.dispose());
    super.dispose();
  }

  BetterPlayerConfiguration _createConfiguration(Book book) {
    return BetterPlayerConfiguration(
      autoPlay: false,
      looping: true,
      controlsConfiguration: BetterPlayerControlsConfiguration(
        showControls: false, // نخفي الواجهة الافتراضية
      ),
    );
  }

  Future<void> _initializeController(int index) async {
    if (index < 0 ||
        index >= staticBooks.length ||
        _controllers.containsKey(index)) return;

    final book = staticBooks[index];
    BetterPlayerDataSource? dataSource;

    if (book.videoUrl != null) {
      dataSource = book.videoUrl!.startsWith('http')
          ? BetterPlayerDataSource(
              BetterPlayerDataSourceType.network, book.videoUrl!)
          : BetterPlayerDataSource(
              BetterPlayerDataSourceType.file, book.videoUrl!);
    } else if (book.audioUrl != null) {
      dataSource = book.audioUrl!.startsWith('http')
          ? BetterPlayerDataSource(
              BetterPlayerDataSourceType.network, book.audioUrl!,
              notificationConfiguration: BetterPlayerNotificationConfiguration(
                showNotification: true,
                title: book.title,
                author: book.author,
                imageUrl: book.coverImageUrl,
              ))
          : BetterPlayerDataSource(
              BetterPlayerDataSourceType.file, book.audioUrl!,
              notificationConfiguration: BetterPlayerNotificationConfiguration(
                  showNotification: false));
    }

    if (dataSource != null) {
      final controller = BetterPlayerController(
        _createConfiguration(book),
        betterPlayerDataSource: dataSource,
      );
      _controllers[index] = controller;
      if (mounted) setState(() {});
    }
  }

  void _preInitializeController(int newIndex) {
    _initializeController(newIndex);
    _initializeController(newIndex + 1);
    _disposeController(newIndex - 2);
  }

  void _disposeController(int index) {
    if (_controllers.containsKey(index)) {
      _controllers[index]?.dispose(forceDispose: true);
      _controllers.remove(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: staticBooks.length,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
          _preInitializeController(index);
        },
        itemBuilder: (context, index) {
          final controller = _controllers[index];
          if (controller == null) {
            return Container(
              color: Colors.black,
              alignment: Alignment.center,
              child: const CircularProgressIndicator(color: Colors.white),
            );
          }
          return MediaPlayerItem(
            book: staticBooks[index],
            controller: controller,
            isVisible: index == _currentPage,
          );
        },
      ),
    );
  }
}
