part of 'diamond_bloc.dart';

sealed class DiamondState extends Equatable {
  const DiamondState();

  @override
  List<Object> get props => [];
}

class DiamondInitial extends DiamondState {}

class DiamondLoading extends DiamondState {}

class DiamondLoaded extends DiamondState {
  final List<Diamond> diamonds;

  const DiamondLoaded(this.diamonds);

  @override
  List<Object> get props => [diamonds];
}

class DiamondError extends DiamondState {
  final String message;

  const DiamondError(this.message);
}


