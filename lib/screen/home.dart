import 'package:flutter/material.dart';
import 'package:flutter_bloc_authentication/bloc/bloc.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  static Route route() => MaterialPageRoute(
        builder: (_) => const Home(),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.menu),
          title: const Text('Home'),
          centerTitle: true,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {
                  context
                      .read<AuthenticationBloc>()
                      .add(AuthenticationLogoutRequested());
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Builder(
                builder: (context) {
                  final userId = context
                      .select((AuthenticationBloc bloc) => bloc.state.user.id);
                  return Text('User id: $userId');
                },
              )
            ],
          ),
        ),
      );
}
