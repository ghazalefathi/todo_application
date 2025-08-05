import 'package:flutter/material.dart';

class FadeAnimateWidget extends StatefulWidget {
  const FadeAnimateWidget({this.duration, required this.child, super.key});
  final int? duration;
  final Widget child;

  @override
  State<FadeAnimateWidget> createState() => _FadeAnimateWidgetState();
}

class _FadeAnimateWidgetState extends State<FadeAnimateWidget> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _movingAnimation;
  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 100 * (widget.duration ?? 1)),
        reverseDuration: Duration.zero);
    _movingAnimation = Tween<double>(begin: 0, end: 1).animate(_animationController);
    if (mounted) {
      _animationController.forward();
    }
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) => Transform.translate(
            offset: Offset(0, _movingAnimation.value),
            child: Opacity(opacity: _animationController.value, child: widget.child)));
  }
}
