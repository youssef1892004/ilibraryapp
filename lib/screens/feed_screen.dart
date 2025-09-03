// File path: lib/screens/feed_screen.dart
import 'package:flutter/material.dart';
import 'package:ilibrary_app/models/book.dart';
import 'package:ilibrary_app/widgets/video_player_item.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  final List<Book> staticBooks = const [
    Book(
      id: '1',
      title: 'فيديو محلي',
      author: 'المكتبة الرقمية',
      coverImageUrl: 'assets/images/1.png',
      videoUrl: 'assets/videos/1.mp4',
    ),
    Book(
      id: '2',
      title: 'صوت فقط',
      author: 'علي بن جابر الفيفي',
      coverImageUrl: 'assets/images/2.png',
      audioUrl: 'assets/audio/1.mp3',
    ),
    Book(
      id: '3',
      title: 'فيديو من الإنترنت (تجريبي)',
      author: 'فريق فلاتر',
      coverImageUrl: 'assets/images/3.png',
      videoUrl:
          'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: staticBooks.length,
        itemBuilder: (context, index) {
          return VideoPlayerItem(book: staticBooks[index]);
        },
      ),
    );
  }
}
