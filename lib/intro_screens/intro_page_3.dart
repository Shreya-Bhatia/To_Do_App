import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffffbde8),
      child: Container(
        padding: const EdgeInsets.only(top: 150.0),
        child: Center(
          child: Column(
            children: [
              Lottie.asset("assets/animation/deleteanim.json"),
              Container(
                padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                child: const Text(
                  "Delete your completed tasks.",
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