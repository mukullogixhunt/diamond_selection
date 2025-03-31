import 'package:dartz/dartz.dart';
import 'package:diamond_selection/core/usecases/usecase.dart';

import '../../../../core/error/app_failures.dart';
import '../entities/diamond.dart';
import '../repositories/diamond_repository.dart';

class AddToCartUseCase implements UseCase<void, Diamond> {
  final DiamondRepository repository;

  AddToCartUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(Diamond diamond) async{
    return await repository.addToCart(diamond);
  }
}