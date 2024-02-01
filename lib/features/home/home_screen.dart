import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:login_animation/features/login/login_screen.dart';

class HomeScreen extends StatefulWidget {
  static const path = "/home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Home Screen"),
            ElevatedButton(
                onPressed: () {
                  context.go(LoginScreen.path);
                },
                child: const Text("Logout"))
          ],
        ),
      ),
    );
  }
}
