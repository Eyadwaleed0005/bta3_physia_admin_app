import 'package:bta3_physia_admin/core/helper/spacer.dart';
import 'package:bta3_physia_admin/core/style/app_color.dart';
import 'package:bta3_physia_admin/core/style/textstyles.dart';
import 'package:bta3_physia_admin/features/grades/data/models/grade_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GradeActivationCard extends StatelessWidget {
  const GradeActivationCard({
    super.key,
    required this.grade,
    required this.onTap,
  });

  final GradeModel grade;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bool isActive = grade.isActive;
    final Color accentColor = isActive
        ? ColorPalette.orange300
        : ColorPalette.teal200;
    final BorderRadius radius = BorderRadius.circular(24.r);

    return Material(
      color: ColorPalette.fieldFill,
      borderRadius: radius,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          decoration: BoxDecoration(
            borderRadius: radius,
            border: Border.all(color: ColorPalette.fieldBorder, width: 1.w),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      isActive ? 'إيقاف الصف' : 'تفعيل الصف',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: AppTextStyle.font16TextLightBoldTajawal(),
                    ),
                    verticalSpace(4),
                    Text(
                      isActive
                          ? 'إيقاف استقبال المحتوى والموارد الجديدة'
                          : 'إعادة الصف لاستقبال المحتوى والموارد',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: AppTextStyle.font12TextMutedRegularTajawal(),
                    ),
                  ],
                ),
              ),
              horizontalSpace(12),
              Icon(
                isActive
                    ? Icons.pause_circle_outline_rounded
                    : Icons.play_circle_outline_rounded,
                size: 28.r,
                color: accentColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
