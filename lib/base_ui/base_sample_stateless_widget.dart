import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


abstract class BaseSampleStatelessWidget extends StatelessWidget with WidgetsBindingObserver {
  Widget buildUI(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: buildUI(context),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      SystemChrome.setEnabledSystemUIOverlays([]);
    }
  }
}
