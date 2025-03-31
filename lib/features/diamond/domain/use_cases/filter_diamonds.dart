import 'package:dartz/dartz.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../core/error/app_failures.dart';
import '../entities/diamond.dart';
import '../repositories/diamond_repository.dart';

class FilterDiamondsUseCase implements UseCase<List<Diamond>, Map<String, dynamic>> {
  final DiamondRepository repository;

  FilterDiamondsUseCase(this.repository);

  @override
  Future<Either<Failure, List<Diamond>>> call(Map<String, dynamic> params) async {
    return await repository.filterDiamonds(params);
  }
}
