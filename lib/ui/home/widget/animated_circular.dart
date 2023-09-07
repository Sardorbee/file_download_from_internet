
import 'package:flutter/material.dart';

class AnimatedRotationContainer extends StatefulWidget {
  var state;
  AnimatedRotationContainer({required this.state});
  @override
  _AnimatedRotationContainerState createState() =>
      _AnimatedRotationContainerState();
}

class _AnimatedRotationContainerState extends State<AnimatedRotationContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Adjust the duration as needed
    )..repeat(); // This makes the animation loop
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: CircularProgressIndicator(
        color: Colors.white,
        semanticsValue: "${widget.state.progress * 100} %",
        value: widget.state.progress,
        semanticsLabel: "${widget.state.progress * 100} %",
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
