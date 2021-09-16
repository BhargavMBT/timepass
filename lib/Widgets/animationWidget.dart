import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RoundTransition extends StatefulWidget {
  final Widget? widget;
  RoundTransition({this.widget});
  @override
  _RoundTransitionState createState() => _RoundTransitionState();
}

class _RoundTransitionState extends State<RoundTransition>
    with TickerProviderStateMixin {
  AnimationController? scaleController;
  Animation<double>? scaleAnimation;

  @override
  void initState() {
    super.initState();

    scaleController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addStatusListener(
            (status) {
              if (status == AnimationStatus.completed) {
                Navigator.push(
                  context,
                  AnimatingRoute(
                    route: widget.widget,
                  ),
                );
                Timer(
                  Duration(milliseconds: 300),
                  () {
                    // print('worked');
                    scaleController!.reset();
                  },
                );
              }
            },
          );

    scaleAnimation =
        Tween<double>(begin: 0.0, end: 10.0).animate(scaleController!);
  }

  @override
  void dispose() {
    scaleController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext c) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () {
            scaleController!.forward();
          },
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.amber,
              shape: BoxShape.circle,
            ),
            child: AnimatedBuilder(
              animation: scaleAnimation!,
              builder: (c, child) => Transform.scale(
                scale: scaleAnimation!.value,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.amber,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Destination extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        centerTitle: true,
        title: Text('Go Back'),
      ),
    );
  }
}

class AnimatingRoute extends PageRouteBuilder {
  final Widget? page;
  final Widget? route;

  AnimatingRoute({this.page, this.route})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page!,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: route,
          ),
        );
}

navagtionRoute(
  BuildContext context,
  Widget widget,
) {
  return Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation, anotherAnimation) {
        return widget;
      },
      transitionDuration: Duration(milliseconds: 1500),
      barrierColor: Colors.grey[600],
      transitionsBuilder: (context, animation, anotherAnimation, child) {
        animation =
            CurvedAnimation(curve: Curves.easeOutCirc, parent: animation);
        return Align(
          child: SizeTransition(
            sizeFactor: animation,
            axisAlignment: 2,
            child: child,
          ),
        );
      }));
}

List<Curve> curveList = [
  Curves.bounceIn,
  Curves.bounceInOut,
  Curves.bounceOut,
  Curves.decelerate,
  Curves.ease,
  Curves.easeIn,
  Curves.easeInBack,
  Curves.easeInCirc,
  Curves.easeInCubic,
  Curves.easeInExpo,
  Curves.easeInOut,
  Curves.easeInOutBack,
  Curves.easeInOutCirc,
  Curves.easeInOutCubic,
  Curves.easeInOutExpo,
  Curves.easeInOutQuad,
  Curves.easeInOutQuart,
  Curves.easeInOutQuint,
  Curves.easeInOutSine,
  Curves.easeInQuad,
  Curves.easeInQuart,
  Curves.easeInQuint,
  Curves.easeInSine,
  Curves.easeInToLinear,
  Curves.easeOut,
  Curves.easeOutBack,
  Curves.easeOutCubic,
  Curves.easeOutExpo,
  Curves.easeOutQuad,
  Curves.easeOutQuart,
  Curves.easeOutQuint,
  Curves.easeOutSine,
  Curves.elasticIn,
  Curves.elasticInOut,
  Curves.elasticOut,
  Curves.fastLinearToSlowEaseIn,
  Curves.fastOutSlowIn,
  Curves.linear,
  Curves.linearToEaseOut,
  Curves.slowMiddle
];
