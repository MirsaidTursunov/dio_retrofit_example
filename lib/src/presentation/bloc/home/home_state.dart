part of 'home_bloc.dart';

class HomeState extends Equatable {
  final GetUsersResponse? usersList;
  final GetUsersStatus? getStatus;

  const HomeState({this.usersList, this.getStatus});

  HomeState copyWith({
    GetUsersResponse? usersList,
    GetUsersStatus? getStatus,
  }) {
    return HomeState(
      usersList: usersList ?? this.usersList,
      getStatus: getStatus ?? this.getStatus
    );
  }

  @override
  List<Object?> get props => [usersList, getStatus];
}

enum GetUsersStatus { initial, loading, success, error }

extension GetUsersStatusX on GetUsersStatus {
  bool get initial => this == GetUsersStatus.initial;

  bool get isLoading => this == GetUsersStatus.loading;

  bool get isSuccess => this == GetUsersStatus.success;

  bool get isError => this == GetUsersStatus.error;
}