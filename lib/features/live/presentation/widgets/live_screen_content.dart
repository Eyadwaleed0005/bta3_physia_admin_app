import 'package:bta3_physia_admin/app/routes/screen_routes/route_names.dart';
import 'package:bta3_physia_admin/core/widgets/app_toast.dart';
import 'package:bta3_physia_admin/core/widgets/custom_screen_header.dart';
import 'package:bta3_physia_admin/features/live/data/models/live_stream_model.dart';
import 'package:bta3_physia_admin/features/live/presentation/args/live_form_args.dart';
import 'package:bta3_physia_admin/features/live/presentation/cubit/live_cubit.dart';
import 'package:bta3_physia_admin/features/live/presentation/cubit/live_state.dart';
import 'package:bta3_physia_admin/features/live/presentation/widgets/live_dialogs/live_dialogs.dart';
import 'package:bta3_physia_admin/features/live/presentation/widgets/live_states/live_empty_state.dart';
import 'package:bta3_physia_admin/features/live/presentation/widgets/live_states/live_failure_state.dart';
import 'package:bta3_physia_admin/features/live/presentation/widgets/live_states/live_loading_state.dart';
import 'package:bta3_physia_admin/features/live/presentation/widgets/live_states/live_success_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LiveScreenContent extends StatelessWidget {
  const LiveScreenContent({super.key});

  static const double _bottomContentInset = 24;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          child: CustomScreenHeader(
            title: 'البث الحالي',
            subtitle: 'متاح لطلاب الصف المحدد',
            onBack: () => Navigator.of(context).pop(),
          ),
        ),
        Expanded(
          child: BlocBuilder<LiveCubit, LiveState>(
            builder: (BuildContext context, LiveState state) {
              final LiveCubit cubit = context.read<LiveCubit>();

              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.fromLTRB(
                  20.w,
                  8.h,
                  20.w,
                  _bottomContentInset.h,
                ),
                child: _LiveBody(
                  state: state,
                  onRetry: () => cubit.load(),
                  onEdit: (LiveStreamModel live) =>
                      _openForm(context, cubit, live),
                  onEnd: () => _endLive(context, cubit),
                  onCreate: () => _openForm(context, cubit, null),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _openForm(BuildContext context, LiveCubit cubit, LiveStreamModel? live) {
    Navigator.of(context).pushNamed(
      RouteNames.liveFormScreen,
      arguments: LiveFormArgs(cubit: cubit, initialLive: live),
    );
  }

  Future<void> _endLive(BuildContext context, LiveCubit cubit) async {
    final bool? confirmed = await showLiveEndDialog(context);

    if (confirmed != true || !context.mounted) return;

    cubit.endLive();
    showAppToast(
      context,
      message: 'تم إنهاء البث',
      icon: Icons.stop_circle_outlined,
    );
  }
}

class _LiveBody extends StatelessWidget {
  const _LiveBody({
    required this.state,
    required this.onRetry,
    required this.onEdit,
    required this.onEnd,
    required this.onCreate,
  });

  final LiveState state;
  final VoidCallback onRetry;
  final ValueChanged<LiveStreamModel> onEdit;
  final VoidCallback onEnd;
  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) {
    switch (state.status) {
      case LiveStatus.loading:
        return const LiveLoadingState();

      case LiveStatus.failure:
        final LiveStreamModel? staleLive = state.live;

        if (staleLive != null) {
          return LiveSuccessState(
            live: staleLive,
            onEdit: () => onEdit(staleLive),
            onEnd: onEnd,
          );
        }

        return LiveFailureState(
          message:
              state.errorMessage ?? 'تأكد من الاتصال بالإنترنت وأعد المحاولة.',
          onRetry: onRetry,
        );

      case LiveStatus.current:
        final LiveStreamModel? live = state.live;

        if (live == null) {
          return LiveEmptyState(onCreate: onCreate);
        }

        return LiveSuccessState(
          live: live,
          onEdit: () => onEdit(live),
          onEnd: onEnd,
        );

      case LiveStatus.empty:
        return LiveEmptyState(onCreate: onCreate);
    }
  }
}
