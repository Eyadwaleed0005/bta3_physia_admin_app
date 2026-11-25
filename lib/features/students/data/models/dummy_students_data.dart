import 'package:bta3_physia_admin/core/errors/error_model/app_error_model.dart';
import 'package:dartz/dartz.dart';

import 'student_model.dart';

enum DummyStudentsScenario { success, empty, failure }

const DummyStudentsScenario kDummyStudentsScenario =
    DummyStudentsScenario.success;

abstract final class DummyStudentsData {
  const DummyStudentsData._();

  static const Duration simulatedLatency = Duration(milliseconds: 550);

  static const AppErrorModel _unavailableError = AppErrorModel(
    code: 'students_unavailable',
    message:
        'تعذّر تحميل قائمة الطلاب. تأكد من الاتصال بالإنترنت وأعد المحاولة.',
    type: AppErrorType.unknown,
    isRetryable: true,
  );

  static const AppErrorModel _notFoundError = AppErrorModel(
    code: 'student_not_found',
    message: 'تعذّر العثور على بيانات الطالب. ارجع إلى القائمة وحاول مرة أخرى.',
    type: AppErrorType.notFound,
    isRetryable: false,
  );

  /// In-memory roster shared by the list and details cubits so edits survive
  /// navigation until the real data source replaces this file.
  static List<StudentModel>? _rosterCache;

  static List<StudentModel> get _roster => _rosterCache ??= _buildStudents();

  static Future<Either<AppErrorModel, List<StudentModel>>> load() async {
    await Future<void>.delayed(simulatedLatency);

    return switch (kDummyStudentsScenario) {
      DummyStudentsScenario.success => Right<AppErrorModel, List<StudentModel>>(
        List<StudentModel>.of(_roster),
      ),
      DummyStudentsScenario.empty =>
        const Right<AppErrorModel, List<StudentModel>>(<StudentModel>[]),
      DummyStudentsScenario.failure =>
        const Left<AppErrorModel, List<StudentModel>>(_unavailableError),
    };
  }

  static Future<Either<AppErrorModel, StudentModel>> loadStudent(
    String studentId,
  ) async {
    await Future<void>.delayed(simulatedLatency);

    if (kDummyStudentsScenario == DummyStudentsScenario.failure) {
      return const Left<AppErrorModel, StudentModel>(_unavailableError);
    }

    final StudentModel? student = findById(studentId);

    if (student == null) {
      return const Left<AppErrorModel, StudentModel>(_notFoundError);
    }

    return Right<AppErrorModel, StudentModel>(student);
  }

  static StudentModel? findById(String studentId) {
    for (final StudentModel student in _roster) {
      if (student.id == studentId) return student;
    }

    return null;
  }

  static void updateStudent(StudentModel updated) {
    final int index = _roster.indexWhere(
      (StudentModel student) => student.id == updated.id,
    );

    if (index == -1) return;

    _roster[index] = updated;
  }

  static void removeStudent(String studentId) {
    _roster.removeWhere((StudentModel student) => student.id == studentId);
  }

  static List<StudentModel> _buildStudents() {
    return <StudentModel>[
      StudentModel(
        id: 'student_1',
        name: 'نور أحمد',
        email: 'nour@example.com',
        grade: StudentGrade.thirdSecondary,
        courses: <StudentCourseModel>[
          StudentCourseModel(
            id: 'course_1',
            title: 'الحركة في خط مستقيم',
            activationLabel: 'تفعيل دائم بدون تاريخ انتهاء',
          ),
          StudentCourseModel(
            id: 'course_2',
            title: 'القياس والأخطاء',
            isActivated: true,
            activationLabel: 'مفعّل حتى نهاية العام',
          ),
        ],
        results: <StudentExamResultModel>[
          StudentExamResultModel(
            title: 'امتحان الحركة في خط مستقيم',
            scoreLabel: '١٨ / ٢٠',
            dateLabel: '١٢ نوفمبر ٢٠٢٦',
          ),
          StudentExamResultModel(
            title: 'امتحان القياس والأخطاء',
            scoreLabel: '١٦ / ٢٠',
            dateLabel: '١٩ نوفمبر ٢٠٢٦',
          ),
        ],
      ),
      StudentModel(
        id: 'student_2',
        name: 'ياسين أحمد',
        email: 'yassin@example.com',
        grade: StudentGrade.secondSecondary,
        courses: <StudentCourseModel>[
          StudentCourseModel(
            id: 'course_3',
            title: 'الحركة في خط مستقيم',
            activationLabel: 'تفعيل دائم بدون تاريخ انتهاء',
          ),
        ],
        results: <StudentExamResultModel>[
          StudentExamResultModel(
            title: 'امتحان الحركة في خط مستقيم',
            scoreLabel: '١٨ / ٢٠',
            dateLabel: '١٢ نوفمبر ٢٠٢٦',
          ),
        ],
      ),
      StudentModel(
        id: 'student_3',
        name: 'مريم أحمد',
        email: 'mariam@example.com',
        grade: StudentGrade.firstSecondary,
        courses: <StudentCourseModel>[
          StudentCourseModel(
            id: 'course_4',
            title: 'القياس والأخطاء',
            activationLabel: 'تفعيل دائم بدون تاريخ انتهاء',
          ),
        ],
      ),
      StudentModel(
        id: 'student_4',
        name: 'عمر خالد',
        email: 'omar@example.com',
        grade: StudentGrade.thirdSecondary,
      ),
      StudentModel(
        id: 'student_5',
        name: 'سلمى محمود',
        email: 'salma@example.com',
        grade: StudentGrade.secondSecondary,
        isActive: false,
      ),
      StudentModel(
        id: 'student_6',
        name: 'آدم يوسف',
        email: 'adam@example.com',
        grade: StudentGrade.firstSecondary,
      ),
      StudentModel(
        id: 'student_7',
        name: 'لينا طارق',
        email: 'lina@example.com',
        grade: StudentGrade.thirdSecondary,
        isLoginLinked: false,
      ),
      StudentModel(
        id: 'student_8',
        name: 'زياد حسن',
        email: 'ziad@example.com',
        grade: StudentGrade.secondSecondary,
      ),
    ];
  }
}
