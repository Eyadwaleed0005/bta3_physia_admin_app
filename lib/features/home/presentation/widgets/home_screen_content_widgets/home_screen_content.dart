import 'package:bta3_physia_admin/core/helper/spacer.dart';
import 'package:bta3_physia_admin/features/home/data/models/dashboard_overview_model.dart';
import 'package:bta3_physia_admin/features/home/data/models/dummy_dashboard_data.dart';
import 'package:bta3_physia_admin/features/home/presentation/cubit/home_cubit.dart';
import 'package:bta3_physia_admin/features/home/presentation/cubit/home_state.dart';
import 'package:bta3_physia_admin/features/home/presentation/widgets/home_screen_content_widgets/home_header.dart';
import 'package:bta3_physia_admin/features/home/presentation/widgets/home_states/home_empty_state.dart';
import 'package:bta3_physia_admin/features/home/presentation/widgets/home_states/home_failure_state.dart';
import 'package:bta3_physia_admin/features/home/presentation/widgets/home_states/home_loading_state.dart';
import 'package:bta3_physia_admin/features/home/presentation/widgets/home_states/home_success_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreenContent extends StatelessWidget {
  const HomeScreenContent({super.key});

  static const double _bottomContentInset = 128;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (BuildContext context, HomeState state) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                child: HomeHeader(
                  title: 'لوحة التحكم',
                  greeting: 'أهلًا، ${DummyDashboardData.adminDisplayName}',
                  isRefreshing: state.isRefreshing,
                  onRefresh: () => context.read<HomeCubit>().refresh(),
                ),
              ),
              verticalSpace(18),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(
                    20.w,
                    0,
                    20.w,
                    _bottomContentInset.h,
                  ),
                  child: _HomeStateBody(state: state),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _HomeStateBody extends StatelessWidget {
  const _HomeStateBody({required this.state});

  final HomeState state;

  @override
  Widget build(BuildContext context) {
    switch (state.status) {
      case HomeStatus.loading:
        return const HomeLoadingState();

      case HomeStatus.empty:
        return const HomeEmptyState();

      case HomeStatus.failure:
        return HomeFailureState(
          message:
              state.errorMessage ??
              'حصل خطأ أثناء تحميل بيانات الطلاب والكورسات. حاول مرة أخرى.',
          onRetry: () => context.read<HomeCubit>().refresh(),
        );

      case HomeStatus.success:
        final DashboardOverviewModel? overview = state.overview;
        if (overview == null) {
          return const HomeEmptyState();
        }
        return HomeSuccessState(overview: overview);
    }
  }
}
