import 'package:bta3_physia_admin/core/errors/error_model/app_error_model.dart';
import 'package:dartz/dartz.dart';

import 'dashboard_overview_model.dart';

enum DummyHomeScenario { success, empty, failure }

const DummyHomeScenario kDummyHomeScenario = DummyHomeScenario.success;

abstract final class DummyDashboardData {
  const DummyDashboardData._();

  static const Duration simulatedLatency = Duration(milliseconds: 550);

  static const String adminDisplayName = 'مستر جمال محمد';

  static const AppErrorModel _unavailableError = AppErrorModel(
    code: 'dashboard_unavailable',
    message: 'حصل خطأ أثناء تحميل بيانات الطلاب والكورسات. حاول مرة أخرى.',
    type: AppErrorType.unknown,
    isRetryable: true,
  );

  static Future<Either<AppErrorModel, DashboardOverviewModel>> load() async {
    await Future<void>.delayed(simulatedLatency);

    switch (kDummyHomeScenario) {
      case DummyHomeScenario.success:
        return Right(_successOverview());
      case DummyHomeScenario.empty:
        return Right(_emptyOverview());
      case DummyHomeScenario.failure:
        return const Left<AppErrorModel, DashboardOverviewModel>(
          _unavailableError,
        );
    }
  }

  static DashboardOverviewModel _successOverview() {
    return DashboardOverviewModel(
      totalStudents: 1234,
      includesProvisionedAccounts: true,
      mostSubscribed: const CourseSubscription(
        title: 'الحركة في خط مستقيم',
        subscribers: 336,
      ),
      leastSubscribed: const CourseSubscription(title: 'القياس والأخطاء'),
      lastUpdatedAt: DateTime.now(),
    );
  }

  static DashboardOverviewModel _emptyOverview() {
    return DashboardOverviewModel(
      totalStudents: 0,
      includesProvisionedAccounts: true,
      lastUpdatedAt: DateTime.now(),
    );
  }
}
