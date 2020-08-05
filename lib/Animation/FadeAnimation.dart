/// ------------------------------------------------------------------------
/// FadeAnimation.dart
/// ------------------------------------------------------------------------
/// Description: Class that performs animation when widgets need it.
/// Author(s): Sharan
/// Date Approved: 15/06/2020
/// Date Created: 12/06/2020
/// Approved By: Ravish
/// Reviewed By: Kaish
/// ------------------------------------------------------------------------
/// File(s) Accessed: null
/// File(s) Modified: null
/// ------------------------------------------------------------------------
/// Input(s): delay, child
/// Output(s):
/// ------------------------------------------------------------------------
/// Error-Handling(s): Uses dart animation packages, so minimal testing is required.
/// ------------------------------------------------------------------------
/// Modification(s): None
/// ------------------------------------------------------------------------
/// Fault(s): None
/// ------------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  FadeAnimation(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("opacity")
          .add(Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0)),
      Track("translateY").add(
          Duration(milliseconds: 500), Tween(begin: -30.0, end: 0.0),
          curve: Curves.easeOut)
    ]);

    return ControlledAnimation(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context, child, animation) => Opacity(
        opacity: animation["opacity"],
        child: Transform.translate(
            offset: Offset(0, animation["translateY"]), child: child),
      ),
    );
  }
}