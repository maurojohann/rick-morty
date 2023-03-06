import 'package:flutter/material.dart';

import 'package:pagination_challenge/shared/routes/route_generator.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      initialRoute: RouteNames.HOME,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
