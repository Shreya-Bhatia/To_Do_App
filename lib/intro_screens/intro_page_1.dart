import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffffbde8),//Color(0xffffade2),
      child: Container(
        padding: const EdgeInsets.only(top: 150.0),
        child: Center(
          child: Column(
            children: [
              Lottie.asset("assets/animation/todostart.json"),
              Container(
                padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                child: const Text(
                    "Manage all your to do tasks at a single place.",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'MontserratTry',
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
