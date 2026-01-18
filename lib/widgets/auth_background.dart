import 'package:flutter/material.dart';
import 'auth_curve_clipper.dart';

// FIXME: the curve is not pixel perfect. improv later.
class AuthBackground extends StatelessWidget {
  final Widget child;
  final Color topColor;
  final Color bottomColor;
  final double? leftYRatio;
  final double? rightYRatio;
  final double? controlXRatio;
  final double? controlYRatio;

  const AuthBackground({
    super.key,
    required this.child,
    this.topColor = const Color(0xFFCFE3FF),
    this.bottomColor = Colors.white,
    this.leftYRatio,
    this.rightYRatio,
    this.controlXRatio,
    this.controlYRatio,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Layer 1
        Positioned.fill(
          child: Container(
            color: bottomColor,
          ),
        ),
        // Layer 2
        Positioned.fill(
          child: ClipPath(
            clipper: AuthCurveClipper(
              leftYRatio: leftYRatio ?? 0.2,
              rightYRatio: rightYRatio ?? 0.15,
              controlXRatio: controlXRatio ?? 0.8,
              controlYRatio: controlYRatio ?? 0.0,
            ),
            child: Container(
              color: topColor,
            ),
          ),
        ),
        
        // Layer 3
        Positioned.fill(
          child: child,
        ),
      ],
    );
  }
}
