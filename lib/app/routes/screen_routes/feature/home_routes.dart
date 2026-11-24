import 'package:bta3_physia_admin/app/dependency_injection/service_locator.dart';
import 'package:bta3_physia_admin/app/routes/screen_routes/route_names.dart';
import 'package:bta3_physia_admin/features/home/presentation/cubit/home_cubit.dart';
import 'package:bta3_physia_admin/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract final class HomeRoutes {
  const HomeRoutes._();

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.homeScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider<HomeCubit>(
            create: (context) => getIt<HomeCubit>(),
            child: HomeScreen(),
          ),
        );

      default:
        return null;
    }
  }
}
