import 'package:bta3_physia_admin/core/helper/spacer.dart';
import 'package:bta3_physia_admin/features/home/presentation/widgets/home_screen_content_widgets/course_subscription_section.dart';
import 'package:bta3_physia_admin/features/home/presentation/widgets/home_screen_content_widgets/home_empty_notice.dart';
import 'package:bta3_physia_admin/features/home/presentation/widgets/home_screen_content_widgets/student_total_card.dart';
import 'package:flutter/material.dart';

class HomeEmptyState extends StatelessWidget {
  const HomeEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        const StudentTotalCard(),
        verticalSpace(14),
        const HomeEmptyNotice(
          title: 'لسه مفيش طلاب',
          message: 'أول ما طالب ينتش حسابو، العدد هيتظهر هنا',
        ),
        verticalSpace(22),
        const CourseSubscriptionSection(),
      ],
    );
  }
}
