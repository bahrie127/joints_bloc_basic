import 'dart:async';

abstract class CounterEvent {}

class IncrementEvent extends CounterEvent {}

class DecrementEvent extends CounterEvent {}

class CounterBloc {
  int _value = 0;

  CounterBloc() {
    eventStream.listen(mappingEventToState);
  }

  void dispose() {
    eventController.close();
    stateController.close();
  }

  final StreamController<CounterEvent> eventController =
      StreamController<CounterEvent>();
  final StreamController<int> stateController = StreamController<int>();

  StreamSink<CounterEvent> get eventSink => eventController.sink;
  Stream<CounterEvent> get eventStream => eventController.stream;

  StreamSink<int> get stateSink => stateController.sink;
  Stream<int> get stateStream => stateController.stream;

  void mappingEventToState(CounterEvent event) {
    if (event is IncrementEvent) {
      _value = _value + 1;
    } else {
      _value = _value - 1;
    }

    stateSink.add(_value);
  }
}
