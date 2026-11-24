import 'package:bta3_physia_admin/core/helper/spacer.dart';
import 'package:bta3_physia_admin/core/style/app_color.dart';
import 'package:bta3_physia_admin/core/widgets/app_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class HomeLoadingState extends StatelessWidget {
  const HomeLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        verticalSpace(6),
        const Center(
          child: AppLoadingIndicator(
            color: ColorPalette.teal200,
            size: 18,
            title: 'جارٍ تحميل البيانات...',
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
              const _SkeletonBox(height: 112, radius: 24),
              verticalSpace(22),
              const Align(
                alignment: AlignmentDirectional.centerStart,
                child: _SkeletonBox(width: 170, height: 18),
              ),
              verticalSpace(14),
              const _SkeletonBox(height: 132, radius: 24),
              verticalSpace(14),
              const _SkeletonBox(height: 132, radius: 24),
            ],
          ),
        ),
      ],
    );
  }
}

class _SkeletonBox extends StatelessWidget {
  const _SkeletonBox({this.width, required this.height, this.radius = 12});

  final double? width;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width?.w ?? double.infinity,
      height: height.h,
      decoration: BoxDecoration(
        color: ColorPalette.fieldFill,
        borderRadius: BorderRadius.circular(radius.r),
      ),
    );
  }
}
