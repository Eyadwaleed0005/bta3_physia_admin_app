import 'package:bta3_physia_admin/app/routes/app_images_routes.dart';
import 'package:bta3_physia_admin/core/helper/arabic_numbers_helper.dart';
import 'package:bta3_physia_admin/core/helper/spacer.dart';
import 'package:bta3_physia_admin/core/style/app_color.dart';
import 'package:bta3_physia_admin/core/style/textstyles.dart';
import 'package:bta3_physia_admin/features/home/data/models/dashboard_overview_model.dart';
import 'package:bta3_physia_admin/features/home/presentation/widgets/home_screen_content_widgets/dashboard_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StudentTotalCard extends StatelessWidget {
  const StudentTotalCard({super.key, this.overview});

  final DashboardOverviewModel? overview;

  @override
  Widget build(BuildContext context) {
    final int? totalStudents = overview?.hasStudents == true
        ? overview!.totalStudents
        : null;
    final bool hasStudents = totalStudents != null;

    return DashboardPanel(
      color: ColorPalette.panelGlass,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'إجمالي الطلاب',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.font16TextLightBoldTajawal(),
                ),
                verticalSpace(6),
                Text(
                  toArabicNumbers(totalStudents ?? 0),
                  maxLines: 1,
                  style: AppTextStyle.font30TextLightBoldTajawal().copyWith(
                    color: ColorPalette.accent,
                    height: 1.1,
                  ),
                ),
                verticalSpace(2),
                Text(
                  hasStudents
                      ? 'طالب مسجل'
                      : 'طالب مسجل · يشمل الحسابات المزودة',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.font12TextMutedRegularTajawal(),
                ),
              ],
            ),
          ),
          horizontalSpace(12),
          SvgPicture.asset(AppImage().blueUsers, width: 30.w, height: 30.w),
        ],
      ),
    );
  }
}
