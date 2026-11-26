import 'package:equatable/equatable.dart';

import '../../data/models/live_stream_model.dart';

enum LiveStatus { loading, current, empty, failure }

class LiveState extends Equatable {
  const LiveState({
    this.status = LiveStatus.loading,
    this.live,
    this.isRefreshing = false,
    this.errorMessage,
  });

  final LiveStatus status;
  final LiveStreamModel? live;
  final bool isRefreshing;
  final String? errorMessage;

  bool get hasLive => live != null;

  LiveState copyWith({
    LiveStatus? status,
    LiveStreamModel? live,
    bool? isRefreshing,
    String? errorMessage,
    bool clearError = false,
  }) {
    return LiveState(
      status: status ?? this.status,
      live: live ?? this.live,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => <Object?>[
    status,
    live,
    isRefreshing,
    errorMessage,
  ];
}
