import 'dart:async';

class BehaviorStreamer<K> {
  K _currentValue;
  final _streamController = StreamController<K>.broadcast();

  BehaviorStreamer(K initialValue) : _currentValue = initialValue;

  Stream<K> get stream => _subStream();

  K get value => _currentValue;
  set value(K value) {
    _currentValue = value;
    _streamController.add(value);
  }

  void notify() {
    _streamController.add(_currentValue);
  }

  Future<dynamic> close() {
    return _streamController.close();
  }

  Stream<K> _subStream() async* {
    var subStream = _streamController.stream;
    if (!_streamController.isClosed) {
      yield _currentValue;
    }
    await for (var value in subStream) {
      yield value;
    }
  }
}
