import 'package:flutter/material.dart';
import 'socket_service.dart';
import 'package:provider/provider.dart';

class SelectionButton extends StatelessWidget {
  // const SelectionButton({super.key});

  final String text;
  final String subtext;
  final Color color;
  final VoidCallback onTap;

  SelectionButton({
    super.key,
    required this.text,
    required this.subtext,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      // padding: const EdgeInsets.only(left: 0, right: 0, top: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          // height: 200,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: color,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 32)),
              Text(subtext, style: TextStyle(color: Colors.white))
            ],
          ),
        ),
      ),
    );
  }
}
