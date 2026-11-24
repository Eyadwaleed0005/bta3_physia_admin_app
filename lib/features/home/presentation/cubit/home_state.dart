import 'package:equatable/equatable.dart';

import '../../data/models/dashboard_overview_model.dart';

enum HomeStatus { loading, success, empty, failure }

class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.loading,
    this.overview,
    this.isRefreshing = false,
    this.errorMessage,
  });

  final HomeStatus status;
  final DashboardOverviewModel? overview;
  final bool isRefreshing;
  final String? errorMessage;

  bool get hasOverview => overview != null;

  bool get isFailureVisible => errorMessage != null;

  HomeState copyWith({
    HomeStatus? status,
    DashboardOverviewModel? overview,
    bool? isRefreshing,
    String? errorMessage,
    bool clearError = false,
  }) {
    return HomeState(
      status: status ?? this.status,
      overview: overview ?? this.overview,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [status, overview, isRefreshing, errorMessage];
}
