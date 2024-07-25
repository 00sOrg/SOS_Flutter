import 'package:flutter/material.dart';
import 'package:nearhere/shared/widgets/refresh_button.dart';

class GradientContainer extends StatelessWidget {
  final Widget child;
  final bool showRefreshBtn;
  final Border? borderStyle;
  final BorderRadius? borderRadius;
  // final List<BoxShadow>? boxShadow;

  const GradientContainer({
    super.key,
    required this.child,
    this.showRefreshBtn = true,
    this.borderStyle,
    this.borderRadius,
    // this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: borderStyle,
        borderRadius: borderRadius,
        // boxShadow: boxShadow,
        color: Colors.white,
        gradient: const RadialGradient(
            colors: [
              Color(0xB35793CA), // #5793CA with 70% opacity
              Color(0xB360A8B4), // #60A8B4 with 70% opacity
              Color(0xB377DD7C), // #77DD7C with 70% opacity
              Color(0xB3FFFFFF), // #FFFFFF with 70% opacity
            ],
            stops: [
              0.0,
              0.1,
              0.5,
              1.0
            ],
            center: Alignment.center,
            radius: 0.5,
            transform: GradientScalingTransform(scaleX: 1.8, scaleY: 1)),
      ),
      child: Stack(
        children: [
          child,
          if (showRefreshBtn)
            const Positioned(
              bottom: 2,
              right: 16,
              child: RefreshButton(),
            ),
        ],
      ),
    );
  }
}

class GradientScalingTransform extends GradientTransform {
  final double scaleX;
  final double scaleY;

  const GradientScalingTransform({required this.scaleX, required this.scaleY});

  @override
  Matrix4 transform(Rect bounds, {TextDirection? textDirection}) {
    // Adjusting the transformation to keep the gradient center aligned
    return Matrix4.identity()
      ..translate(-0.5 * (scaleX - 1.0) * bounds.width)
      ..scale(scaleX, scaleY);
  }
}
