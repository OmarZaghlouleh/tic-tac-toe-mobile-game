import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedBackground extends StatefulWidget {
  AnimatedBackground(this.isLandscape, {Key? key}) : super(key: key);
  bool isLandscape;

  @override
  _AnimatedBackgroundState createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(
        reverse: true,
      );

    _animation = Tween<double>(begin: 2, end: 0).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.bounceIn,
    ));

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    _animation.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return SizedBox(
      height: widget.isLandscape
          ? (MediaQuery.of(context).size.height +
                  MediaQuery.of(context).padding.top) *
              0.70
          : MediaQuery.of(context).size.height * 0.40,
      width: widget.isLandscape
          ? MediaQuery.of(context).size.width * 0.35
          : MediaQuery.of(context).size.width * 0.65,
      child: GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        children: List.generate(9, (index) {
          Random ran = Random();
          int randomint = ran.nextInt(100);
          return Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
              color: theme.scaffoldBackgroundColor.withBlue(50),
            ),
            child: RotationTransition(
              turns: _animation,
              child: ScaleTransition(
                scale: _animation,
                child: Center(
                  child: Text(
                    randomint % 2 == 0 ? 'X' : 'O',
                    style: TextStyle(
                      color: randomint % 2 == 0 ? Colors.blue : Colors.red,
                      fontSize: 15,
                      fontFamily: 'Gameplay',
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
