// File path: lib/widgets/video_player_item.dart
import 'package:flutter/material.dart';
import 'package:ilibrary_app/models/book.dart';

class FeedItem extends StatelessWidget {
  final Book book;
  const FeedItem({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    // استخدام Image.asset مباشرة مع معالجة الأخطاء والتحميل
    return Image.asset(
      book.coverImageUrl,
      // BoxFit.contain تضمن ظهور الصورة كاملة بدون قص
      fit: BoxFit.contain,

      // هذا الجزء يعرض مؤشر تحميل لكل صورة على حدة
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) {
          return child;
        }
        // إضافة حركة ظهور تدريجي جميلة للصورة بعد التحميل
        return AnimatedOpacity(
          opacity: frame == null ? 0 : 1,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
          child: child,
        );
      },

      // في حالة فشل تحميل صورة معينة، يتم عرض أيقونة خطأ بدلاً من انهيار التطبيق
      errorBuilder: (context, error, stackTrace) {
        print('Error loading asset: ${book.coverImageUrl}');
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, color: Colors.red, size: 60),
              SizedBox(height: 8),
              Text('فشل تحميل الصورة', style: TextStyle(color: Colors.white70)),
            ],
          ),
        );
      },
    );
  }
}
