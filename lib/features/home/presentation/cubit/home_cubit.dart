import 'package:bta3_physia_admin/core/errors/error_model/app_error_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/dashboard_overview_model.dart';
import '../../data/models/dummy_dashboard_data.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  Future<void> load() async {
    if (isClosed) return;

    final Either<AppErrorModel, DashboardOverviewModel> result =
        await DummyDashboardData.load();

    result.fold(
      (error) => emit(
        state.copyWith(
          status: HomeStatus.failure,
          isRefreshing: false,
          errorMessage: error.message,
        ),
      ),
      (overview) => emit(
        HomeState(
          status: overview.hasDisplayData
              ? HomeStatus.success
              : HomeStatus.empty,
          overview: overview,
          isRefreshing: false,
        ),
      ),
    );
  }

  void refresh() {
    emit(state.copyWith(status: HomeStatus.loading));
    Future.delayed(const Duration(milliseconds: 300), () {
      if (!isClosed) {
        emit(state.copyWith(status: HomeStatus.success));
      }
    });
  }
}
