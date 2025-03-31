import 'package:dartz/dartz.dart';
import 'package:diamond_selection/core/usecases/usecase.dart';

import '../../../../core/error/app_failures.dart';
import '../entities/diamond.dart';
import '../repositories/diamond_repository.dart';

class GetCartDiamondsUseCase implements UseCase<List<Diamond>, NoParams> {
  final DiamondRepository repository;

  GetCartDiamondsUseCase(this.repository);

  @override
  Future<Either<Failure, List<Diamond>>> call(NoParams params) {
    return repository.getCartDiamonds();
  }
}
