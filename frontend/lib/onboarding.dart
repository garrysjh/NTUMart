import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/pages/login_page.dart';
import 'package:frontend/main.dart';
import 'package:onboarding/onboarding.dart';

void main() {
  runApp(const OnBoardingScreen());
}

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Onboarding Screen',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFF5C795B),
          onPrimary: Color(0xFFEAEAEA),
          secondary: Color(0xFF5D7395),
          onSecondary: Color(0xFFEAEAEA),
          error: Color(0xFFF32424),
          onError: Color(0xFFF32424),
          background: Color(0xFFF9F9F9),
          onBackground: Color(0xFFFFFFFF),
          surface: Color(0xFFEAEAEA),
          onSurface: Color(0xFF5C795B),
        ),
      ),
      home: const OnBoardingScreenPage(title: 'Onboarding Screen Page'),
    );
  }
}

class OnBoardingScreenPage extends StatefulWidget {
  const OnBoardingScreenPage({super.key, required this.title});
  final String title;

  @override
  State<OnBoardingScreenPage> createState() => OnBoardingScreenPageState();
}

class OnBoardingScreenPageState extends State<OnBoardingScreenPage> {
  late Material materialButton;
  late int index;
  static const subtextStyle = TextStyle(
    color: Color(0xFF5D7395),
    letterSpacing: 0.7,
    fontSize: 20.0,
    fontWeight: FontWeight.w400,
  );
  static const maintextStyle = TextStyle(
    color: Color(0xFF5C795B),
      fontSize: 26.0,
      wordSpacing: 1,
      letterSpacing: 1.2,
      fontWeight: FontWeight.bold,
  );
  final onboardingPagesList = [
    PageModel(
      widget: DecoratedBox(
        decoration: BoxDecoration(
          color: const Color(0xFFF9F9F9),
          border: Border.all(
            width: 0.0,
            color: const Color(0xFFF9F9F9),
          ),
        ),
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 45.0,
                  vertical: 90.0,
                ),
                child: Image.asset('assets/img/lionlogo.png',),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 45.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'A MARKETPLACE APP',
                    style: maintextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 45.0, vertical: 10.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'by NTU students, \nfor NTU students',
                    style: subtextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    PageModel(
      widget: DecoratedBox(
        decoration: BoxDecoration(
          color: const Color(0xFFF9F9F9),
          border: Border.all(
            width: 0.0,
            color: const Color(0xFFF9F9F9),
          ),
        ),
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 45.0,
                  vertical: 90.0,
                ),
                child: Image.asset('assets/img/messageboardsample.png'),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 45.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'BUY, SELL, CONNECT',
                    style: maintextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 45.0, vertical: 10.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Clear out clutter & make friends with our Message Board feature',
                    style: subtextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    PageModel(
      widget: DecoratedBox(
        decoration: BoxDecoration(
          color: const Color(0xFFF9F9F9),
          border: Border.all(
            width: 0.0,
            color: const Color(0xFFF9F9F9),
          ),
        ),
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 45.0,
                  vertical: 90.0,
                ),
                child: Image.asset('assets/img/ntumart_logo.png'),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 45.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'NTUMART',
                    style: maintextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 45.0, vertical: 10.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Fuss-free, quick, & safe\nThat's us, that's NTUMart",
                    style: subtextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    materialButton = _skipButton();
    index = 0;
  }

  Material _skipButton({void Function(int)? setIndex}) {
    return Material(
      borderRadius: defaultSkipButtonBorderRadius,
      color: const Color(0xFF5D7395),
      child: InkWell(
        borderRadius: defaultSkipButtonBorderRadius,
        onTap: () {
          if (setIndex != null) {
            index = index + 1;
            setIndex(index);
          }
        },
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
          child: Text(
            'Next',
            style: TextStyle(
              color: Color(0xFFEAEAEA),
              letterSpacing: 1.0,
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Material get _signupButton {
    return Material(
      borderRadius: defaultProceedButtonBorderRadius,
      color: const Color(0xFF5D7395),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        },
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
          child: Text(
            'Get Started',
            style: TextStyle(
              color: Color(0xFFEAEAEA),
              letterSpacing: 1.0,
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Onboarding Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: Onboarding(
          pages: onboardingPagesList,
          onPageChange: (int pageIndex) {
            index = pageIndex;
          },
          startPageIndex: 0,
          footerBuilder: (context, dragDistance, pagesLength, setIndex) {
            return DecoratedBox(
              decoration: const BoxDecoration(
                color: Color(0xFFEAEAEA),
              ),
              child: Column(
                children: [
                  Container(
                    height: 150,
                    decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFEAEAEA),
                        Color(0xFFFFFFFF),
                        Color(0xFF5C795B),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [-0.05, 0.00, 0.85],
                    ),
                      border: Border(
                        bottom: BorderSide(width: 15, color: Color(0xFF5C795B),
                      ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(45.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomIndicator(
                            netDragPercent: dragDistance,
                            pagesLength: pagesLength,
                            indicator: Indicator(
                              indicatorDesign: IndicatorDesign.polygon(
                                polygonDesign: PolygonDesign(
                                  polygon: DesignType.polygon_circle,
                                ),
                              ),
                              activeIndicator: const ActiveIndicator(
                                  color: Color(0x885C795B),
                                borderWidth: 0.5,
                              ),
                            ),
                          ),
                          index == pagesLength - 1
                              ? _signupButton
                              : _skipButton(setIndex: setIndex)
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            );
          },
        ),
      ),
    );
  }

}


