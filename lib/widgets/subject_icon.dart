import 'package:flutter/material.dart';

import '../core/constants/app_constants.dart';
import '../core/theme/app_borders.dart';
import '../core/theme/app_colors.dart';

class SubjectIcon extends StatelessWidget {
  const SubjectIcon({
    super.key,
    required this.subject,
    this.size = 48,
  });

  final String subject;
  final double size;

  static IconData iconFor(String subject) {
    return switch (subject.toLowerCase()) {
      'physics' => Icons.science_outlined,
      'chemistry' => Icons.biotech_outlined,
      'biology' => Icons.eco_outlined,
      'higher math' => Icons.functions_outlined,
      'bangla' => Icons.menu_book_outlined,
      'english' => Icons.translate_outlined,
      'ict' => Icons.computer_outlined,
      'accounting' => Icons.calculate_outlined,
      'finance' => Icons.account_balance_wallet_outlined,
      'economics' => Icons.trending_up_outlined,
      _ => Icons.school_outlined,
    };
  }

  static Color backgroundFor(String subject) {
    return switch (subject.toLowerCase()) {
      'physics' => AppColors.skyBlue,
      'chemistry' => AppColors.softGreen,
      'biology' => AppColors.softGreen,
      'higher math' => AppColors.peach,
      'bangla' => AppColors.caramel,
      'english' => AppColors.softYellow,
      'ict' => AppColors.skyBlue,
      _ => AppColors.latte,
    };
  }

  @override
  Widget build(BuildContext context) {
    final bg = backgroundFor(subject);
    return Container(
      width: size,
      height: size,
      decoration: AppBorders.box(
        context: context,
        backgroundColor: bg,
        radius: size * 0.35,
        borderWidth: AppBorders.widthThin,
      ),
      child: Icon(
        iconFor(subject),
        color: AppBorders.iconOn(bg, context),
        size: size * 0.5,
      ),
    );
  }
}

String subjectNameBn(String subject) {
  return AppConstants.subjectNamesBn[subject] ?? subject;
}
