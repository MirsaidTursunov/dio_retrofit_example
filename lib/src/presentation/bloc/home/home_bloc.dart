import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:for_network/src/data/models/get_user_response.dart';
import 'package:for_network/src/domain/repositories/home_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required this.homeRepository,
  }) : super(const HomeState()) {
    on<GetUsersEvent>(_getUsers);
  }

  final HomeRepository homeRepository;

  Future<void> _getUsers(GetUsersEvent event,
      Emitter<HomeState> emit) async {
    emit(state.copyWith(
      getStatus: GetUsersStatus.loading,
    ));
    final result = await homeRepository.getAllObjects();

    emit(state.copyWith(
      usersList: result,
      getStatus: GetUsersStatus.success
    ));
  }

}
