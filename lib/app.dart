import 'package:flutter/material.dart';

import 'router/router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      themeMode: ThemeMode.light,
      routerConfig: routerConfig,
      debugShowCheckedModeBanner: false,
    );
  }
}
