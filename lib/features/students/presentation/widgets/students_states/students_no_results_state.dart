import 'package:bta3_physia_admin/features/students/presentation/widgets/students_list_widgets/students_notice_card.dart';
import 'package:flutter/material.dart';

class StudentsNoResultsState extends StatelessWidget {
  const StudentsNoResultsState({super.key});

  @override
  Widget build(BuildContext context) {
    return const StudentsNoticeCard(
      title: 'لا توجد نتائج بحث',
      message: 'راجع الاسم أو البريد الإلكتروني وحاول مرة أخرى.',
    );
  }
}
