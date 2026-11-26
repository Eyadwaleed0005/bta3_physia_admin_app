import 'package:bta3_physia_admin/core/errors/error_model/app_error_model.dart';
import 'package:dartz/dartz.dart';

import 'live_stream_model.dart';

enum DummyLiveScenario { current, empty, failure }

const DummyLiveScenario kDummyLiveScenario = DummyLiveScenario.current;

abstract final class DummyLiveData {
  const DummyLiveData._();

  static const Duration simulatedLatency = Duration(milliseconds: 450);

  static const AppErrorModel _unavailableError = AppErrorModel(
    code: 'live_unavailable',
    message: 'تعذّر تحميل البث. تحقق من الاتصال بالإنترنت وأعد المحاولة.',
    type: AppErrorType.unknown,
    isRetryable: true,
  );

  static LiveStreamModel? _current;
  static bool _isInitialized = false;

  static LiveStreamModel? get currentLive {
    _ensureInitialized();
    return _current;
  }

  static Future<Either<AppErrorModel, LiveStreamModel?>> load() async {
    await Future<void>.delayed(simulatedLatency);

    _ensureInitialized();

    return switch (kDummyLiveScenario) {
      DummyLiveScenario.current => Right<AppErrorModel, LiveStreamModel?>(
        _current,
      ),
      DummyLiveScenario.empty => const Right<AppErrorModel, LiveStreamModel?>(
        null,
      ),
      DummyLiveScenario.failure => const Left<AppErrorModel, LiveStreamModel?>(
        _unavailableError,
      ),
    };
  }

  static void save(LiveStreamModel live) {
    _ensureInitialized();
    _current = live;
  }

  static void end() {
    _ensureInitialized();
    _current = null;
  }

  static void _ensureInitialized() {
    if (_isInitialized) return;

    _isInitialized = true;
    _current = switch (kDummyLiveScenario) {
      DummyLiveScenario.current => const LiveStreamModel(
        title: 'مراجعة الحركة في خط مستقيم',
        gradeId: 'secondary_3',
        platform: LivePlatform.zoom,
        url: 'https://zoom.us/j/123456789',
      ),
      DummyLiveScenario.empty || DummyLiveScenario.failure => null,
    };
  }
}
