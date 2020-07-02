import 'package:event_bus/event_bus.dart';
import 'package:rxdart/rxdart.dart';

class FlutterBus {
  factory FlutterBus() => _getInstance();
  static FlutterBus _instance;
  static EventBus _eventBus;

  FlutterBus._() {
    _eventBus = EventBus.customController(PublishSubject());
  }

  static FlutterBus _getInstance() {
    _instance ??= FlutterBus._();
    return _instance;
  }

  void postEvent(dynamic event) {
    _eventBus.fire(Event(event));
  }

  void destroy() {
    _eventBus.destroy();
  }

  Stream<T> on<T>() {
    return _eventBus.on<T>();
  }
}

class Event<T> {
  T body;

  Event(this.body);
}
