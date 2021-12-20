part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  final User user;
  final AuthenticationStatus status;

  const AuthenticationState._(
      {this.user = User.empty,
      this.status = AuthenticationStatus.unauthenticated});

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(User user)
      : this._(user: user, status: AuthenticationStatus.authenticated);

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  @override
  List<Object> get props => [status, user];
}
