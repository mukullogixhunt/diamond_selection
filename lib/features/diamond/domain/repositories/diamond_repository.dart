import 'package:dartz/dartz.dart';
import 'package:diamond_selection/core/error/app_failures.dart';
import 'package:diamond_selection/features/diamond/domain/entities/diamond.dart';

abstract class DiamondRepository {
  Future<Either<Failure, List<Diamond>>> getDiamonds();

  Future<Either<Failure, List<Diamond>>> filterDiamonds(
      Map<String, dynamic> filters);

  Future<Either<Failure, List<Diamond>>> getCartDiamonds();

  Future<Either<Failure, void>> addToCart(Diamond diamond);

  Future<Either<Failure, void>> removeFromCart(Diamond diamond);
}
