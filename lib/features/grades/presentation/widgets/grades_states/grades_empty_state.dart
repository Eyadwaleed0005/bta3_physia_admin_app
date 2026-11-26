import 'package:bta3_physia_admin/core/widgets/app_notice_card.dart';
import 'package:flutter/material.dart';

class GradesEmptyState extends StatelessWidget {
  const GradesEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppNoticeCard(
      title: 'لا توجد صفوف بعد',
      message: 'أضف صفًا جديدًا ليظهر هنا ويصبح متاحًا للطلاب.',
    );
  }
}
