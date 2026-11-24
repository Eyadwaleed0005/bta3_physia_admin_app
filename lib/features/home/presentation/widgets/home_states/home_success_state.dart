import 'package:bta3_physia_admin/core/helper/spacer.dart';
import 'package:bta3_physia_admin/features/home/data/models/dashboard_overview_model.dart';
import 'package:bta3_physia_admin/features/home/presentation/widgets/home_screen_content_widgets/course_subscription_section.dart';
import 'package:bta3_physia_admin/features/home/presentation/widgets/home_screen_content_widgets/student_total_card.dart';
import 'package:flutter/material.dart';

class HomeSuccessState extends StatelessWidget {
  const HomeSuccessState({super.key, required this.overview});

  final DashboardOverviewModel overview;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        StudentTotalCard(overview: overview),
        verticalSpace(22),
        CourseSubscriptionSection(overview: overview),
      ],
    );
  }
}
