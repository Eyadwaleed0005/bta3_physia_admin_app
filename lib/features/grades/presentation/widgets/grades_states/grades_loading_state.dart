import 'package:bta3_physia_admin/core/helper/spacer.dart';
import 'package:bta3_physia_admin/core/style/app_color.dart';
import 'package:bta3_physia_admin/core/widgets/app_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class GradesLoadingState extends StatelessWidget {
  const GradesLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Center(
          child: AppLoadingIndicator(
            color: ColorPalette.teal200,
            size: 18,
            title: 'جارٍ تحميل الصفوف...',
          ),
        ),
        verticalSpace(24),
        Shimmer.fromColors(
          baseColor: ColorPalette.fieldFill,
          highlightColor: ColorPalette.teal400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              const _SkeletonCard(),
              verticalSpace(12),
              const _SkeletonCard(),
              verticalSpace(12),
              const _SkeletonCard(),
            ],
          ),
        ),
      ],
    );
  }
}

class _SkeletonCard extends StatelessWidget {
  const _SkeletonCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 86.h,
      decoration: BoxDecoration(
        color: ColorPalette.fieldFill,
        borderRadius: BorderRadius.circular(24.r),
      ),
    );
  }
}
