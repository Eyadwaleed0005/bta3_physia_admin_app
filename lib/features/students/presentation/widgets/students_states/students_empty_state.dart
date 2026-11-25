import 'package:bta3_physia_admin/features/students/presentation/widgets/students_list_widgets/students_notice_card.dart';
import 'package:flutter/material.dart';

class StudentsEmptyState extends StatelessWidget {
  const StudentsEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return const StudentsNoticeCard(
      title: 'لا يوجد طلاب بعد',
      message: 'ستظهر الحسابات هنا بعد أن يسجل الطلاب بأنفسهم.',
    );
  }
}
