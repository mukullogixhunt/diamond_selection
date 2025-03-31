part of 'diamond_bloc.dart';

sealed class DiamondEvent extends Equatable {
  const DiamondEvent();

  @override
  List<Object?> get props => [];
}

class LoadDiamondsEvent extends DiamondEvent {}

class FilterDiamondsEvent extends DiamondEvent {
  final Map<String, dynamic> filters;

  const FilterDiamondsEvent(this.filters);

  @override
  List<Object?> get props => [filters];
}


