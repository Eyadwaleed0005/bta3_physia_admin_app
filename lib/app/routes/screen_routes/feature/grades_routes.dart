import 'package:bta3_physia_admin/app/dependency_injection/service_locator.dart';
import 'package:bta3_physia_admin/app/routes/screen_routes/route_names.dart';
import 'package:bta3_physia_admin/core/transition/app_transition.dart';
import 'package:bta3_physia_admin/features/grades/data/models/grade_model.dart';
import 'package:bta3_physia_admin/features/grades/presentation/cubit/grades_cubit.dart';
import 'package:bta3_physia_admin/features/grades/presentation/screens/grade_form_screen.dart';
import 'package:bta3_physia_admin/features/grades/presentation/screens/grades_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract final class GradesRoutes {
  const GradesRoutes._();

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.gradesScreen:
        return AppTransition.simpleTransition(
          settings: settings,
          screen: BlocProvider<GradesCubit>(
            create: (_) => getIt<GradesCubit>()..load(),
            child: const GradesScreen(),
          ),
        );

      case RouteNames.gradeFormScreen:
        // Argument: a GradeModel to edit, or null to add a new grade.
        final Object? formArgs = settings.arguments;
        if (formArgs != null && formArgs is! GradeModel) return null;

        return AppTransition.simpleTransition(
          settings: settings,
          screen: BlocProvider<GradesCubit>(
            create: (_) => getIt<GradesCubit>()..load(),
            child: GradeFormScreen(grade: formArgs as GradeModel?),
          ),
        );

      default:
        return null;
    }
  }
}
