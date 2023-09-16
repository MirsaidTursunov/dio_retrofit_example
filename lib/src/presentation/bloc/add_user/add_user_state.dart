part of 'add_user_bloc.dart';

class AddUserState extends Equatable {
  final GetOneUserResponse? user;

  const AddUserState({this.user});

  AddUserState copyWith({
    GetOneUserResponse? user,
  }) {
    return AddUserState(
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [user];
}
