import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:login_animation/features/home/home_screen.dart';
import 'package:login_animation/features/shared/text_field.dart';
import 'package:rive/rive.dart';

class LoginScreen extends StatefulWidget {
  static const path = "/login";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  var animationLink = 'assets/login.riv';
  SMITrigger? failTrigger, successTrigger;
  SMIBool? isHandsUp, isChecking;
  SMINumber? lookNum;
  StateMachineController? stateMachineController;
  Artboard? artboard;

  @override
  void initState() {
    rootBundle.load(animationLink).then((value) {
      final file = RiveFile.import(value);
      final art = file.mainArtboard;
      stateMachineController =
          StateMachineController.fromArtboard(art, "State Machine 1");

      if (stateMachineController != null) {
        art.addController(stateMachineController!);

        for (var element in stateMachineController!.inputs) {
          if (element.name == "Check") {
            isChecking = element as SMIBool;
          } else if (element.name == "hands_up") {
            isHandsUp = element as SMIBool;
          } else if (element.name == "success") {
            successTrigger = element as SMITrigger;
          } else if (element.name == "fail") {
            failTrigger = element as SMITrigger;
          } else if (element.name == "Look") {
            lookNum = element as SMINumber;
          }
        }
      }
      setState(() => artboard = art);
    });
    super.initState();
  }

  void lookAround() {
    isChecking?.change(true);
    isHandsUp?.change(false);
    lookNum?.change(0);
  }

  void moveEyes(value) {
    lookNum?.change(value.length.toDouble() * 2.5);
  }

  void handsUpOnEyes() {
    isHandsUp?.change(true);
    isChecking?.change(false);
  }

  void idle() {
    isChecking?.change(false);
    isHandsUp?.change(false);
  }

  void loginClick() {
    isChecking?.change(false);
    isHandsUp?.change(false);
    //add your login logic here
    if (_emailController.text == "email" &&
        _passwordController.text == "pass") {
      successTrigger?.fire();
      setState(() {
        //change your home screen path here
        Future.delayed(const Duration(seconds: 1)).then((value) {
          context.go(HomeScreen.path);
        });
      });
    } else {
      failTrigger?.fire();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //artboard
              if (artboard != null)
                Container(
                  decoration: const BoxDecoration(color: Colors.black),
                  width: 500,
                  height: 410,
                  child: Rive(artboard: artboard!),
                ),

              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3), // Shadow color
                      spreadRadius: 5, // Spread radius
                      blurRadius: 7, // Blur radius
                      offset: const Offset(5, 5), // Offset
                    ),
                  ],
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(2),
                  border: Border.all(color: Colors.black12),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: AppTextField(
                        onOutSideTap: idle,
                        labelText: "Email",
                        controller: _emailController,
                        onTap: () {
                          lookAround();
                        },
                        onChanged: (String value) {
                          moveEyes(value);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: AppTextField(
                        onOutSideTap: idle,
                        labelText: "Password",
                        controller: _passwordController,
                        isSafeText: true,
                        onTap: () {
                          handsUpOnEyes();
                        },
                        onChanged: (String value) {
                          moveEyes(value);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                              shadowColor: Colors.grey,
                              elevation: 3,
                              fixedSize: const Size(300, 30),
                              backgroundColor: Colors.black87,
                              foregroundColor: Colors.black)
                          .merge(ButtonStyle(
                              elevation:
                                  MaterialStateProperty.resolveWith<double>(
                        (Set<MaterialState> states) => 0,
                      ))),
                      onPressed: () => {
                        loginClick(),
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    MaterialButton(
                      onPressed: () {},
                      child: const Text(
                        'Not having account? Sign up!',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
