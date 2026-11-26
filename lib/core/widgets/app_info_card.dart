import 'package:bta3_physia_admin/core/helper/spacer.dart';
import 'package:bta3_physia_admin/core/style/app_color.dart';
import 'package:bta3_physia_admin/core/style/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppInfoCard extends StatelessWidget {
  const AppInfoCard({
    super.key,
    this.title,
    required this.text,
    this.titleStyle,
    this.textStyle,
    this.color,
  });

  final String? title;
  final String text;
  final TextStyle? titleStyle;
  final TextStyle? textStyle;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: color ?? ColorPalette.fieldFill,
        border: Border.all(color: ColorPalette.border),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null && title!.trim().isNotEmpty) ...[
            Text(
              title!,
              style:
                  titleStyle ?? AppTextStyle.font14TextSecondaryBoldTajawal(),
            ),
            verticalSpace(6),
          ],
          Text(
            text,
            style: textStyle ?? AppTextStyle.font14TextMutedRegularTajawal(),
          ),
        ],
      ),
    );
  }
}
