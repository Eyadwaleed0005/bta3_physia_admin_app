import 'package:bta3_physia_admin/core/helper/spacer.dart';
import 'package:bta3_physia_admin/core/style/app_color.dart';
import 'package:bta3_physia_admin/core/style/textstyles.dart';
import 'package:bta3_physia_admin/features/students/data/models/student_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudentCard extends StatelessWidget {
  const StudentCard({super.key, required this.student, required this.onTap});

  final StudentModel student;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      student.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.font16TextLightBoldTajawal(),
                    ),
                    verticalSpace(8),
                    Text(
                      student.email,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.font13TextMutedRegularTajawal(),
                    ),
                    verticalSpace(10),
                    Row(
                      children: [
                        Text(
                          student.statusLabel,
                          maxLines: 1,
                          style: AppTextStyle.font13TextSecondaryBoldTajawal()
                              .copyWith(
                                color: student.isActive
                                    ? ColorPalette.teal200
                                    : ColorPalette.orange300,
                                decoration: TextDecoration.underline,
                                decorationColor: student.isActive
                                    ? ColorPalette.teal200
                                    : ColorPalette.orange300,
                              ),
                        ),
                        horizontalSpace(12),
                        Flexible(
                          child: Text(
                            student.gradeLabel,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyle.font13TextMutedRegularTajawal(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              horizontalSpace(14),
              _ManageAvatar(isActive: student.isActive),
            ],
          ),
        ),
      ),
    );
  }
}

class _ManageAvatar extends StatelessWidget {
  const _ManageAvatar({required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 54.r,
      height: 54.r,
      decoration: BoxDecoration(
        color: ColorPalette.fieldFill,
        shape: BoxShape.circle,
        border: Border.all(
          color: isActive
              ? ColorPalette.teal200.withValues(alpha: 0.55)
              : ColorPalette.orange300.withValues(alpha: 0.55),
          width: 1.2.w,
        ),
      ),
      child: Center(
        child: Icon(
          Icons.settings_rounded,
          size: 24.r,
          color: isActive ? ColorPalette.teal200 : ColorPalette.orange300,
        ),
      ),
    );
  }
}
