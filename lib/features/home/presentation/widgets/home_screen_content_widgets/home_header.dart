import 'package:bta3_physia_admin/app/routes/app_images_routes.dart';
import 'package:bta3_physia_admin/core/helper/spacer.dart';
import 'package:bta3_physia_admin/core/style/app_color.dart';
import 'package:bta3_physia_admin/core/style/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.title,
    required this.greeting,
    required this.onRefresh,
    this.isRefreshing = false,
  });

  final String title;
  final String greeting;
  final VoidCallback onRefresh;
  final bool isRefreshing;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppImage().wordMark,
                width: 60.w,
                height: 38.h,
                fit: BoxFit.contain,
              ),
              horizontalSpace(8),
              Expanded(
                child: Column(
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
                    verticalSpace(4),
                    Text(
                      greeting,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: AppTextStyle.font13TextMutedRegularTajawal(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        horizontalSpace(12),
        _RefreshButton(isRefreshing: isRefreshing, onPressed: onRefresh),
      ],
    );
  }
}

class _RefreshButton extends StatelessWidget {
  const _RefreshButton({required this.isRefreshing, required this.onPressed});

  final bool isRefreshing;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'تحديث لوحة التحكم',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isRefreshing ? null : onPressed,
          borderRadius: BorderRadius.circular(14.r),
          child: Container(
            width: 44.w,
            height: 44.h,
            decoration: BoxDecoration(
              color: ColorPalette.teal400.withValues(alpha: 0.55),
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(
                color: ColorPalette.teal300.withValues(alpha: 0.45),
                width: 1.w,
              ),
            ),
            child: Center(
              child: isRefreshing
                  ? SizedBox(
                      width: 18.r,
                      height: 18.r,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.r,
                        color: ColorPalette.teal200,
                      ),
                    )
                  : Icon(
                      Icons.refresh_rounded,
                      size: 22.r,
                      color: ColorPalette.teal200,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
