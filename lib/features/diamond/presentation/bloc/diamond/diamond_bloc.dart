import 'package:bloc/bloc.dart';
import 'package:diamond_selection/core/usecases/usecase.dart';
import 'package:diamond_selection/features/diamond/domain/entities/diamond.dart';
import 'package:diamond_selection/features/diamond/domain/use_cases/add_to_cart_usecase.dart';
import 'package:diamond_selection/features/diamond/domain/use_cases/filter_diamonds.dart';
import 'package:diamond_selection/features/diamond/domain/use_cases/get_cart_diamonds_usecase.dart';
import 'package:diamond_selection/features/diamond/domain/use_cases/get_diamonds.dart';
import 'package:diamond_selection/features/diamond/domain/use_cases/remove_from_cart_usecase.dart';
import 'package:equatable/equatable.dart';

part 'diamond_event.dart';
part 'diamond_state.dart';

class DiamondBloc extends Bloc<DiamondEvent, DiamondState> {
  final GetDiamondsUseCase getDiamondsUseCase;
  final FilterDiamondsUseCase filterDiamondsUseCase;



  DiamondBloc({
    required this.getDiamondsUseCase,
    required this.filterDiamondsUseCase,

  }) : super(DiamondInitial()) {
    on<LoadDiamondsEvent>(_onLoadDiamonds);
    on<FilterDiamondsEvent>(_onFilterDiamonds);

  }

  Future<void> _onLoadDiamonds(
      LoadDiamondsEvent event, Emitter<DiamondState> emit) async {
    emit(DiamondLoading());
    final result = await getDiamondsUseCase(NoParams());
    result.fold(
      (failure) => emit(DiamondError('Failed to load diamonds')),
      (diamonds) => emit(DiamondLoaded(diamonds)),
    );
  }

  Future<void> _onFilterDiamonds(
      FilterDiamondsEvent event, Emitter<DiamondState> emit) async {
    emit(DiamondLoading());
    final result = await filterDiamondsUseCase(event.filters);
    result.fold(
      (failure) => emit(DiamondError('Filtering failed')),
      (diamonds) => emit(DiamondLoaded(diamonds)),
    );
  }


}
