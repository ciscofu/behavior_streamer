This package is used to share state within a Dart/Flutter application. Application components interested in changes to state can listen to the stream and be notified of changes. Listeners to state will immediately receive the current state value, along with a stream of updates when the state value changes.

The purpose of this class is to provide an alternative to RxDart when the only component needed from that package is BehaviorSubject.

## Features

* State is provided via any object and can be streamed to multiple listeners
* Stream listeners will always be provided the latest value and then any new values assigned to the state
* By referencing the same BehaviorStreamer object, state can easily be shared throughout different components in the application.
* Stream notifications can be triggered programmatically, useful in cases where the object representing the state does not change, but perhaps some attribute of that object changes and listeners should be notified.
* BehaviorStreamer can be extended to add additional methods useful for custom state handling

## Getting started

Add the dependency to `pubspec.yaml`:

```dart
dependencies:
  behavior_streamer: 0.1.2
```

Add the import to any files working with `BehaviorStreamer`:

```dart
import 'package:behavior_streamer/behavior_streamer.dart';
```

Create the `BehaviorStreamer` object and work with it:

```dart
// Create a state object
var myState = BehaviorStreamer<int>(0);

// Components can subscribe to state changes via stream
var myStream = myState.stream
await for (final val in myStream) {
  print("Received new value: ${val}").;
}

// State is also available with the value attribute. Changing the value will automatically propagate the new value to any stream listeners
for (var i = 1; i <= 10; i++) {
    myState.value = i;
}

// Using the BehaviorStream in Flutter
StreamBuilder<int>(
  initialData: myState.value,
  stream: myState.stream,
  builder: (context, snapshot) {
    return Text(
      'You have pressed the button this many times: ${snapshot.data}',
    );
  },
)
```

To update listeners programmatically, in case the state object hasn't changed but listeners should refresh it anyway (such: as if some attribute of the object has changed):

`myState.notify();`

When done with the state object entirely, it can be closed to dispose of the internal StreamController and notify any listeners that the stream has completed:

`myState.close();`

## Custom State Streamer

Below a custom class is created to add a convenience method for working with the state. In this case, rather than code working with the value directly, application code can invoke the `increment()` method to update the state:

```dart
import 'package:state_streamer/state_streamer.dart';

class CounterState extends BehaviorStreamer<int> {
  CounterState() : super(0);

  void increment() {
    ++value;
  }
}
```
