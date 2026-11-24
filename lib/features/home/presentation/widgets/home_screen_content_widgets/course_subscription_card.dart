import 'package:bta3_physia_admin/core/helper/arabic_numbers_helper.dart';
import 'package:bta3_physia_admin/core/helper/spacer.dart';
import 'package:bta3_physia_admin/core/style/app_color.dart';
import 'package:bta3_physia_admin/core/style/textstyles.dart';
import 'package:bta3_physia_admin/features/home/data/models/dashboard_overview_model.dart';
import 'package:bta3_physia_admin/features/home/presentation/widgets/home_screen_content_widgets/dashboard_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseSubscriptionCard extends StatelessWidget {
  const CourseSubscriptionCard({
    super.key,
    required this.title,
    required this.titleColor,
    required this.subscription,
    this.onViewCourse,
  });

  final String title;
  final Color titleColor;
  final CourseSubscription subscription;
  final VoidCallback? onViewCourse;

  @override
  Widget build(BuildContext context) {
    return DashboardPanel(
      color: ColorPalette.fieldFill,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyle.font12TextSecondaryBoldTajawal().copyWith(
              color: titleColor,
              height: 1.2,
            ),
          ),
          verticalSpace(6),
          Text(
            subscription.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyle.font18TextLightBoldTajawal(),
          ),
          verticalSpace(2),
          Text(
            'التفعيلات الحالية',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyle.font11TextMutedRegularTajawal(),
          ),
          verticalSpace(10),
          Row(
            children: [
              _SubscribersCount(subscribers: subscription.subscribers),
              horizontalSpace(12),
              Expanded(
                child: Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: _CourseAction(onTap: onViewCourse),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SubscribersCount extends StatelessWidget {
  const _SubscribersCount({required this.subscribers});

  final int? subscribers;

  @override
  Widget build(BuildContext context) {
    final int? count = subscribers;

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          toArabicNumbers(count ?? 0),
          style: AppTextStyle.font28textLightBoldTajawal(),
        ),
        horizontalSpace(6),
        Text('مشترك', style: AppTextStyle.font11TextMutedRegularTajawal()),
      ],
    );
  }
}

class _CourseAction extends StatelessWidget {
  const _CourseAction({this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                'عرض الكورس',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.font13TextSecondaryBoldTajawal(),
              ),
            ),
            horizontalSpace(6),
            Icon(
              Icons.arrow_forward_rounded,
              size: 16.r,
              color: ColorPalette.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
