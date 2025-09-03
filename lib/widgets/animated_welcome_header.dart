import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class AnimatedWelcomeHeader extends StatelessWidget {
  const AnimatedWelcomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Center(
        child: AnimatedTextKit(
          animatedTexts: [
            // استخدمنا حركة الآلة الكاتبة لجعلها أكثر أناقة
            TyperAnimatedText(
              'بوابتك إلى المعرفة والإبداع العربي',
              textAlign: TextAlign.center,
              // طبقنا تصميم الخط مباشرة هنا لضمان التناسق
              textStyle: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              speed: const Duration(milliseconds: 100),
            ),
          ],
          // سنجعل الحركة تظهر مرة واحدة فقط عند فتح الشاشة
          totalRepeatCount: 1,
          pause: const Duration(milliseconds: 1000),
          displayFullTextOnTap: true,
        ),
      ),
    );
  }
}
