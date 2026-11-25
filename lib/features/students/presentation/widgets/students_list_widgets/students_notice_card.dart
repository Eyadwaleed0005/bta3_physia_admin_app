import 'package:bta3_physia_admin/core/helper/spacer.dart';
import 'package:bta3_physia_admin/core/style/app_color.dart';
import 'package:bta3_physia_admin/core/style/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudentsNoticeCard extends StatelessWidget {
  const StudentsNoticeCard({
    super.key,
    required this.title,
    required this.message,
    this.footer,
    this.icon = Icons.info_outline_rounded,
    this.showIcon = true,
    this.padding,
  });

  final String title;
  final String message;
  final Widget? footer;
  final IconData icon;
  final bool showIcon;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding:
          padding ?? EdgeInsets.symmetric(horizontal: 20.w, vertical: 26.h),
      decoration: BoxDecoration(
        color: ColorPalette.fieldFill,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: ColorPalette.fieldBorder, width: 1.w),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showIcon) ...[
            Icon(icon, size: 52.r, color: ColorPalette.corona),
            verticalSpace(14),
          ],
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyle.font18TextLightBoldTajawal(),
          ),
          verticalSpace(8),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 290.w),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyle.font12TextMutedRegularTajawal(),
            ),
          ),
          if (footer != null) ...[verticalSpace(18), footer!],
        ],
      ),
    );
  }
}
