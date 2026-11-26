import 'package:bta3_physia_admin/core/helper/spacer.dart';
import 'package:bta3_physia_admin/core/style/app_color.dart';
import 'package:bta3_physia_admin/core/style/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppActionTile extends StatelessWidget {
  const AppActionTile({
    super.key,
    required this.title,
    required this.onTap,
    this.subtitle,
    this.icon,
    this.titleColor,
    this.isSelected = false,
    this.showBorder = false,
  });

  final String title;
  final String? subtitle;
  final IconData? icon;
  final Color? titleColor;
  final bool isSelected;
  final bool showBorder;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final BorderRadius radius = BorderRadius.circular(20.r);
    final Color iconColor = isSelected
        ? ColorPalette.accent
        : (titleColor ?? ColorPalette.teal200);

    return Material(
      color: ColorPalette.fieldFill,
      borderRadius: radius,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: Container(
          constraints: BoxConstraints(minHeight: 60.h),
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          decoration: showBorder
              ? BoxDecoration(
                  borderRadius: radius,
                  border: Border.all(
                    color: ColorPalette.fieldBorder,
                    width: 1.w,
                  ),
                )
              : null,
          child: Row(
            children: [
              if (icon != null) ...[
                Icon(icon, size: 24.r, color: iconColor),
                horizontalSpace(12),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.font15TextLightBoldTajawal().copyWith(
                        color: titleColor ?? ColorPalette.textLight,
                      ),
                    ),
                    if (subtitle != null) ...[
                      verticalSpace(2),
                      Text(
                        subtitle!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.font12TextMutedRegularTajawal(),
                      ),
                    ],
                  ],
                ),
              ),
              horizontalSpace(8),
              Icon(
                Icons.chevron_right_rounded,
                size: 26.r,
                color: isSelected ? ColorPalette.accent : ColorPalette.teal200,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
