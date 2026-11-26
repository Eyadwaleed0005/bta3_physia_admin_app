import 'package:bta3_physia_admin/features/students/presentation/widgets/students_list_widgets/students_list_screen_content.dart';
import 'package:flutter/material.dart';

class StudentsScreenContent extends StatelessWidget {
  const StudentsScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Directionality(
      textDirection: TextDirection.rtl,
      child: StudentsListScreenContent(),
    );
  }
}
