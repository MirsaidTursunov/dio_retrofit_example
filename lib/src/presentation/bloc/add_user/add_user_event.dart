part of 'add_user_bloc.dart';

abstract class AddUserEvent extends Equatable {
  const AddUserEvent();
}

class AddOneUserEvent extends AddUserEvent {
  final String name;
  final String job;
  const AddOneUserEvent({required this.name,required this.job});

  @override
  List<Object?> get props => [name, job];
}
