part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginUsernameChanged extends LoginEvent {
  final String username;

  const LoginUsernameChanged({required this.username});

  @override
  List<Object> get props => [username];
}

class LoginPasswordChanged extends LoginEvent {
  final String password;

  const LoginPasswordChanged({required this.password});

  @override
  List<Object> get props => [password];
}

class LoginSubmitted extends LoginEvent {}
