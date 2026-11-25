import 'package:bta3_physia_admin/core/helper/spacer.dart';
import 'package:bta3_physia_admin/core/style/app_color.dart';
import 'package:bta3_physia_admin/core/style/textstyles.dart';
import 'package:bta3_physia_admin/core/widgets/custom_button.dart';
import 'package:bta3_physia_admin/features/students/data/models/student_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudentCourseCard extends StatelessWidget {
  const StudentCourseCard({
    super.key,
    required this.course,
    required this.openDialog,
  });

  final StudentCourseModel course;
  final VoidCallback openDialog;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: ColorPalette.fieldFill,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: ColorPalette.fieldBorder, width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(course.title, style: AppTextStyle.font16TextLightBoldTajawal()),
          verticalSpace(6),
          Text(
            course.activationLabel ?? 'تفعيل دائم بدون تاريخ انتهاء',
            style: AppTextStyle.font12TextMutedRegularTajawal(),
          ),
          verticalSpace(18),
          if (course.isActivated) ...[
            CustomButton(
              text: 'إلغاء التفعيل',
              onPressed: openDialog,
              height: 48.h,
              background: ColorPalette.panelGlass,
              foreground: ColorPalette.textLight,
              borderRadius: 24.r,
              textStyle: AppTextStyle.font18TextPrimaryBoldTajawal(),
            ),
          ] else
            CustomButton(
              text: 'تفعيل الكورس',
              onPressed: openDialog,
              height: 48.h,
              background: ColorPalette.accent,
              foreground: ColorPalette.textPrimary,
              borderRadius: 24.r,
              textStyle: AppTextStyle.font18TextPrimaryBoldTajawal(),
            ),
        ],
      ),
    );
  }
}
