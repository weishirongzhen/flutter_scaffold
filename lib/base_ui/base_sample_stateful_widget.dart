import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_scaffold/flutter_bus.dart';
import 'package:flutter_scaffold/mixins.dart';

abstract class BaseSampleStatefulWidget extends StatefulWidget {
  @override
  BaseSampleStatefulWidgetState createState();
}

abstract class BaseSampleStatefulWidgetState<T extends StatefulWidget> extends State<T> with FlutterBusEvent, AutomaticKeepAliveClientMixin, WidgetsBindingObserver {
  Widget buildUI(BuildContext context);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: buildUI(context),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onEvent(Event event) {}

  @override
  void initState() {
    super.initState();
  }

  @override
  bool get wantKeepAlive => false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      SystemChrome.setEnabledSystemUIOverlays([]);
    }
  }
}
