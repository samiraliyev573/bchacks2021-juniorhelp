import 'package:flutter/material.dart';
import 'package:juniorhelp/screens/login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const List<Color> colorList = [
  Color(0xffFF7979),
  Color(0xff6CC9FF),
  Color(0xffFFBD59),
  Color(0xff8C52FF)
];

const List<String> imageLink = [
  "assets/onboarding1.png",
  "assets/onboarding2.png",
  "assets/onboarding3.png",
  "assets/onboarding4.png",
];

const List<String> texts = [
  "Create To-Do lists and assign tasks to your loved ones to help memory-retention and make their daily routine as easy as 1,2,3..",
  "Track your loved one's live locations and view their memory-related analytics on the go!",
  "Meet Sarah, Your loved one's personalized chatbot! Sarah will help your loved one remember those hard-to-recall details in everyday life",
  "Develop your loved one's memory retention and recollection abilities using the memory quiz feature of the app!"
];

int index = 0;

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation firstHalfAnimation;
  Animation secondHalfAnimation;
  Animation horizontalAnimation;
  bool animationHalfWay = false;
  bool isToggled = false;

  Color container1color = colorList[index];
  Color container2color = colorList[index + 1];

  void middleSwap() {
    if (isToggled) {
      setState(() {
        container1color = colorList[index + 1];
        container2color = colorList[index];
      });
    } else {
      setState(() {
        container1color = colorList[index];
        container2color = colorList[index + 1];
      });
    }
  }

  PageController pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    pageController = PageController();

    _controller =
        AnimationController(duration: Duration(milliseconds: 750), vsync: this);

    firstHalfAnimation = CurvedAnimation(
      parent: _controller,
      curve: Interval(0.000, 0.500, curve: Curves.easeInExpo),
    );

    secondHalfAnimation = CurvedAnimation(
      parent: _controller,
      curve: Interval(0.500, 1.000, curve: Curves.easeOutExpo),
    );

    horizontalAnimation = CurvedAnimation(
      parent: _controller,
      curve: Interval(0.750, 1.000, curve: Curves.easeInOutQuad),
    );

    _controller
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          middleSwap();
          _controller.reset();
        }
      })
      ..addListener(() {
        if (_controller.value > 0.5) {
          setState(() {
            animationHalfWay = true;
          });
        } else {
          setState(() {
            animationHalfWay = false;
          });
        }
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: animationHalfWay ? container2color : container1color,
      body: Stack(
        children: [
          Container(
            color: animationHalfWay ? container2color : container1color,
            width: width / 2.0 - 44,
            height: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  if (_controller.status != AnimationStatus.forward) {
                    setState(() {
                      isToggled = !isToggled;
                      index++;
                    });

                    if (index > 3) {
                      setState(() {
                        index = 0;
                      });
                    }
                    pageController.animateToPage(index,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOutQuad);
                    _controller.forward();
                  }
                },
                child: Stack(
                  children: [
                    ContainerAnimation(
                      animation: firstHalfAnimation,
                      color: container2color,
                      swap: 1.0,
                      index: index,
                      show: false,
                      tweenAnimation: Tween<double>(begin: 1.0, end: 85),
                    ),
                    ContainerAnimation(
                      animation: secondHalfAnimation,
                      color: container1color,
                      swap: -1.0,
                      index: index,
                      horizontalTween: Tween<double>(begin: 0, end: -85),
                      horizontalAnimation: horizontalAnimation,
                      show: true,
                      tweenAnimation: Tween<double>(begin: 85, end: 1.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
          IgnorePointer(
            ignoring: true,
            child: PageView.builder(
              controller: pageController,
              itemCount: 4,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                        padding:
                            EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                        child: Image.asset(imageLink[index])),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        texts[index],
                        style: TextStyle(
                          color: Color(0xffffffff),
                          fontSize: 20.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class ContainerAnimation extends AnimatedWidget {
  final Tween<double> tweenAnimation;
  final Tween<double> horizontalTween;
  final Animation<double> animation;
  final Animation<double> horizontalAnimation;
  final double swap;
  final Color color;
  final int index;
  final bool show;

  ContainerAnimation(
      {Key key,
      this.tweenAnimation,
      this.index,
      this.horizontalAnimation,
      this.horizontalTween,
      this.animation,
      this.color,
      this.show,
      this.swap})
      : assert(swap == 1 || swap == -1),
        super(key: key, listenable: animation);
  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: FractionalOffset.centerLeft,
      transform: Matrix4.identity()
        ..scale(
          tweenAnimation.evaluate(animation) * swap,
          tweenAnimation.evaluate(animation),
        ),
      child: Transform(
        transform: Matrix4.identity()
          ..translate(horizontalTween != null
              ? horizontalTween.evaluate(horizontalAnimation)
              : 0.0),
        child: Container(
          width: 85,
          height: 85,
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(
                  44 - tweenAnimation.evaluate(animation) / (44))),
          child: index != colorList.length - 1
              ? Icon(
                  (swap == 1)
                      ? Icons.keyboard_arrow_right
                      : Icons.keyboard_arrow_left,
                  color:
                      (index % 2 == 0) ? Color(0xffffffff) : Color(0xff4A64FE))
              : IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                            transitionDuration: Duration(seconds: 1),
                            transitionsBuilder:
                                (context, animation, animationTime, child) {
                              animation = CurvedAnimation(
                                  parent: animation,
                                  curve: Curves.fastLinearToSlowEaseIn);
                              return ScaleTransition(
                                child: child,
                                scale: animation,
                                alignment: Alignment.center,
                              );
                            },
                            pageBuilder: (context, animation, animationTime) {
                              return Login();
                            }));
                  },
                  icon: (swap == 1)
                      ? FaIcon(FontAwesomeIcons.fastForward)
                      : FaIcon(FontAwesomeIcons.backward),
                  iconSize: show ? 20 : 1,
                  color:
                      (index % 2 == 0) ? Color(0xffffffff) : Color(0xff4A64FE)),
        ),
      ),
    );
  }
}
