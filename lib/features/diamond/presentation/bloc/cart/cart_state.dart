part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartInitial extends CartState {

}

class CartError extends CartState {
  final String message;

  const CartError(this.message);
}

class CartLoaded extends CartState {
  final List<Diamond> cartDiamonds;

  const CartLoaded(this.cartDiamonds);

  @override
  List<Object> get props => [cartDiamonds];
}
