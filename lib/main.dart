import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_authentication/app.dart';
import 'package:flutter_bloc_authentication/bloc/app_bloc_observer.dart';
import 'package:user_repository/user_repository.dart';

void main() {
  BlocOverrides.runZoned(
      () => runApp(App(
          authenticationRepository: AuthenticationRepository(),
          userRepository: UserRepository())),
      blocObserver: AppBlocObserver());
}
