import 'package:bta3_physia_admin/core/helper/spacer.dart';
import 'package:bta3_physia_admin/core/style/app_color.dart';
import 'package:bta3_physia_admin/core/style/textstyles.dart';
import 'package:bta3_physia_admin/features/home/presentation/widgets/home_screen_content_widgets/dashboard_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeEmptyNotice extends StatelessWidget {
  const HomeEmptyNotice({
    super.key,
    required this.title,
    required this.message,
    this.footer,
  });

  final String title;
  final String message;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    return DashboardPanel(
      color: ColorPalette.fieldFill,

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.info_outline_rounded,
            size: 60.r,
            color: ColorPalette.corona,
          ),
          verticalSpace(16),
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyle.font18TextLightBoldTajawal(),
          ),
          verticalSpace(8),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 280.w),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyle.font12TextMutedRegularTajawal(),
            ),
          ),
          if (footer != null) ...[verticalSpace(18), footer!],
        ],
      ),
    );
  }
}
