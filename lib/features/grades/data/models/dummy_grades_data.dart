import 'package:bta3_physia_admin/core/errors/error_model/app_error_model.dart';
import 'package:dartz/dartz.dart';

import 'grade_model.dart';

enum DummyGradesScenario { success, empty, failure }

const DummyGradesScenario kDummyGradesScenario = DummyGradesScenario.success;

abstract final class DummyGradesData {
  const DummyGradesData._();

  static const Duration simulatedLatency = Duration(milliseconds: 450);

  static const AppErrorModel _unavailableError = AppErrorModel(
    code: 'grades_unavailable',
    message:
        'تعذّر تحميل قائمة الصفوف. تأكد من الاتصال بالإنترنت وأعد المحاولة.',
    type: AppErrorType.unknown,
    isRetryable: true,
  );

  static List<GradeModel>? _gradesCache;
  static int _customSequence = 0;

  static List<GradeModel> get _grades => _gradesCache ??= _buildGrades();

  static List<GradeModel> get grades => List<GradeModel>.unmodifiable(_grades);

  static List<GradeModel> get activeGrades {
    return List<GradeModel>.unmodifiable(
      _grades.where((GradeModel grade) => grade.isActive),
    );
  }

  static Future<Either<AppErrorModel, List<GradeModel>>> load() async {
    await Future<void>.delayed(simulatedLatency);

    return switch (kDummyGradesScenario) {
      DummyGradesScenario.success => Right<AppErrorModel, List<GradeModel>>(
        grades,
      ),
      DummyGradesScenario.empty => const Right<AppErrorModel, List<GradeModel>>(
        <GradeModel>[],
      ),
      DummyGradesScenario.failure =>
        const Left<AppErrorModel, List<GradeModel>>(_unavailableError),
    };
  }

  static GradeModel? findById(String gradeId) {
    for (final GradeModel grade in _grades) {
      if (grade.id == gradeId) return grade;
    }

    return null;
  }

  static String nameOf(String gradeId) {
    return findById(gradeId)?.name ?? 'الصف الدراسي';
  }

  static bool isNameTaken(String name, {String? excludeId}) {
    final String normalizedName = name.trim().toLowerCase();

    return _grades.any(
      (GradeModel grade) =>
          grade.id != excludeId &&
          grade.name.trim().toLowerCase() == normalizedName,
    );
  }

  static GradeModel addGrade(String name) {
    final GradeModel grade = GradeModel(
      id: 'custom_${++_customSequence}',
      name: name.trim(),
    );

    _grades.add(grade);

    return grade;
  }

  static void renameGrade(String gradeId, String name) {
    final int index = _grades.indexWhere(
      (GradeModel grade) => grade.id == gradeId,
    );

    if (index == -1) return;

    _grades[index] = _grades[index].copyWith(name: name.trim());
  }

  static void setGradeActive(String gradeId, bool isActive) {
    final int index = _grades.indexWhere(
      (GradeModel grade) => grade.id == gradeId,
    );

    if (index == -1) return;

    _grades[index] = _grades[index].copyWith(isActive: isActive);
  }

  static List<GradeModel> _buildGrades() {
    return <GradeModel>[
      GradeModel(
        id: 'secondary_1',
        name: GradeNameHelper.getGradeName('secondary_1'),
      ),
      GradeModel(
        id: 'secondary_2',
        name: GradeNameHelper.getGradeName('secondary_2'),
      ),
      GradeModel(
        id: 'secondary_3',
        name: GradeNameHelper.getGradeName('secondary_3'),
      ),
    ];
  }
}

class GradeNameHelper {
  const GradeNameHelper._();

  static String getGradeName(String gradeId) {
    switch (gradeId.trim().toLowerCase()) {
      case 'secondary_1':
        return 'الصف الأول الثانوي';

      case 'secondary_2':
        return 'الصف الثاني الثانوي';

      case 'secondary_3':
        return 'الصف الثالث الثانوي';

      default:
        return 'الصف الدراسي';
    }
  }
}
