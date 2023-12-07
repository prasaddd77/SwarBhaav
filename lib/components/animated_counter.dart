import "package:flutter/material.dart";

class AnimatedCounter extends StatelessWidget {
  const AnimatedCounter({
    super.key,
    required this.value,
  });

  final int value;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: IntTween(begin: 0, end: value),
      duration: const Duration(seconds: 5),
      builder: (context, value, child) => Text(
        "$value",
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: Colors.black),
      ),
    );
  }
}
