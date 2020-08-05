/// ------------------------------------------------------------------------
/// Loading.dart
/// ------------------------------------------------------------------------
/// Description: Loading Screen. Used whenever loading is needed.
/// Author(s): Sharan
/// Date Approved: 02/06/2020
/// Date Created: 02/06/2020
/// Approved By: Kaish
/// Reviewed By: Kaish
/// ------------------------------------------------------------------------
/// File(s) Accessed: null
/// File(s) Modified: null
/// ------------------------------------------------------------------------
/// Input(s):
/// Output(s):
/// ------------------------------------------------------------------------
/// Error-Handling(s): Basic class, no need of any error handling.
/// ------------------------------------------------------------------------
/// Modification(s): None
/// ------------------------------------------------------------------------
/// Fault(s): None
/// ------------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurpleAccent[700],
      child: Center(
        child: SpinKitChasingDots(
          color: Colors.purple[50],
          size: 50.0,
        )
      ),
    );
  }
}
