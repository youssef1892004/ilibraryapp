// File path: lib/screens/book_details_screen.dart
import 'package:flutter/material.dart';
import 'package:ilibrary_app/models/book.dart';

class BookDetailsScreen extends StatelessWidget {
  // الآن يستقبل كائن الكتاب بالكامل بدلاً من الـ ID
  final Book book;
  const BookDetailsScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [_buildSliverAppBar(book), _buildBookInfo(context, book)],
      ),
    );
  }

  Widget _buildSliverAppBar(Book book) {
    return SliverAppBar(
      expandedHeight: 400.0,
      pinned: true,
      elevation: 4,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 48, vertical: 12),
        centerTitle: true,
        title: Text(
          book.title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            shadows: [Shadow(blurRadius: 10, color: Colors.black)],
          ),
        ),
        background: Image.asset(
          // استخدام الصورة المحلية
          book.coverImageUrl,
          fit: BoxFit.cover,
          color: Colors.black.withOpacity(0.4),
          colorBlendMode: BlendMode.darken,
        ),
      ),
    );
  }

  Widget _buildBookInfo(BuildContext context, Book book) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              book.title,
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'بواسطة: ${book.author}',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: Colors.grey[700]),
            ),
            if (book.publicationDate != null)
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  'تاريخ النشر: ${book.publicationDate}',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                ),
              ),
            const Divider(height: 40, thickness: 1.5),
            Text(
              'عن الكتاب',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              book.description ?? 'لا يوجد وصف متاح لهذا الكتاب.',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(height: 1.7, fontSize: 16),
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.menu_book),
                    label: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text('ابدأ القراءة'),
                    ),
                    style: ElevatedButton.styleFrom(elevation: 5),
                  ),
                ),
                const SizedBox(width: 16),
                IconButton.filledTonal(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite_border),
                  iconSize: 28,
                  padding: const EdgeInsets.all(12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
