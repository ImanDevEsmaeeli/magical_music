import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart';

class AnimatedFavoriteIcon extends StatefulWidget {
  const AnimatedFavoriteIcon({super.key});

  @override
  State<AnimatedFavoriteIcon> createState() => _AnimatedFavoriteIconState();
}

class _AnimatedFavoriteIconState extends State<AnimatedFavoriteIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _controller, curve: Curves.elasticOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Stack(
        children: [
          const Icon(Icons.favorite_outline_rounded),
          Center(
            child: SizeTransition(
              sizeFactor: _animation,
              child: Icon(Icons.favorite_rounded),
            ),
          )
        ],
      ),
    );
  }
}
