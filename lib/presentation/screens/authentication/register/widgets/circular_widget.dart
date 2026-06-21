import '../../../../../index/index_main.dart';

class CircularRotation extends StatefulWidget {
  @override
  _CircularRotationState createState() => _CircularRotationState();
}

class _CircularRotationState extends State<CircularRotation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // Create an AnimationController
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 3,
      ), // Duration for the rotation (2 seconds)
    );

    // Set up the rotation animation
    _controller.repeat(); // Circular rotation, repeat the animation

    // Start the animation
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
      child: Center(
        child: Svgicon(
          icon: IconsConstants.loadericon,
          color: AppColors.primary,
          height: 80,
          width: 80,
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose the controller when the widget is disposed
    _controller.dispose();
    super.dispose();
  }
}
