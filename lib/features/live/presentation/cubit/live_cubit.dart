import 'package:bta3_physia_admin/core/errors/error_model/app_error_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/dummy_live_data.dart';
import '../../data/models/live_stream_model.dart';
import 'live_state.dart';

class LiveCubit extends Cubit<LiveState> {
  LiveCubit() : super(const LiveState());

  int _requestId = 0;
  bool _isFetching = false;

  Future<void> load() async {
    if (isClosed || _isFetching) return;

    _isFetching = true;
    final int requestId = ++_requestId;

    emit(state.copyWith(status: LiveStatus.loading, clearError: true));

    final Either<AppErrorModel, LiveStreamModel?> result =
        await DummyLiveData.load();

    if (isClosed || requestId != _requestId) {
      _isFetching = false;
      return;
    }

    result.fold(
      (AppErrorModel error) => emit(
        state.copyWith(
          status: LiveStatus.failure,
          isRefreshing: false,
          errorMessage: error.message,
        ),
      ),
      (LiveStreamModel? live) => emit(
        LiveState(
          status: live == null ? LiveStatus.empty : LiveStatus.current,
          live: live,
        ),
      ),
    );

    _isFetching = false;
  }

  Future<void> retry() => load();

  void saveLive(LiveStreamModel live) {
    if (isClosed) return;

    DummyLiveData.save(live);
    emit(LiveState(status: LiveStatus.current, live: live));
  }

  void endLive() {
    if (isClosed) return;

    DummyLiveData.end();
    emit(const LiveState(status: LiveStatus.empty));
  }

  @override
  Future<void> close() {
    _requestId++;
    return super.close();
  }
}
