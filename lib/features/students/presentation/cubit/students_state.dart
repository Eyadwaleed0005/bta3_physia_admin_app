import 'package:equatable/equatable.dart';

import '../../data/models/student_model.dart';

enum StudentsStatus { loading, success, empty, failure }

class StudentsState extends Equatable {
  const StudentsState({
    this.status = StudentsStatus.loading,
    this.students = const <StudentModel>[],
    this.query = '',
    this.gradeFilter,
    this.visibleCount = pageSize,
    this.isRefreshing = false,
    this.errorMessage,
  });

  //to show only 4 students at a time
  static const int pageSize = 4;

  final StudentsStatus status;
  final List<StudentModel> students;
  final String query;
  final StudentGrade? gradeFilter;
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
              gradeFilter == null || student.grade == gradeFilter;

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
    if (gradeFilter != null) return gradeFilter!.label;

    return 'قائمة الطلاب';
  }

  StudentsState copyWith({
    StudentsStatus? status,
    List<StudentModel>? students,
    String? query,
    StudentGrade? gradeFilter,
    bool clearGradeFilter = false,
    int? visibleCount,
    bool? isRefreshing,
    String? errorMessage,
    bool clearError = false,
  }) {
    return StudentsState(
      status: status ?? this.status,
      students: students ?? this.students,
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
    query,
    gradeFilter,
    visibleCount,
    isRefreshing,
    errorMessage,
  ];
}
