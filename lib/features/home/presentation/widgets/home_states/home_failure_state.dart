import 'package:bta3_physia_admin/core/helper/spacer.dart';
import 'package:bta3_physia_admin/core/style/app_color.dart';
import 'package:bta3_physia_admin/core/style/textstyles.dart';
import 'package:bta3_physia_admin/core/widgets/custom_button.dart';
import 'package:bta3_physia_admin/features/home/presentation/widgets/home_screen_content_widgets/home_empty_notice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeFailureState extends StatelessWidget {
  const HomeFailureState({
    super.key,
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'تعذر تحميل لوحة التحكم',
          style: AppTextStyle.font18TextLightBoldTajawal(),
        ),
        verticalSpace(4),
        Text(
          'يمكنك إعادة المحاولة',
          style: AppTextStyle.font12TextMutedRegularTajawal(),
        ),
        verticalSpace(16),
        HomeEmptyNotice(
          title: 'تعذّر تحميل الإحصائيات',
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
        ),
      ],
    );
  }
}
