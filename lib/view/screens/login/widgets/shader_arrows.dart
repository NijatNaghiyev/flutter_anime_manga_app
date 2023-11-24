import 'package:flutter/material.dart';

class ShaderArrows extends StatefulWidget {
  const ShaderArrows({
    super.key,
  });

  @override
  State<ShaderArrows> createState() => _ShaderArrowsState();
}

class _ShaderArrowsState extends State<ShaderArrows>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController.unbounded(
      vsync: this,
    )..repeat(
        min: -1,
        max: 1,
        period: const Duration(seconds: 2),
      );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
            transform: SliderGradientTransform(percent: _controller.value),
          ).createShader(bounds),
          child: child,
        );
      },
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          Navigator.pop(context);
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.arrow_forward_ios_outlined, color: Colors.white),
            Icon(Icons.arrow_forward_ios_outlined, color: Colors.white),
            Icon(Icons.arrow_forward_ios_outlined, color: Colors.white),
            Icon(Icons.arrow_forward_ios_outlined, color: Colors.white),
            Icon(Icons.arrow_forward_ios_outlined, color: Colors.white),
            Icon(Icons.arrow_forward_ios_outlined, color: Colors.white),
            Icon(Icons.arrow_forward_ios_outlined, color: Colors.white),
            Icon(Icons.arrow_forward_ios_outlined, color: Colors.white),
            Icon(Icons.arrow_forward_ios_outlined, color: Colors.white),
          ],
        ),
      ),
    );
  }
}

class SliderGradientTransform extends GradientTransform {
  final double percent;

  const SliderGradientTransform({required this.percent});

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * percent, 0, 0);
  }
}
