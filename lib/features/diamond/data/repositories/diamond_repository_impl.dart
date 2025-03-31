import 'package:dartz/dartz.dart';
import 'package:diamond_selection/features/diamond/data/models/diamond_model.dart';

import '../../../../core/error/app_failures.dart';
import '../../domain/entities/diamond.dart';
import '../../domain/repositories/diamond_repository.dart';
import '../data_sources/diamond_local_data_source.dart';

class DiamondRepositoryImpl implements DiamondRepository {
  final DiamondLocalDataSource localDataSource;

  DiamondRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, List<Diamond>>> getDiamonds() async {
    try {
      final diamonds = await localDataSource.getDiamonds();
      return Right(diamonds);
    } catch (e) {
      return Left(ServerFailure(
          message: 'Failed to get diamonds from excel', statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, List<Diamond>>> filterDiamonds(
      Map<String, dynamic> filters) async {
    try {
      final diamonds = await localDataSource.getDiamonds();
      final filteredDiamonds = diamonds.where((diamond) {
        return filters.entries.every((filter) {
          final key = filter.key;
          final value = filter.value;

          if (value == null) return true;

          switch (key) {
            case 'caratFrom':
              return diamond.carat >= value;
            case 'caratTo':
              return diamond.carat <= value;
            case 'lab':
              return diamond.lab == value;
            case 'shape':
              return diamond.shape == value;
            case 'color':
              return diamond.color == value;
            case 'clarity':
              return diamond.clarity == value;

            default:
              return true;
          }
        });
      }).toList();

      return Right(filteredDiamonds);
    } catch (e) {
      return Left(
          ServerFailure(message: 'Failed to filter diamonds', statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, List<Diamond>>> getCartDiamonds() async {
    final diamonds = await localDataSource.getCartDiamonds();
    return Right(diamonds);
  }

  @override
  Future<Either<Failure, void>> addToCart(Diamond diamond) async {
    final box = await localDataSource.addToCart(diamond as DiamondModel);
    return Right(box);
  }

  @override
  Future<Either<Failure, void>> removeFromCart(Diamond diamond) async {
    final box = await localDataSource.removeFromCart(diamond as DiamondModel);
    return Right(box);
  }
}
