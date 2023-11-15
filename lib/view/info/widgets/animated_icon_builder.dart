import 'package:flutter/material.dart';

class AnimatedIconBuilder extends StatefulWidget {
  const AnimatedIconBuilder({
    super.key,
    required this.isActive,
    required this.themesMusicVideoUrl,
  });

  final bool isActive;
  final String themesMusicVideoUrl;

  @override
  State<AnimatedIconBuilder> createState() => _AnimatedIconBuilderState();
}

class _AnimatedIconBuilderState extends State<AnimatedIconBuilder>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationIconController;

  @override
  void initState() {
    super.initState();
    _animationIconController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animationIconController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationIconController,
      builder: (context, child) {
        return IconButton(
          onPressed: !widget.isActive
              ? null
              : () async {
                  if (_animationIconController.isCompleted) {
                    _animationIconController.reverse();
                  } else {
                    _animationIconController.forward();
                  }
                },
          icon: AnimatedIcon(
            icon: AnimatedIcons.play_pause,
            progress: _animationIconController,
          ),
        );
      },
    );
  }
}
