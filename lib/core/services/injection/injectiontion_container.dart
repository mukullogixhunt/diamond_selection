import 'package:diamond_selection/features/diamond/data/data_sources/diamond_local_data_source.dart';
import 'package:diamond_selection/features/diamond/data/models/diamond_model.dart';
import 'package:diamond_selection/features/diamond/data/repositories/diamond_repository_impl.dart';
import 'package:diamond_selection/features/diamond/domain/repositories/diamond_repository.dart';
import 'package:diamond_selection/features/diamond/domain/use_cases/add_to_cart_usecase.dart';
import 'package:diamond_selection/features/diamond/domain/use_cases/filter_diamonds.dart';
import 'package:diamond_selection/features/diamond/domain/use_cases/get_cart_diamonds_usecase.dart';
import 'package:diamond_selection/features/diamond/domain/use_cases/get_diamonds.dart';
import 'package:diamond_selection/features/diamond/domain/use_cases/remove_from_cart_usecase.dart';
import 'package:diamond_selection/features/diamond/presentation/bloc/cart/cart_bloc.dart';
import 'package:diamond_selection/features/diamond/presentation/bloc/diamond/diamond_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// **Hive Initialization**
  await Hive.initFlutter();

  /// **Register Hive Adapter**
  Hive.registerAdapter(DiamondModelAdapter());

  /// **Open Hive Box**
  final cartBox = await Hive.openBox<DiamondModel>('cart');

  /// **Inject Hive Box**
  sl.registerLazySingleton<Box<DiamondModel>>(() => cartBox);

  /// **Data Sources**
  sl.registerLazySingleton<DiamondLocalDataSource>(
    () => DiamondLocalDataSourceImpl(cartBox: sl()),
  );

  /// **Repositories**
  sl.registerLazySingleton<DiamondRepository>(
    () => DiamondRepositoryImpl(sl()),
  );

  /// **Use Cases**
  sl.registerLazySingleton(() => GetDiamondsUseCase(sl()));
  sl.registerLazySingleton(() => FilterDiamondsUseCase(sl()));
  sl.registerLazySingleton(() => GetCartDiamondsUseCase(sl()));
  sl.registerLazySingleton(() => AddToCartUseCase(sl()));
  sl.registerLazySingleton(() => RemoveFromCartUseCase(sl()));

  /// **Bloc**
  sl.registerFactory(
      () => DiamondBloc(getDiamondsUseCase: sl(), filterDiamondsUseCase: sl()));
  sl.registerFactory(() => CartBloc(
      getCartDiamondsUseCase: sl(),
      addToCartUseCase: sl(),
      removeFromCartUseCase: sl()));
}
