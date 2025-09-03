import 'package:flutter/material.dart';
import 'package:ilibrary_app/models/book.dart';

class BookCard extends StatelessWidget {
  final Book book;

  const BookCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120, // عرض البطاقة
      margin: const EdgeInsets.only(right: 12.0), // مسافة بين البطاقات
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // غلاف الكتاب
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(2, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                // سنستخدم صورًا حقيقية من الإنترنت
                child: Image.network(
                  book.coverImageUrl,
                  fit: BoxFit.cover,
                  // لإظهار مؤشر تحميل أثناء تحميل الصورة
                  loadingBuilder:
                      (
                        BuildContext context,
                        Widget child,
                        ImageChunkEvent? loadingProgress,
                      ) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          // عنوان الكتاب
          Text(
            book.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          // اسم المؤلف
          Text(
            book.author,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
