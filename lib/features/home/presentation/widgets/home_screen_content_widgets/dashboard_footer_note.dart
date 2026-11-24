import 'package:bta3_physia_admin/core/style/app_color.dart';
import 'package:bta3_physia_admin/core/style/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Small explanatory note under the comparison cards.
class DashboardFooterNote extends StatelessWidget {
  const DashboardFooterNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: ColorPalette.teal400.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Text(
        'تشمل المقارنة الكورسات غير المنشورة وتستبعد الكورسات المجانية.',
        textAlign: TextAlign.center,
        style: AppTextStyle.font11TextMutedRegularTajawal(),
      ),
    );
  }
}
