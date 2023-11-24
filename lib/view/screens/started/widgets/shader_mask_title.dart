import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../login/widgets/shader_arrows.dart';

class ShaderMaskTitle extends StatelessWidget {
  const ShaderMaskTitle({
    super.key,
    required AnimationController controller,
  }) : _controller = controller;

  final AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: const [
              Colors.white10,
              Colors.white,
              Colors.white10,
            ],
            stops: const [0.0, 0.5, 1.0],
            transform: SliderGradientTransform(percent: _controller.value),
          ).createShader(bounds),
          child: child,
        );
      },
      child: Text(
        'FAM',
        style: GoogleFonts.kdamThmorPro(
          fontSize: 80,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
