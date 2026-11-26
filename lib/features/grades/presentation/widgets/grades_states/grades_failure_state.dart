import 'package:bta3_physia_admin/core/style/app_color.dart';
import 'package:bta3_physia_admin/core/style/textstyles.dart';
import 'package:bta3_physia_admin/core/widgets/app_notice_card.dart';
import 'package:bta3_physia_admin/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GradesFailureState extends StatelessWidget {
  const GradesFailureState({
    super.key,
    required this.message,
    required this.onRetry,
    this.title = 'تعذّر تحميل الصفوف',
  });

  final String title;
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return AppNoticeCard(
      title: title,
      message: message,
      footer: CustomButton(
        text: 'إعادة المحاولة',
        onPressed: onRetry,
        height: 48.h,
        background: ColorPalette.accent,
        foreground: ColorPalette.textPrimary,
        borderRadius: 24.r,
        textStyle: AppTextStyle.font14TextPrimaryBoldTajawal(),
      ),
    );
  }
}
