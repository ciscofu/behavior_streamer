import 'dart:async';

/// Creates a [BehaviorStreamer] instance that can be used to stream values.
class BehaviorStreamer<K> {
  K _currentValue;
  final _streamController = StreamController<K>.broadcast();

  /// Creates a [BehaviorStreamer] instance with an initial value.
  ///
  /// Listeners will receive the initial (or latest) value when they start
  /// listening, along with any subsequent values.
  BehaviorStreamer(K initialValue) : _currentValue = initialValue;

  /// Returns a new [Stream] that emits the current value and any subsequent
  /// values.
  Stream<K> get stream => _subStream();

  /// Returns the latest value.
  ///
  /// If no values have been set, the initial value is returned.
  K get value => _currentValue;

  /// Updates the value and notifies all listeners.
  set value(K value) {
    _currentValue = value;
    _streamController.add(value);
  }

  /// Notifies all listeners without changing the value.
  ///
  /// This is useful when the value object reference has not changed, but
  /// listeners need to be notified of a change to the object's properties.
  void notify() {
    _streamController.add(_currentValue);
  }

  /// Closes all streams and frees up resources.
  Future<dynamic> close() {
    return _streamController.close();
  }

  /// Helper method to return a new [Stream].
  ///
  /// Each listener gets its own stream.
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
