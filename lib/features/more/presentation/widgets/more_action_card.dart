import 'package:bta3_physia_admin/core/helper/spacer.dart';
import 'package:bta3_physia_admin/core/style/app_color.dart';
import 'package:bta3_physia_admin/core/style/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MoreActionCard extends StatelessWidget {
  const MoreActionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final BorderRadius radius = BorderRadius.circular(24.r);

    return Material(
      color: ColorPalette.fieldFill,
      borderRadius: radius,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          decoration: BoxDecoration(borderRadius: radius),
          child: Row(
            children: [
              Icon(icon, size: 26.r, color: ColorPalette.teal200),
              horizontalSpace(14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.font16TextLightBoldTajawal(),
                    ),
                    verticalSpace(4),
                    Text(
                      subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.font12TextMutedRegularTajawal(),
                    ),
                  ],
                ),
              ),
              horizontalSpace(8),
              Icon(
                Icons.chevron_right_rounded,
                size: 26.r,
                color: ColorPalette.teal200,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
