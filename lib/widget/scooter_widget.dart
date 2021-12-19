import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'dart:ui' as ui;

class ScooterWidget extends StatefulWidget {
  const ScooterWidget({Key? key}) : super(key: key);

  @override
  _ScooterWidgetState createState() => _ScooterWidgetState();
}

class _ScooterWidgetState extends State<ScooterWidget>
    with TickerProviderStateMixin {
  AnimationController? _slideInAnimationController;
  Animation<double>? _slideInAnimation;

  Offset _scooterOffset = const Offset(0, 0);
  Offset _centerTextOffset = const Offset(0, 0);
  double _bottomTextPosY = 120;

  @override
  void initState() {
    _slideInAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200))
      ..addListener(() {
        setState(() {
          //내용+
          _scooterOffset = Offset(-1 + _slideInAnimation!.value, 0);
          _centerTextOffset = Offset(1 - _slideInAnimation!.value, 0);
          _bottomTextPosY = 70 + (50 * _slideInAnimation!.value);
        });
      })
      ..forward();
    _slideInAnimation = CurvedAnimation(
        parent: _slideInAnimationController!, curve: Curves.ease);
    super.initState();
  }

  @override
  void dispose() {
    _slideInAnimationController!.dispose();
    super.dispose();
  }

  Widget _buildCenterText() {
    return FractionalTranslation(
      translation: _centerTextOffset,
      child: Center(
        child: GradientText(
          'GO',
          colors: <Color>[Colors.blueAccent, Colors.lightBlueAccent],
          gradientDirection: GradientDirection.ttb,
          style: TextStyle(fontSize: 200),
        ),
      ),
    );
  }

  Widget _buildScooterIag(double height) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: height * .26,
      child: FractionalTranslation(
        translation: _scooterOffset,
        child: Image.asset(
          'assets/images/scooter.png',
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }

  Widget _buildBottomText() {
    return Positioned(
      bottom: _bottomTextPosY,
      child: Text(
        'GoGoro',
        style: TextStyle(
          color: Colors.grey,
          fontSize: 60,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Stack(
      alignment: Alignment.center,
      children: [
        _buildCenterText(),
        _buildScooterIag(height),
        _buildBottomText(),
      ],
    );
  }
}
