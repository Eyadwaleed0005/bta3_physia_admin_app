import 'package:bta3_physia_admin/app/dependency_injection/service_locator.dart';
import 'package:bta3_physia_admin/app/routes/screen_routes/route_names.dart';
import 'package:bta3_physia_admin/core/transition/app_transition.dart';
import 'package:bta3_physia_admin/features/students/presentation/cubit/student_details_cubit.dart';
import 'package:bta3_physia_admin/features/students/presentation/cubit/students_cubit.dart';
import 'package:bta3_physia_admin/features/students/presentation/screens/student_courses_screen.dart';
import 'package:bta3_physia_admin/features/students/presentation/screens/student_details_screen.dart';
import 'package:bta3_physia_admin/features/students/presentation/screens/student_results_screen.dart';
import 'package:bta3_physia_admin/features/students/presentation/screens/students_grade_filter_screen.dart';
import 'package:bta3_physia_admin/features/students/presentation/screens/students_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract final class StudentsRoutes {
  const StudentsRoutes._();

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.studentsScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider<StudentsCubit>(
            create: (context) => getIt<StudentsCubit>()..load(),
            child: const StudentsScreen(),
          ),
        );

      case RouteNames.studentDetailsScreen:
        // Argument: the student id.
        final Object? detailsArgs = settings.arguments;
        if (detailsArgs is! String) return null;

        return AppTransition.simpleTransition(
          settings: settings,
          screen: BlocProvider<StudentDetailsCubit>(
            create: (_) => getIt<StudentDetailsCubit>()..load(detailsArgs),
            child: const StudentDetailsScreen(),
          ),
        );

      case RouteNames.studentCoursesScreen:
        // Argument: the shared details cubit from the details screen.
        final Object? coursesArgs = settings.arguments;
        if (coursesArgs is! StudentDetailsCubit) return null;

        return AppTransition.simpleTransition(
          settings: settings,
          screen: BlocProvider<StudentDetailsCubit>.value(
            value: coursesArgs,
            child: const StudentCoursesScreen(),
          ),
        );

      case RouteNames.studentResultsScreen:
        // Argument: the shared details cubit from the details screen.
        final Object? resultsArgs = settings.arguments;
        if (resultsArgs is! StudentDetailsCubit) return null;

        return AppTransition.simpleTransition(
          settings: settings,
          screen: BlocProvider<StudentDetailsCubit>.value(
            value: resultsArgs,
            child: const StudentResultsScreen(),
          ),
        );

      case RouteNames.studentsGradeFilterScreen:
        // Argument: the students-list cubit, so this screen can apply the grade.
        final Object? filterArgs = settings.arguments;
        if (filterArgs is! StudentsCubit) return null;

        return AppTransition.simpleTransition(
          settings: settings,
          screen: StudentsGradeFilterScreen(cubit: filterArgs),
        );

      default:
        return null;
    }
  }
}
