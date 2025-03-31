import 'package:diamond_selection/core/services/injection/injectiontion_container.dart';
import 'package:diamond_selection/core/services/routes/app_router.dart';
import 'package:diamond_selection/features/diamond/presentation/bloc/cart/cart_bloc.dart';
import 'package:diamond_selection/features/diamond/presentation/bloc/diamond/diamond_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<DiamondBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<CartBloc>(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Diamond Selection App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme:
          ColorScheme.fromSeed(seedColor: Colors.blueAccent),
          useMaterial3: true,
        ),
        routerConfig: router,
      ),
    );
  }
}
