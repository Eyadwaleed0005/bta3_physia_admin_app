import 'package:bta3_physia_admin/app/routes/app_images_routes.dart';
import 'package:bta3_physia_admin/core/helper/spacer.dart';
import 'package:bta3_physia_admin/core/style/app_color.dart';
import 'package:bta3_physia_admin/core/style/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomScreenHeader extends StatelessWidget {
  const CustomScreenHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.onBack,
    this.onRefresh,
    this.isRefreshing = false,
  });

  final String title;
  final String subtitle;
  final VoidCallback? onBack;
  final VoidCallback? onRefresh;
  final bool isRefreshing;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (onBack != null) ...[
          _HeaderChip(icon: Icons.arrow_back_rounded, onTap: onBack!),
          horizontalSpace(12),
          Expanded(
            child: _TitleBlock(title: title, subtitle: subtitle),
          ),
          horizontalSpace(12),
          const _WordMark(),
        ] else ...[
          Expanded(
            child: Row(
              children: [
                const _WordMark(),
                horizontalSpace(12),
                _TitleBlock(title: title, subtitle: subtitle),
              ],
            ),
          ),

          if (onRefresh != null) ...[
            horizontalSpace(10),
            _HeaderChip(
              icon: Icons.refresh_rounded,
              onTap: isRefreshing ? null : onRefresh,
              isLoading: isRefreshing,
            ),
          ],
        ],
      ],
    );
  }
}

class _TitleBlock extends StatelessWidget {
  const _TitleBlock({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.start,
          style: AppTextStyle.font22TextLightBoldTajawal(),
        ),
        verticalSpace(2),
        Text(
          subtitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.start,
          style: AppTextStyle.font13TextMutedRegularTajawal(),
        ),
      ],
    );
  }
}

class _WordMark extends StatelessWidget {
  const _WordMark();

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AppImage().wordMark,
      width: 58.w,
      height: 34.h,
      fit: BoxFit.contain,
    );
  }
}

class _HeaderChip extends StatelessWidget {
  const _HeaderChip({
    required this.icon,
    required this.onTap,
    this.isLoading = false,
  });

  final IconData icon;
  final VoidCallback? onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColorPalette.teal400.withValues(alpha: 0.55),
      borderRadius: BorderRadius.circular(14.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14.r),
        child: Container(
          width: 44.w,
          height: 44.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: ColorPalette.teal300.withValues(alpha: 0.45),
              width: 1.w,
            ),
          ),
          child: Center(
            child: isLoading
                ? SizedBox(
                    width: 18.r,
                    height: 18.r,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.r,
                      color: ColorPalette.teal200,
                    ),
                  )
                : Icon(icon, size: 22.r, color: ColorPalette.teal200),
          ),
        ),
      ),
    );
  }
}
