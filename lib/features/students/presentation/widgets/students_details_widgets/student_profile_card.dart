import 'package:bta3_physia_admin/app/routes/app_images_routes.dart';
import 'package:bta3_physia_admin/core/helper/spacer.dart';
import 'package:bta3_physia_admin/core/style/app_color.dart';
import 'package:bta3_physia_admin/core/style/textstyles.dart';
import 'package:bta3_physia_admin/features/students/data/models/student_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StudentProfileCard extends StatelessWidget {
  const StudentProfileCard({super.key, required this.student});

  final StudentModel student;

  @override
  Widget build(BuildContext context) {
    final double avatarSize = 82.r;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorPalette.panelGlass,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            AppImage().avatar,
            width: avatarSize,
            height: avatarSize,
            fit: BoxFit.contain,
          ),
          horizontalSpace(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  student.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.font20TextLightBoldTajawal(),
                ),
                verticalSpace(4),
                Text(
                  student.email,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.font12TextMutedRegularTajawal(),
                ),
                verticalSpace(6),
                Text(
                  student.statusLabel,
                  maxLines: 1,
                  style: AppTextStyle.font13TextSecondaryBoldTajawal().copyWith(
                    color: student.isActive
                        ? ColorPalette.teal200
                        : ColorPalette.orange300,
                    decoration: TextDecoration.underline,
                    decorationColor: student.isActive
                        ? ColorPalette.teal200
                        : ColorPalette.orange300,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
