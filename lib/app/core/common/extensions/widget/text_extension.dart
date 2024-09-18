import 'package:flutter/material.dart';

extension Gradient on Text {
  Widget gradient(LinearGradient gradient) {
    return GradientText(this, gradient: gradient);
  }
}

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    super.key,
    required this.gradient,
  });

  final Text text;
  final LinearGradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: text,
    );
  }
}
