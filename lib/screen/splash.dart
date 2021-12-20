import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  static Route route() => MaterialPageRoute(
        builder: (_) => const Splash(),
      );

  @override
  Widget build(BuildContext context) => const Scaffold(
        body: Center(
          child: FlutterLogo(size: 100),
        ),
      );
}
