import 'package:bloc/bloc.dart';
import 'package:diamond_selection/features/diamond/domain/entities/diamond.dart';
import 'package:diamond_selection/features/diamond/domain/use_cases/add_to_cart_usecase.dart';
import 'package:diamond_selection/features/diamond/domain/use_cases/get_cart_diamonds_usecase.dart';
import 'package:diamond_selection/features/diamond/domain/use_cases/remove_from_cart_usecase.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/usecases/usecase.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {

  final AddToCartUseCase addToCartUseCase;
  final RemoveFromCartUseCase removeFromCartUseCase;
  final GetCartDiamondsUseCase getCartDiamondsUseCase;

  CartBloc({
    required this.addToCartUseCase,
    required this.removeFromCartUseCase,
    required this.getCartDiamondsUseCase,
  }) : super(CartInitial()) {
    on<CartEvent>((event, emit) {
    });
    on<AddToCartEvent>(_onAddToCart);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
    on<LoadCartEvent>(_onLoadCart);
  }

  Future<void> _onAddToCart(
      AddToCartEvent event, Emitter<CartState> emit) async {
    final result = await addToCartUseCase(event.diamond);

    result.fold(
          (failure) => emit(CartError(failure.message)), // Handle failure case
          (_) => add(LoadCartEvent()), // Proceed to reload the cart on success
    );
  }

  Future<void> _onRemoveFromCart(
      RemoveFromCartEvent event, Emitter<CartState> emit) async {
    final result = await removeFromCartUseCase(event.diamond);

    result.fold(
          (failure) => emit(CartError(failure.message)), // Handle failure case
          (_) => add(LoadCartEvent()), // Proceed to reload the cart on success
    );
  }

  Future<void> _onLoadCart(
      LoadCartEvent event, Emitter<CartState> emit) async {
    final result = await getCartDiamondsUseCase(NoParams());

    result.fold(
          (failure) => emit(CartError(failure.message)), // Handle failure
          (cartDiamonds) =>
          emit(CartLoaded(cartDiamonds)), // Pass diamonds to state
    );
  }
}
