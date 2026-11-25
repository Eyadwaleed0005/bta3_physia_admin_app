import 'package:bta3_physia_admin/core/helper/spacer.dart';
import 'package:bta3_physia_admin/core/style/app_color.dart';
import 'package:bta3_physia_admin/core/style/textstyles.dart';
import 'package:bta3_physia_admin/core/widgets/custom_button.dart';
import 'package:bta3_physia_admin/core/widgets/custom_secondary_button.dart';
import 'package:bta3_physia_admin/features/students/data/models/student_model.dart';
import 'package:bta3_physia_admin/features/students/presentation/cubit/students_state.dart';
import 'package:bta3_physia_admin/features/students/presentation/widgets/students_list_widgets/student_card.dart';
import 'package:bta3_physia_admin/features/students/presentation/widgets/students_list_widgets/students_roster_note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudentsSuccessState extends StatelessWidget {
  const StudentsSuccessState({
    super.key,
    required this.state,
    required this.onOpenStudent,
    required this.onLoadMore,
    required this.onClearSearch,
  });

  final StudentsState state;
  final void Function(String) onOpenStudent;
  final VoidCallback onLoadMore;
  final VoidCallback onClearSearch;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final StudentModel student in state.visibleStudents) ...[
          StudentCard(student: student, onTap: () => onOpenStudent(student.id)),
          verticalSpace(12),
        ],
        if (state.hasSearch) ...[
          CustomSecondaryButton(
            text: 'مسح البحث',
            onPressed: onClearSearch,
            height: 50.h,
            backgroundColor: ColorPalette.panelGlass,
            borderColor: ColorPalette.fieldBorder,
            borderWidth: 1,
            borderRadius: 24.r,
            foregroundColor: ColorPalette.textLight,
            textStyle: AppTextStyle.font15TextLightBoldTajawal(),
          ),
          verticalSpace(10),
        ],
        if (!state.hasSearch && state.gradeFilter == null) ...[
          const StudentsRosterNote(),
          verticalSpace(10),
        ],
        if (state.hasMore)
          CustomButton(
            text: 'تحميل المزيد',
            onPressed: onLoadMore,
            height: 50.h,
            background: ColorPalette.panelGlass,
            foreground: ColorPalette.textLight,
            borderColor: ColorPalette.fieldBorder,
            borderWidth: 1,
            borderRadius: 24.r,
            textStyle: AppTextStyle.font15TextLightBoldTajawal(),
          ),
      ],
    );
  }
}
