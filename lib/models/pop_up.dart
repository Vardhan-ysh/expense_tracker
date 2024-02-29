import 'package:flutter/material.dart';

class PopUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PopUpState();
}

class PopUpState extends State<PopUp> with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? opacityAnimation;
  Tween<double> opacityTween = Tween<double>(begin: 0.0, end: 1.0);
  Tween<double> marginTopTween = Tween<double>(begin: 300, end: 280);
  Animation<double>? marginTopAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    marginTopAnimation = marginTopTween.animate(controller!)
      ..addListener(() {
        setState(() {});
      });
    controller?.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: opacityTween.animate(controller!),
      child: Material(
        color: Colors.transparent,
        child: Container(
          margin: EdgeInsets.only(
            top: marginTopAnimation!.value,
            left: 20.0,
            right: 20.0,
          ),
          color: Colors.red,
          child: const Text("Container"),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
