import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_authentication/bloc/bloc.dart';
import 'package:flutter_bloc_authentication/model/model.dart';
import 'package:formz/formz.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
                const SnackBar(content: Text('Authentication failed')));
        }
      },
      child: Align(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            _UsernameInput(),
            Padding(padding: EdgeInsets.all(16)),
            _PasswordInput(),
            Padding(padding: EdgeInsets.all(16)),
            _LoginButton()
          ],
        ),
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  const _UsernameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (previous, current) => previous.username != current.username,
        builder: (context, state) {
          String? errorText = "";
          if (state.username.invalid) {
            final error = state.username.error;
            if (error == UsernameValidatorError.empty) {
              errorText = 'Username is empty';
            } else if (error == UsernameValidatorError.lessThan8Char) {
              errorText = 'Username is less than 8 characters';
            }
          } else {
            errorText = null;
          }
          return TextField(
            onChanged: (username) => context
                .read<LoginBloc>()
                .add(LoginUsernameChanged(username: username)),
            decoration: InputDecoration(
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                labelText: 'Username',
                errorText: errorText),
          );
        },
      );
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (previous, current) => previous.password != current.password,
        builder: (context, state) {
          String? errorText = '';
          if (state.password.invalid) {
            final error = state.password.error;
            if (error == PasswordValidatorError.empty) {
              errorText = 'Password is empty';
            } else if (error == PasswordValidatorError.lessThan8Char) {
              errorText = 'Password is less than 8 characters';
            }
          } else {
            errorText = null;
          }
          return TextField(
            obscureText: true,
            onChanged: (password) => context
                .read<LoginBloc>()
                .add(LoginPasswordChanged(password: password)),
            decoration: InputDecoration(
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                labelText: 'Password',
                errorText: errorText),
          );
        },
      );
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) => state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all<double>(0)),
                    onPressed: () {
                      if (state.status.isValidated) {
                        context.read<LoginBloc>().add(LoginSubmitted());
                      } else {
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(const SnackBar(
                              behavior: SnackBarBehavior.floating,
                              content: Text('Invalid username or password')));
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text('Login'),
                    )),
              ),
      );
}
