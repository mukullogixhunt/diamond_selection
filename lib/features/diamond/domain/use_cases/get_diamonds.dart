import 'package:dartz/dartz.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../core/error/app_failures.dart';
import '../entities/diamond.dart';
import '../repositories/diamond_repository.dart';

class GetDiamondsUseCase implements UseCase<List<Diamond>, NoParams> {
  final DiamondRepository repository;

  GetDiamondsUseCase(this.repository);

  @override
  Future<Either<Failure, List<Diamond>>> call(NoParams params) async {
    return await repository.getDiamonds();
  }
}
