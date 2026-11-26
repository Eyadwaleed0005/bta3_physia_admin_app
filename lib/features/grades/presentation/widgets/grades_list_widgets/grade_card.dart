import 'package:bta3_physia_admin/core/helper/spacer.dart';
import 'package:bta3_physia_admin/core/style/app_color.dart';
import 'package:bta3_physia_admin/core/style/textstyles.dart';
import 'package:bta3_physia_admin/features/grades/data/models/grade_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GradeCard extends StatelessWidget {
  const GradeCard({super.key, required this.grade, required this.onTap});

  final GradeModel grade;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final BorderRadius radius = BorderRadius.circular(24.r);
    final Color stateColor = grade.isActive
        ? ColorPalette.teal200
        : ColorPalette.orange300;

    return Material(
      color: ColorPalette.fieldFill,
      borderRadius: radius,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          decoration: BoxDecoration(borderRadius: radius),
          child: Row(
            children: [
              Icon(Icons.school_outlined, size: 26.r, color: stateColor),
              horizontalSpace(14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      grade.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.font16TextLightBoldTajawal(),
                    ),
                    verticalSpace(4),
                    Text(
                      'عرض البيانات والعناصر المرتبطة',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.font12TextMutedRegularTajawal(),
                    ),
                    verticalSpace(6),
                    Text(
                      grade.statusLabel,
                      maxLines: 1,
                      style: AppTextStyle.font12TextSecondaryBoldTajawal()
                          .copyWith(
                            color: stateColor,
                            decoration: TextDecoration.underline,
                            decorationColor: stateColor,
                          ),
                    ),
                  ],
                ),
              ),
              horizontalSpace(8),
              Icon(Icons.chevron_right_rounded, size: 26.r, color: stateColor),
            ],
          ),
        ),
      ),
    );
  }
}
