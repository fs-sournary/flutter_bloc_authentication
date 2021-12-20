import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  late StreamSubscription<AuthenticationStatus>
      _authenticationStreamSubscription;

  AuthenticationBloc(
      {required AuthenticationRepository authenticationRepository,
      required UserRepository userRepository})
      : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(const AuthenticationState.unknown()) {
    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
    _authenticationStreamSubscription = authenticationRepository.status
        .listen((status) => add(AuthenticationStatusChanged(status: status)));
  }

  Future<void> _onAuthenticationStatusChanged(AuthenticationStatusChanged event,
      Emitter<AuthenticationState> emit) async {
    switch (event.status) {
      case AuthenticationStatus.authenticated:
        final user = await _tryGetUser();
        emit(user != null
            ? AuthenticationState.authenticated(user)
            : const AuthenticationState.unauthenticated());
        break;
      case AuthenticationStatus.unauthenticated:
        emit(const AuthenticationState.unauthenticated());
        break;
      default:
        emit(const AuthenticationState.unknown());
        break;
    }
  }

  Future<User?> _tryGetUser() async {
    try {
      final user = await _userRepository.getUser();
      return user;
    } catch (_) {
      return null;
    }
  }

  void _onAuthenticationLogoutRequested(
      AuthenticationLogoutRequested event, Emitter<AuthenticationState> emit) {
    _authenticationRepository.logout();
  }

  @override
  Future<void> close() {
    _authenticationStreamSubscription.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }
}
