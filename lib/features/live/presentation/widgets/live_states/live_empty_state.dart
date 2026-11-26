import 'package:bta3_physia_admin/core/helper/spacer.dart';
import 'package:bta3_physia_admin/core/style/app_color.dart';
import 'package:bta3_physia_admin/core/style/textstyles.dart';
import 'package:bta3_physia_admin/core/widgets/app_info_card.dart';
import 'package:bta3_physia_admin/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LiveEmptyState extends StatelessWidget {
  const LiveEmptyState({super.key, required this.onCreate});

  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        AppInfoCard(
          color: ColorPalette.panelGlass,
          title: 'لا يوجد بث حالي',
          text: 'أنشئ بثًا وحدد الصف والمنصة. البث لا يشترط اشتراكًا في كورس.',
          titleStyle: AppTextStyle.font16TextSecondaryBoldTajawal(),
        ),
        verticalSpace(16),
        CustomButton(
          text: 'إنشاء بث',
          onPressed: onCreate,
          height: 52.h,
          background: ColorPalette.accent,
          foreground: ColorPalette.textPrimary,
          borderRadius: 24.r,
          textStyle: AppTextStyle.font15TextPrimaryBoldTajawal(),
          prefixIcon: Icon(
            Icons.add_rounded,
            size: 20.r,
            color: ColorPalette.textPrimary,
          ),
        ),
      ],
    );
  }
}
