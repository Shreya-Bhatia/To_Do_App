import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:to_do_app/intro_screens/intro_page_1.dart';
import 'package:to_do_app/intro_screens/intro_page_2.dart';
import 'package:to_do_app/intro_screens/intro_page_3.dart';
import 'package:to_do_app/main.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  // controller to keep track of which page we're on
  final PageController _controller = PageController();

  // to keep track of if we are on the last page or not
  bool onLastPage = false;

  // onBoarding screen only once visible
  Future _storeOnBoardInfo() async {
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // pageView
          PageView(
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            controller: _controller,
            children: const [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
            ],
          ),

          // dot indicators
          Container(
              alignment: const Alignment(0, 0.8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // skip button
                  GestureDetector(
                      onTap: () async {
                        await _storeOnBoardInfo();
                        _controller.jumpToPage(2);
                      },
                      child: Text(
                          "Skip",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink[900],
                          ),
                      ),
                  ),

                  // dot indicator
                  SmoothPageIndicator(
                      controller: _controller,
                      count: 3,
                      effect: SlideEffect(
                        activeDotColor: Colors.pink.shade900,
                        dotColor: Colors.pink.shade300,
                      ),
                  ),

                  // next button or done button
                  onLastPage
                  ?
                    GestureDetector(
                        onTap: () {
                          _storeOnBoardInfo();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) {
                                    return const MyApp();
                                  },
                              ),
                          );
                        },
                        child: Text(
                            "Done",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.pink[900],
                            ),
                        ),
                    )
                 :  GestureDetector(
                        onTap: () async {
                          await _storeOnBoardInfo();
                          _controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn
                          );
                        },
                        child: Text(
                            "Next",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.pink[900],
                            ),
                        ),
                    )
                  ,
                ],
              )
          ),
        ],
      ),
    );
  }
}