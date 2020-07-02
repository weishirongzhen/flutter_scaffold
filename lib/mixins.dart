import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scaffold/events.dart';
import 'package:flutter_scaffold/flutter_bus.dart';

mixin FlutterBusEvent<T extends StatefulWidget> on State<T> {
  StreamSubscription _subscription;

  @mustCallSuper
  @override
  void initState() {
    super.initState();
    _subscription = FlutterBus().on<Event>().listen((event) {
      if (event.body is DioErrorEvent) {
        DioErrorEvent errorEvent = event.body;
      }

      onEvent(event);
    });
  }

  void onEvent(Event event);

  @mustCallSuper
  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

mixin ConnectivityChangeMixin<T extends StatefulWidget> on State<T> {
  @mustCallSuper
  @override
  void initState() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result != ConnectivityResult.none) {
        onConnected();
      } else {
        onDisconnected();
      }
    });

    super.initState();
  }

  void onConnected();

  void onDisconnected();
}
