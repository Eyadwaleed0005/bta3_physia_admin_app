import 'package:bta3_physia_admin/app/dependency_injection/core_dependencies.dart';
import 'package:bta3_physia_admin/app/dependency_injection/features/grades_dependencies.dart';
import 'package:bta3_physia_admin/app/dependency_injection/features/home_dependencies.dart';
import 'package:bta3_physia_admin/app/dependency_injection/features/main_navigation_dependencies.dart';
import 'package:bta3_physia_admin/app/dependency_injection/features/students_dependencies.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  registerCoreDependencies(getIt);
  registerHomeDependencies(getIt);
  registerMainNavigationDependencies(getIt);
  registerStudentsDependencies(getIt);
  registerGradesDependencies(getIt);
}
