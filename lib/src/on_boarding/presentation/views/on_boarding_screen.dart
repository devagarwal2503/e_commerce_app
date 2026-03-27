import 'package:e_commerce_app/core/extensions/context_extension.dart';
import 'package:e_commerce_app/core/resources/colors.dart';
import 'package:e_commerce_app/core/resources/media_resources.dart';
import 'package:e_commerce_app/src/on_boarding/domain/entities/page_content.dart';
import 'package:e_commerce_app/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:e_commerce_app/src/on_boarding/presentation/widgets/on_boarding_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  static const routeName = '/on-boarding';

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final pageController = PageController();

  int _currentPageIndex = 0;
  @override
  void initState() {
    super.initState();

    context.read<OnBoardingCubit>().checkIfUserIsFirstTimer();

    pageController.addListener(() {
      setState(() {
        _currentPageIndex = pageController.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<OnBoardingCubit, OnBoardingState>(
        listener: (context, state) {
          if (state is OnBoardingStatus) {
            if (state.isFirstTimer) {
            } else {
              Navigator.pushReplacementNamed(context, '/sign-in');
            }
          } else if (state is UserCached) {
            Navigator.pushReplacementNamed(context, '/sign-in');
          }
        },
        builder: (context, state) {
          return Container(
            color: CustomColors.primaryColorLite,
            child: SafeArea(
              child: Container(
                width: context.width,
                constraints: BoxConstraints.expand(),
                color: CustomColors.primaryColorLite,
                child: Stack(
                  children: [
                    PageView(
                      controller: pageController,
                      children: [
                        OnBoardingBody(
                          pageContent: PageContent(
                            image: MediaResources.onBoardingOne,
                            title: context.localText.chooseProductsText,
                            description:
                                context.localText.chooseProductsDescText,
                          ),
                        ),
                        OnBoardingBody(
                          pageContent: PageContent(
                            image: MediaResources.onBoardingTwo,
                            title: context.localText.makePaymentText,
                            description: context.localText.makePaymentDescText,
                          ),
                        ),
                        OnBoardingBody(
                          pageContent: PageContent(
                            image: MediaResources.onBoardingThree,
                            title: context.localText.getYourOrderText,
                            description: context.localText.getYourOrderDescText,
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment(0, 0.93),
                      child: SmoothPageIndicator(
                        controller: pageController,
                        count: 3,
                        onDotClicked: (index) {
                          pageController.animateToPage(
                            index,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        },
                        effect: WormEffect(
                          dotHeight: 10,
                          dotWidth: 10,
                          activeDotColor: Colors.black,
                          spacing: 20,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Align(
                        alignment: Alignment(0, 0.95),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: _currentPageIndex == 0
                                  ? null
                                  : () {
                                      pageController.animateToPage(
                                        _currentPageIndex - 1,
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.easeInOut,
                                      );
                                    },
                              child: Text(
                                _currentPageIndex == 0
                                    ? ""
                                    : context.localText.previousText,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),

                            InkWell(
                              onTap: _currentPageIndex == 2
                                  ? () {
                                      context
                                          .read<OnBoardingCubit>()
                                          .cacheFirstTimer();
                                    }
                                  : () {
                                      pageController.animateToPage(
                                        _currentPageIndex + 1,
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.easeInOut,
                                      );
                                    },
                              child: Text(
                                _currentPageIndex == 2
                                    ? context.localText.getStartedText
                                    : context.localText.nextText,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: CustomColors.primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(20).copyWith(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text.rich(
                            TextSpan(
                              text: "${_currentPageIndex + 1}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                              children: [
                                TextSpan(
                                  text: "/3",
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: _currentPageIndex == 2
                                ? null
                                : () {
                                    context
                                        .read<OnBoardingCubit>()
                                        .cacheFirstTimer();
                                  },
                            child: Text(
                              _currentPageIndex == 2
                                  ? ""
                                  : context.localText.skipText,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
