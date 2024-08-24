import 'package:flutter/material.dart';
import 'package:poop_app/pages/dashboard.dart';
import 'package:poop_app/util/selection_button.dart';
import '../globals.dart' as globals;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // button push
    VoidCallback onPushed(String user) {
      return () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Dashboard(user: user)));
      };
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 80),
              child: Text(
                "Are you Anthony or Clare?",
                style: TextStyle(fontSize: 24),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40, top: 10),
                child: Column(
                  children: [
                    Flexible(
                      flex: 2,
                      child: SelectionButton(
                          text: "Anthony",
                          subtext: "wooohooo",
                          onTap: onPushed("anthony"),
                          color: const Color.fromARGB(215, 33, 177, 243)),
                    ),
                    Flexible(
                      flex: 2,
                      child: SelectionButton(
                          text: "Clare",
                          subtext: "Number 1 booboo",
                          onTap: onPushed("clare"),
                          color: const Color.fromARGB(255, 229, 82, 131)),
                    ),
                    Flexible(
                      flex: 1,
                      child: SelectionButton(
                          text: "Nimbus",
                          subtext: "meow",
                          onTap: onPushed("Nimbus"),
                          color: Color.fromARGB(255, 150, 141, 144)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
