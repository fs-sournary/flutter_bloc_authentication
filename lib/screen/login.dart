import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_authentication/bloc/bloc.dart';
import 'package:flutter_bloc_authentication/widget/login_form.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  static Route route() => MaterialPageRoute(
        builder: (context) => const Login(),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocProvider(
          create: (context) =>
              LoginBloc(context.read<AuthenticationRepository>()),
          child: const LoginForm(),
        ),
      ));
}
