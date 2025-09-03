// File path: lib/models/book.dart
class Book {
  final String id;
  final String title;
  final String author;
  final String coverImageUrl;
  final String? description;
  final String? publicationDate;
  final int likes;
  final int comments;
  final int shares;
  // --- ✅ الحقول الجديدة التي كانت مفقودة ---
  final String? videoUrl;
  final String? audioUrl;

  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.coverImageUrl,
    this.description,
    this.publicationDate,
    this.likes = 0,
    this.comments = 0,
    this.shares = 0,
    // --- ✅ تمت إضافتها هنا أيضًا ---
    this.videoUrl,
    this.audioUrl,
  });
}
