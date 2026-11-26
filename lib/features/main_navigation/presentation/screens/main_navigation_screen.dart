import 'package:bta3_physia_admin/app/dependency_injection/service_locator.dart';
import 'package:bta3_physia_admin/core/constant/main_navigation_tabs.dart';
import 'package:bta3_physia_admin/features/home/presentation/cubit/home_cubit.dart';
import 'package:bta3_physia_admin/features/home/presentation/screens/home_screen.dart';
import 'package:bta3_physia_admin/features/main_navigation/presentation/cubit/bottom_navigation_cubit.dart';
import 'package:bta3_physia_admin/features/main_navigation/presentation/widgets/custom_bottom_nav_bar.dart';
import 'package:bta3_physia_admin/features/more/presentation/screens/more_screen.dart';
import 'package:bta3_physia_admin/features/students/presentation/cubit/students_cubit.dart';
import 'package:bta3_physia_admin/features/students/presentation/screens/students_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({
    super.key,
    this.initialIndex = MainNavigationTabs.home,
  });

  final int initialIndex;

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  late final BottomNavigationCubit _bottomNavigationCubit;

  @override
  void initState() {
    super.initState();
    _bottomNavigationCubit = getIt<BottomNavigationCubit>()
      ..changeIndex(widget.initialIndex.clamp(0, MainNavigationTabs.count - 1));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BottomNavigationCubit>.value(
      value: _bottomNavigationCubit,
      child: SafeArea(
        child: Scaffold(
          extendBody: true,
          body: BlocBuilder<BottomNavigationCubit, int>(
            builder: (BuildContext context, int selectedIndex) {
              final int currentIndex = selectedIndex.clamp(
                0,
                MainNavigationTabs.count - 1,
              );
              return KeyedSubtree(
                key: ValueKey<String>(_screenKey(currentIndex: currentIndex)),
                child: _buildScreen(
                  context: context,
                  currentIndex: currentIndex,
                ),
              );
            },
          ),
          bottomNavigationBar: const CustomBottomNavBar(),
        ),
      ),
    );
  }

  Widget _buildScreen({
    required BuildContext context,
    required int currentIndex,
  }) {
    switch (currentIndex) {
      case MainNavigationTabs.home:
        return BlocProvider(
          create: (context) => getIt<HomeCubit>()..load(),
          child: const HomeScreen(),
        );

      case MainNavigationTabs.students:
        return BlocProvider(
          create: (context) => getIt<StudentsCubit>()..load(),
          child: const StudentsScreen(),
        );

      case MainNavigationTabs.courses:
        return BlocProvider(
          create: (context) => getIt<HomeCubit>(),
          child: const HomeScreen(),
        );

      case MainNavigationTabs.exams:
        return BlocProvider(
          create: (context) => getIt<HomeCubit>(),
          child: const HomeScreen(),
        );

      case MainNavigationTabs.more:
        return const MoreScreen();

      default:
        return BlocProvider(
          create: (context) => getIt<HomeCubit>(),
          child: const HomeScreen(),
        );
    }
  }

  String _screenKey({required int currentIndex}) {
    switch (currentIndex) {
      case MainNavigationTabs.home:
        return 'screen_$currentIndex';
      case MainNavigationTabs.students:
        return 'screen_$currentIndex';
      case MainNavigationTabs.courses:
        return 'screen_$currentIndex';
      case MainNavigationTabs.exams:
        return 'screen_$currentIndex';
      case MainNavigationTabs.more:
        return 'screen_$currentIndex';
      default:
        return 'screen_$currentIndex';
    }
  }
}
