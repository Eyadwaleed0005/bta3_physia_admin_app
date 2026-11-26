import 'package:bta3_physia_admin/app/dependency_injection/service_locator.dart';
import 'package:bta3_physia_admin/app/routes/screen_routes/route_names.dart';
import 'package:bta3_physia_admin/core/transition/app_transition.dart';
import 'package:bta3_physia_admin/features/live/presentation/cubit/live_cubit.dart';
import 'package:bta3_physia_admin/features/live/presentation/args/live_form_args.dart';
import 'package:bta3_physia_admin/features/live/presentation/screens/live_form_screen.dart';
import 'package:bta3_physia_admin/features/live/presentation/screens/live_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract final class LiveRoutes {
  const LiveRoutes._();

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.liveScreen:
        return AppTransition.simpleTransition(
          settings: settings,
          screen: BlocProvider<LiveCubit>(
            create: (_) => getIt<LiveCubit>()..load(),
            child: const LiveScreen(),
          ),
        );

      case RouteNames.liveFormScreen:
        // Argument: the live cubit plus the stream being edited (null = create).
        final Object? formArgs = settings.arguments;
        if (formArgs is! LiveFormArgs) return null;

        return AppTransition.simpleTransition(
          settings: settings,
          screen: BlocProvider<LiveCubit>.value(
            value: formArgs.cubit,
            child: LiveFormScreen(initialLive: formArgs.initialLive),
          ),
        );

      default:
        return null;
    }
  }
}
