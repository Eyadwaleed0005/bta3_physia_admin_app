import 'package:bta3_physia_admin/features/students/presentation/widgets/students_list_widgets/students_notice_card.dart';
import 'package:flutter/material.dart';

class StudentsEmptyGradeState extends StatelessWidget {
  const StudentsEmptyGradeState({super.key});

  @override
  Widget build(BuildContext context) {
    return const StudentsNoticeCard(
      title: 'لا يوجد طلاب في هذا الصف',
      message: 'سيظهر الطلاب هنا بعد تسجيل حساباتهم أو نقلهم إلى هذا الصف.',
    );
  }
}
