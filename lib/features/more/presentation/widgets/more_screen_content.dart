import 'package:bta3_physia_admin/app/routes/screen_routes/route_names.dart';
import 'package:bta3_physia_admin/core/constant/main_navigation_tabs.dart';
import 'package:bta3_physia_admin/core/helper/spacer.dart';
import 'package:bta3_physia_admin/core/style/app_color.dart';
import 'package:bta3_physia_admin/core/style/textstyles.dart';
import 'package:bta3_physia_admin/core/widgets/app_info_card.dart';
import 'package:bta3_physia_admin/core/widgets/custom_screen_header.dart';
import 'package:bta3_physia_admin/features/main_navigation/presentation/cubit/bottom_navigation_cubit.dart';
import 'package:bta3_physia_admin/features/more/presentation/widgets/more_action_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MoreScreenContent extends StatelessWidget {
  const MoreScreenContent({super.key});

  static const double _bottomContentInset = 128;

  @override
  Widget build(BuildContext context) {
    final BottomNavigationCubit navigationCubit = context
        .read<BottomNavigationCubit>();

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          child: CustomScreenHeader(
            title: 'المزيد',
            subtitle: 'إدارة المحتوى والصفوف',
            onBack: () => navigationCubit.changeIndex(MainNavigationTabs.home),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(
              20.w,
              8.h,
              20.w,
              _bottomContentInset.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'إدارة التطبيق',
                  style: AppTextStyle.font20TextLightBoldTajawal(),
                ),
                verticalSpace(16),
                MoreActionCard(
                  icon: Icons.school_outlined,
                  title: 'الصفوف الدراسية',
                  subtitle: 'إضافة الصفوف وتعديلها وتفعيلها وإيقافها',
                  onTap: () =>
                      Navigator.of(context).pushNamed(RouteNames.gradesScreen),
                ),
                verticalSpace(12),
                MoreActionCard(
                  icon: Icons.live_tv_rounded,
                  title: 'البث المباشر',
                  subtitle: 'بث واحد للمشهد المحدد وإلغاؤه يدوياً',
                  onTap: () => _openLive(context),
                ),
                verticalSpace(16),
                AppInfoCard(
                  color: ColorPalette.panelGlass,
                  title: 'الإشعارات تلقائية',
                  text: 'تصل إشعارات النشر لطلاب الصف المسموح لهم بالمحتوى.',
                  titleStyle: AppTextStyle.font16TextSecondaryBoldTajawal(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _openLive(BuildContext context) {
    Navigator.of(context).pushNamed(RouteNames.liveScreen);
  }
}
