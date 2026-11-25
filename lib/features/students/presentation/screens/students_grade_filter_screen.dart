import 'package:bta3_physia_admin/core/helper/app_system_ui.dart';
import 'package:bta3_physia_admin/core/style/app_color.dart';
import 'package:bta3_physia_admin/core/widgets/background/app_screen_backdrop.dart';
import 'package:bta3_physia_admin/features/students/presentation/cubit/students_cubit.dart';
import 'package:bta3_physia_admin/features/students/presentation/widgets/students_screen_content_widgets/students_grade_filter_screen_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StudentsGradeFilterScreen extends StatelessWidget {
  const StudentsGradeFilterScreen({super.key, required this.cubit});

  final StudentsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppSystemUi.light(),
      child: Scaffold(
        backgroundColor: ColorPalette.screenBackground,
        body: SafeArea(
          child: AppScreenBackdrop(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: StudentsGradeFilterScreenContent(cubit: cubit),
            ),
          ),
        ),
      ),
    );
  }
}
