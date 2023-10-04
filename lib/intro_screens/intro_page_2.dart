import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink[50],
      child: Container(
        padding: const EdgeInsets.only(top: 250.0),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                  width: 250,
                  height: 250,
                  child: Lottie.asset("assets/animation/add.json")
              ),
              Container(
                padding: const EdgeInsets.only(left: 50.0, right: 50.0,top: 50.0),
                child: const Text(
                  "Add new tasks daily.",
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