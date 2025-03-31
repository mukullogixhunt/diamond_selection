part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();


  @override
  List<Object?> get props => [];
}

class AddToCartEvent extends CartEvent {
  final Diamond diamond;

  const AddToCartEvent(this.diamond);

  @override
  List<Object?> get props => [diamond];
}

class RemoveFromCartEvent extends CartEvent {
  final Diamond diamond;

  const RemoveFromCartEvent(this.diamond);

  @override
  List<Object?> get props => [diamond];
}

class LoadCartEvent extends CartEvent {}
