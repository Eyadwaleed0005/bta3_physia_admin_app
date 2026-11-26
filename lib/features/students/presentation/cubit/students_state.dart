import 'package:equatable/equatable.dart';

import '../../../grades/data/models/grade_model.dart';
import '../../data/models/student_model.dart';

enum StudentsStatus { loading, success, empty, failure }

class StudentsState extends Equatable {
  const StudentsState({
    this.status = StudentsStatus.loading,
    this.students = const <StudentModel>[],
    this.availableGrades = const <GradeModel>[],
    this.query = '',
    this.gradeFilter,
    this.visibleCount = pageSize,
    this.isRefreshing = false,
    this.errorMessage,
  });

  static const int pageSize = 4;

  final StudentsStatus status;
  final List<StudentModel> students;

  final List<GradeModel> availableGrades;
  final String query;
  final GradeModel? gradeFilter;
  final int visibleCount;
  final bool isRefreshing;
  final String? errorMessage;

  bool get hasSearch => query.trim().isNotEmpty;

  bool get hasMore => filteredStudents.length > visibleCount;

  List<StudentModel> get filteredStudents {
    final String normalizedQuery = query.trim().toLowerCase();

    return students
        .where((StudentModel student) {
          final bool matchesGrade =
              gradeFilter == null || student.gradeId == gradeFilter!.id;

          if (!matchesGrade) return false;

          if (normalizedQuery.isEmpty) return true;

          return student.name.toLowerCase().contains(normalizedQuery) ||
              student.email.toLowerCase().contains(normalizedQuery);
        })
        .toList(growable: false);
  }

  List<StudentModel> get visibleStudents {
    final List<StudentModel> filtered = filteredStudents;

    if (visibleCount >= filtered.length) return filtered;

    return filtered.sublist(0, visibleCount);
  }

  String get searchResultTitle {
    if (!hasSearch) return '';

    final String trimmedQuery = query.trim();

    return trimmedQuery.contains('@')
        ? 'نتيجة البحث: بالبريد'
        : 'نتيجة البحث: $trimmedQuery';
  }

  String get listTitle {
    if (hasSearch) return searchResultTitle;
    if (gradeFilter != null) return gradeFilter!.name;

    return 'قائمة الطلاب';
  }

  StudentsState copyWith({
    StudentsStatus? status,
    List<StudentModel>? students,
    List<GradeModel>? availableGrades,
    String? query,
    GradeModel? gradeFilter,
    bool clearGradeFilter = false,
    int? visibleCount,
    bool? isRefreshing,
    String? errorMessage,
    bool clearError = false,
  }) {
    return StudentsState(
      status: status ?? this.status,
      students: students ?? this.students,
      availableGrades: availableGrades ?? this.availableGrades,
      query: query ?? this.query,
      gradeFilter: clearGradeFilter ? null : (gradeFilter ?? this.gradeFilter),
      visibleCount: visibleCount ?? this.visibleCount,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => <Object?>[
    status,
    students,
    availableGrades,
    query,
    gradeFilter,
    visibleCount,
    isRefreshing,
    errorMessage,
  ];
}
