import 'package:bta3_physia_admin/core/helper/app_system_ui.dart';
import 'package:bta3_physia_admin/core/widgets/background/app_screen_backdrop.dart';
import 'package:bta3_physia_admin/features/students/presentation/widgets/students_screen_content_widgets/students_screen_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StudentsScreen extends StatelessWidget {
  const StudentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppSystemUi.light(),
      child: AppScreenBackdrop(child: const StudentsScreenContent()),
    );
  }
}
