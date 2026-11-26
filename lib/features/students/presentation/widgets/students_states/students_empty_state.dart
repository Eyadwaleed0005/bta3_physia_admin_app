import 'package:bta3_physia_admin/core/widgets/app_notice_card.dart';
import 'package:flutter/material.dart';

class StudentsEmptyState extends StatelessWidget {
  const StudentsEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppNoticeCard(
      title: 'لا يوجد طلاب بعد',
      message: 'ستظهر الحسابات هنا بعد أن يسجل الطلاب بأنفسهم.',
    );
  }
}
