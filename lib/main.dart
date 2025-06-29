import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'screens/home_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/scenario_builder_screen.dart';
import 'screens/simulator_screen.dart';
import 'screens/kpi_dashboard_screen.dart';
import 'auth/login_screen.dart';
import 'auth/register_screen.dart';
import 'auth/auth_confirm_screen.dart';

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'dashboard',
          builder: (context, state) => const DashboardScreen(),
        ),
        GoRoute(
          path: 'Builder',
          builder: (context, state) => const ScenarioBuilderScreen(initialDomain: 'Healthcare'),
        ),
        GoRoute(
          path: 'simulator',
          builder: (context, state) => const SimulatorScreen(),
        ),
        GoRoute(
          path: 'kpi',
          builder: (context, state) => const KpiDashboardScreen(),
        ), 
        
      ],
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/signUp',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/confirm',
      builder: (context, state) {
        final email = state.extra as String;
        return AuthConfirmScreen(email: email);
      },
    ),
  ],
);

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'DeepTrain',
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      theme: ThemeData(primarySwatch: Colors.indigo),
    );
  }
}
