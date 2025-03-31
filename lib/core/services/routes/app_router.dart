import 'package:diamond_selection/features/diamond/presentation/pages/cart_screen.dart';
import 'package:diamond_selection/features/diamond/presentation/pages/filter_screen.dart';
import 'package:diamond_selection/features/diamond/presentation/pages/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();



final GoRouter router = GoRouter(
  initialLocation: '/',
  navigatorKey: rootNavigatorKey,
  routes: [
    GoRoute(
      path: FilterScreen.path,
      builder: (context, state) => const FilterScreen(),
    ),
    GoRoute(
      path: ResultScreen.path,
      builder: (context, state) =>
          ResultScreen(filters: state.extra as Map<String,dynamic>),
    ),
    GoRoute(
      path: CartScreen.path,
      builder: (context, state) => const CartScreen(),
    ),
  ],
);
