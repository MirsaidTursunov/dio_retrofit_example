import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:for_network/src/data/models/post_user_request.dart';
import 'package:for_network/src/domain/repositories/add_user_repository.dart';

import '../../../data/models/get_one_user_response.dart';

part 'add_user_event.dart';

part 'add_user_state.dart';

class AddUserBloc extends Bloc<AddUserEvent, AddUserState> {
  AddUserBloc() : super(const AddUserState()) {
    on<AddOneUserEvent>(_addUser);
  }

  final _addRepository = AddUserRepository();

  Future<void> _addUser(
      AddOneUserEvent event, Emitter<AddUserState> emit) async {
    final result = await _addRepository.addOneUser(
      postUserRequest: PostUserRequest(
        name: event.name,
        job: event.job,
      ),
    );
    emit(state.copyWith(
        user: result,
    ));
  }
}
