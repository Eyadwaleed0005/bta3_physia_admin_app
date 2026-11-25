import 'package:bta3_physia_admin/features/students/presentation/cubit/student_details_cubit.dart';
import 'package:bta3_physia_admin/features/students/presentation/cubit/students_cubit.dart';
import 'package:get_it/get_it.dart';

void registerStudentsDependencies(GetIt getIt) {
  _registerCubits(getIt);
}

void _registerCubits(GetIt getIt) {
  getIt.registerFactory<StudentsCubit>(() => StudentsCubit());
  getIt.registerFactory<StudentDetailsCubit>(() => StudentDetailsCubit());
}
