import 'package:bta3_physia_admin/core/helper/spacer.dart';
import 'package:bta3_physia_admin/core/style/app_color.dart';
import 'package:bta3_physia_admin/features/home/data/models/dashboard_overview_model.dart';
import 'package:bta3_physia_admin/features/home/presentation/widgets/home_screen_content_widgets/course_subscription_card.dart';
import 'package:bta3_physia_admin/features/home/presentation/widgets/home_screen_content_widgets/dashboard_footer_note.dart';
import 'package:bta3_physia_admin/features/home/presentation/widgets/home_screen_content_widgets/home_empty_notice.dart';
import 'package:bta3_physia_admin/features/home/presentation/widgets/home_screen_content_widgets/section_header.dart';
import 'package:flutter/material.dart';

class CourseSubscriptionSection extends StatelessWidget {
  const CourseSubscriptionSection({
    super.key,
    this.overview,
    this.onViewCourse,
  });

  final DashboardOverviewModel? overview;
  final VoidCallback? onViewCourse;

  @override
  Widget build(BuildContext context) {
    final CourseSubscription? most = overview?.mostSubscribed;
    final CourseSubscription? least = overview?.leastSubscribed;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        SectionHeader(lastUpdatedAt: overview?.lastUpdatedAt),
        verticalSpace(14),
        if (most != null && least != null) ...[
          CourseSubscriptionCard(
            title: 'الأكثر اشتراكًا',
            titleColor: ColorPalette.accent,
            subscription: most,
            onViewCourse: onViewCourse,
          ),
          verticalSpace(14),
          CourseSubscriptionCard(
            title: 'الأقل اشتراكًا',
            titleColor: ColorPalette.textSecondary,
            subscription: least,
            onViewCourse: onViewCourse,
          ),
          verticalSpace(14),
          const DashboardFooterNote(),
        ] else
          const HomeEmptyNotice(
            title: 'لا توجد كورسات للمقارنة',
            message: 'لا توجد كورسات مدفوعة حالياً. ستظهر المقارنة بعد إضافة أول كورس مدفوع.',
          ),
      ],
    );
  }
}
