import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:winkl/screens/startup/Start.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();


    void _onIntroEnd(context) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> StartupScreen()));
    }

    Widget _buildImage(String assetName) {
      return Align(
        child: Image.asset('images/$assetName.jpeg', width: 350.0),
        alignment: Alignment.bottomCenter,
      );
    }

    @override
    Widget build(BuildContext context) {
      ScreenUtil.init(context, width: 390, height: 812, allowFontScaling: true);
      const bodyStyle = TextStyle(fontSize: 19.0);
      const pageDecoration = const PageDecoration(
        titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
        bodyTextStyle: bodyStyle,
        descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
        pageColor: Colors.white,
        imagePadding: EdgeInsets.zero,
      );

      return IntroductionScreen(
        key: introKey,
        pages: [
          PageViewModel(
            title: "Become Vendor On Winkl",
            body:
            "Some Description Text.",
            image: _buildImage('img1'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Receive Orders from Customers ",
            body:
            "Some Description Text",
            image: _buildImage('img2'),
            decoration: pageDecoration,
          ),
        ],
        onDone: () => _onIntroEnd(context),
        //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
        showSkipButton: true,
        skipFlex: 0,
        nextFlex: 0,
        skip: const Text('Skip'),
        next:  Icon(Icons.arrow_forward_ios),
        done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
        dotsDecorator: const DotsDecorator(
          size: Size(10.0, 10.0),
          color: Color(0xFFBDBDBD),
          activeSize: Size(22.0, 10.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
      );
    }
  }



