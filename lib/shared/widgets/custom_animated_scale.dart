import 'package:flutter/material.dart';

class CustomAnimatedScaleDown extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  final double? scaleValue;
  final int? duration;

  const CustomAnimatedScaleDown({
    required this.child,
    required this.onTap,
    this.scaleValue,
    this.duration,
    super.key,
  });

  @override
  State<CustomAnimatedScaleDown> createState() =>
      _CustomAnimatedScaleDownState();
}

class _CustomAnimatedScaleDownState extends State<CustomAnimatedScaleDown> {
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isTapped = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isTapped = false;
        });
        widget.onTap();
      },
      onTapCancel: () {
        setState(() {
          _isTapped = false;
        });
      },
      child: AnimatedScale(
        scale: _isTapped ? widget.scaleValue ?? 0.97 : 1.0,
        duration: Duration(milliseconds: widget.duration ?? 150),
        curve: Curves.easeInOut,
        child: widget.child,
      ),
    );
  }
}

class CustomAnimatedScaleUp extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  final double? scaleValue;
  final int? duration;

  const CustomAnimatedScaleUp({
    required this.child,
    required this.onTap,
    this.scaleValue = 1.2,
    this.duration = 100,
    super.key,
  });

  @override
  State<CustomAnimatedScaleUp> createState() => _CustomAnimatedScaleUpState();
}

class _CustomAnimatedScaleUpState extends State<CustomAnimatedScaleUp> {
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isTapped = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isTapped = false;
        });
        widget.onTap();
      },
      onTapCancel: () {
        setState(() {
          _isTapped = false;
        });
      },
      child: AnimatedScale(
        scale: _isTapped ? widget.scaleValue! : 1.0,
        duration: Duration(milliseconds: widget.duration!),
        curve: Curves.easeInOut,
        child: widget.child,
      ),
    );
  }
}
