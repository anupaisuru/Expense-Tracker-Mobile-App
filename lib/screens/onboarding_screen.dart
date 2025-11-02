import 'package:expense_tracker/screens/user_data_screen.dart';
import 'package:expense_tracker/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:expense_tracker/constants/colors.dart';
import 'package:expense_tracker/data/onboarding_data.dart';
import 'package:expense_tracker/screens/onboarding/front_page.dart';
import 'package:expense_tracker/screens/onboarding/shared_onboarding_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  //page controller
  final PageController _controller = PageController();
  bool showDetatailPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                // onBoarding screens
                PageView(
                  controller: _controller,
                  onPageChanged: (index) {
                    setState(() {
                      showDetatailPage = index == 3;
                    });
                  },
                  children: [
                    FrontPage(),
                    SharedOnboardingScreen(
                      title: OnboardingData.onBoaringDataList[0].title,
                      imagePath: OnboardingData.onBoaringDataList[0].imagePath,
                      description:
                          OnboardingData.onBoaringDataList[0].description,
                    ),
                    SharedOnboardingScreen(
                      title: OnboardingData.onBoaringDataList[1].title,
                      imagePath: OnboardingData.onBoaringDataList[1].imagePath,
                      description:
                          OnboardingData.onBoaringDataList[1].description,
                    ),
                    SharedOnboardingScreen(
                      title: OnboardingData.onBoaringDataList[2].title,
                      imagePath: OnboardingData.onBoaringDataList[2].imagePath,
                      description:
                          OnboardingData.onBoaringDataList[2].description,
                    ),
                  ],
                ),
                // page dot indicator
                Container(
                  alignment: Alignment(0, 0.75),
                  child: SmoothPageIndicator(
                    controller: _controller,
                    count: 4,
                    effect: WormEffect(
                      activeDotColor: kMainColor,
                      dotColor: kLightGrey,
                    ),
                  ),
                ),

                //navigation button
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: !showDetatailPage
                        ? GestureDetector(
                            onTap: () {
                              _controller.animateToPage(
                                _controller.page!.toInt() + 1,
                                duration: Duration(milliseconds: 400),
                                curve: Curves.easeInOut,
                              );
                            },
                            child: CustomButton(
                              buttonName: showDetatailPage
                                  ? "Get Started"
                                  : "Next",
                              buttonColor: kMainColor,
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              // navigate to the user data screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UserDataScreen(),
                                ),
                              );
                            },
                            child: CustomButton(
                              buttonName: showDetatailPage
                                  ? "Get Started"
                                  : "Next",
                              buttonColor: kMainColor,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
