import 'package:behavior_streamer/behavior_streamer.dart';
import 'package:test/test.dart';

void main() {
  group('BehaviorStreamer', () {
    test('should create and close an instance correctly', () {
      var state = BehaviorStreamer<int>(0);
      expect(state, isNotNull);
      Stream<int> stream = state.stream;
      state.close();
      expectLater(stream, emitsDone);
    });

    test('should get and set value correctly', () {
      var state = BehaviorStreamer<int>(0);
      expect(state.value, equals(0));
      state.value = 1;
      expect(state.value, equals(1));
      state.close();
    });

    test('should only respond with latest value', () async {
      var state = BehaviorStreamer<int>(0);
      state.value = 1;
      state.value = 2;
      state.value = 3;
      await expectLater(state.stream, emits(3));
      state.close();
    });

    test('should respond with values when they change', () async {
      var state = BehaviorStreamer<int>(0);
      await expectLater(state.stream, emits(0));
      state.value = 1;
      await expectLater(state.stream, emits(1));
      state.close();
    });

    test('should respond with same value on notify', () async {
      var state = BehaviorStreamer<int>(10);
      await expectLater(state.stream, emits(10));
      state.notify();
      await expectLater(state.stream, emits(10));
      state.close();
    });
  });
}
