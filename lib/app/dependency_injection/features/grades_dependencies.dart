import 'package:bta3_physia_admin/features/grades/presentation/cubit/grades_cubit.dart';
import 'package:get_it/get_it.dart';

void registerGradesDependencies(GetIt getIt) {
  _registerCubits(getIt);
}

void _registerCubits(GetIt getIt) {
  getIt.registerFactory<GradesCubit>(() => GradesCubit());
}
