import 'package:bta3_physia_admin/core/helper/app_system_ui.dart';
import 'package:bta3_physia_admin/core/style/app_color.dart';
import 'package:bta3_physia_admin/core/widgets/background/app_screen_backdrop.dart';
import 'package:bta3_physia_admin/features/grades/data/models/grade_model.dart';
import 'package:bta3_physia_admin/features/grades/presentation/widgets/grades_form_widgets/grade_form_screen_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GradeFormScreen extends StatelessWidget {
  const GradeFormScreen({super.key, this.grade});

  /// `null` opens the screen in add mode; a grade opens it in edit mode.
  final GradeModel? grade;

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
              child: GradeFormScreenContent(grade: grade),
            ),
          ),
        ),
      ),
    );
  }
}
