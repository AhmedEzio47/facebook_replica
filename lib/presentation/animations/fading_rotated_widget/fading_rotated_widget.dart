import 'package:flutter/material.dart';

class FadingRotatedWidget extends StatefulWidget {
  final Widget child;

  const FadingRotatedWidget({Key? key, required this.child}) : super(key: key);
  @override
  _FadingRotatedWidgetState createState() => _FadingRotatedWidgetState();
}

class _FadingRotatedWidgetState extends State<FadingRotatedWidget>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
    _rotationAnimation =
        Tween(begin: 0.0, end: 2.0).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    _animationController.forward();
    return RotationTransition(
      turns: _rotationAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
