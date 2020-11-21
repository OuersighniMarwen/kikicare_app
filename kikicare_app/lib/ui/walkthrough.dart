import 'package:kikicare_app/ui/Auth/Login.dart';
import 'package:kikicare_app/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class Walkthrough extends StatefulWidget {
  @override
  _WalkthroughState createState() => _WalkthroughState();
}

class _WalkthroughState extends State<Walkthrough> {
  List pageInfos = [
    {
      "title": "Animals Management",
      "body": "You can simply manage all your pets through our app,"
          "and navigating between profiles,"
          "you can also add pictures of your animals and share it with the rest of the community.",
      "img": "assets/img/animals_foreground.png",
    },
    {
      "title": "Adoption Ads",
      "body": "For users who want to adopt a pet or even put an animal to adoption ,"
          " KIKICARE is the place for them ! "
          "a community that is full of pet lovers will make the job a lot easier.",
      "img": "assets/img/adoption_foreground.png",
    },
    {
      "title": "Healthy Animals",
      "body": "Our main purpose is to keep your pet in a healthy state,"
          "an entire set is provided through our app, from reminders,"
          "vaccinations to doctor appointments .Easy to use easy to care.",
      "img": "assets/img/healthy_foreground.png",
    },
  ];
  @override
  Widget build(BuildContext context) {
    List<PageViewModel> pages = [
      for (int i = 0; i < pageInfos.length; i++) _buildPageModel(pageInfos[i])
    ];

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        body: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [loginGradientStart, loginGradientEnd],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: IntroductionScreen(
              pages: pages,
              onDone: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return LoginPage();
                    },
                  ),
                );
              },
              onSkip: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return LoginPage();
                    },
                  ),
                );
              },
              showSkipButton: true,
              skip: Text(
                  "Skip",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.orange.shade400,
                  fontSize: 17.0,
                ), ),
              next: Text(
                "Next",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.orange.shade400,
                  fontSize: 17.0,
                ),
              ),
              done: Text(
                "Done",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.orange.shade400,
                  fontSize: 17.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildPageModel(Map item) {
    return PageViewModel(
        title: item['title'],
        body: item['body'],
        image: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Image.asset(
            item['img'],
            height: 240.0,
          ),
        ),
        decoration: PageDecoration(
            titleTextStyle: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
            bodyTextStyle: TextStyle(fontSize: 17.0),
//        dotsDecorator: DotsDecorator(
//          activeColor: Theme.of(context).accentColor,
//          activeSize: Size.fromRadius(8),
//        ),
            boxDecoration: new BoxDecoration(
              gradient: new LinearGradient(
                  colors: [loginGradientStart, loginGradientEnd],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 1.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            )));
  }
}
