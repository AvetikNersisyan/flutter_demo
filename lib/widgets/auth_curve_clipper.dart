import 'package:flutter/material.dart';

class AuthCurveClipper extends CustomClipper<Path> {
  final double leftYRatio;
  final double rightYRatio;
  final double controlXRatio;
  final double controlYRatio;

  AuthCurveClipper({
    this.leftYRatio = 0.35,
    this.rightYRatio = 0.48,
    this.controlXRatio = 0.7,
    this.controlYRatio = 0.30,
  });

  @override
  Path getClip(Size size) {
    final path = Path();
    
    final curveStartY = size.height * leftYRatio;
    final curveEndY = size.height * rightYRatio;
    final controlX = size.width * controlXRatio;
    final controlY = size.height * controlYRatio;

    path.moveTo(0, 0);
    
    path.lineTo(0, curveStartY);

    // TODO: maybe use another method ??. research later
    path.quadraticBezierTo(
      controlX,
      controlY,
      size.width,
      curveEndY,
    );
    
    path.lineTo(size.width, 0);
    
    path.close();
    
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
