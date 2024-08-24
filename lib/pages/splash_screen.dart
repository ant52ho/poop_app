import 'package:flutter/material.dart';
import 'package:poop_app/pages/home_page.dart';

class SplashScreen extends StatefulWidget {
  // const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    print("iniitted 2");

    _animation = Tween(
      begin: 1.0,
      end: 0.0,
    ).animate(_controller)
      ..addStatusListener(
        (status) => {
          if (status == AnimationStatus.completed)
            {
              Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        HomePage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                  )),
            }
        },
      );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("💩  Poop App",
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            )),
        SizedBox(height: 20),
        Text("Designed for Anthony and Clare")
      ],
    )));

    //     body: Center(
    //   child: Text("Hello World"),
    // ));
  }
}
