import 'package:diamond_selection/features/diamond/data/data_sources/data.dart';
import 'package:hive/hive.dart';

import '../models/diamond_model.dart';

abstract class DiamondLocalDataSource {
  Future<List<DiamondModel>> getDiamonds();

  Future<List<DiamondModel>> getCartDiamonds();

  Future<void> addToCart(DiamondModel diamond);

  Future<void> removeFromCart(DiamondModel diamond);
}

class DiamondLocalDataSourceImpl implements DiamondLocalDataSource {
  final Box<DiamondModel> cartBox;

  DiamondLocalDataSourceImpl({required this.cartBox});

  @override
  Future<List<DiamondModel>> getDiamonds() async {
    return diamondData;
  }

  @override
  Future<void> addToCart(DiamondModel diamond) async {
    await cartBox.put(diamond.lotId, diamond);
  }

  @override
  Future<List<DiamondModel>> getCartDiamonds() async {
    return cartBox.values.toList();
  }

  @override
  Future<void> removeFromCart(DiamondModel diamond) async {
    await cartBox.delete(diamond.lotId);
  }
}
