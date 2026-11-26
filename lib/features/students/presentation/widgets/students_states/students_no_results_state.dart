import 'package:bta3_physia_admin/core/widgets/app_notice_card.dart';
import 'package:flutter/material.dart';

class StudentsNoResultsState extends StatelessWidget {
  const StudentsNoResultsState({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppNoticeCard(
      title: 'لا توجد نتائج بحث',
      message: 'راجع الاسم أو البريد الإلكتروني وحاول مرة أخرى.',
    );
  }
}
