import 'package:bta3_physia_admin/core/helper/spacer.dart';
import 'package:bta3_physia_admin/core/style/app_color.dart';
import 'package:bta3_physia_admin/core/style/textstyles.dart';
import 'package:bta3_physia_admin/features/students/data/models/student_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudentResultCard extends StatelessWidget {
  const StudentResultCard({super.key, required this.result});

  final StudentExamResultModel result;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: ColorPalette.fieldFill,
        borderRadius: BorderRadius.circular(20.r),
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
                  result.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.font16TextLightBoldTajawal(),
                ),
                if (result.dateLabel != null) ...[
                  verticalSpace(6),
                  Text(
                    result.dateLabel!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.font12TextMutedRegularTajawal(),
                  ),
                ],
              ],
            ),
          ),
          horizontalSpace(12),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: ColorPalette.accent,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              result.scoreLabel,
              maxLines: 1,
              style: AppTextStyle.font14TextPrimaryBoldTajawal(),
            ),
          ),
        ],
      ),
    );
  }
}
