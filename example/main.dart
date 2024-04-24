import 'package:flutter/material.dart';

import 'package:behavior_streamer/behavior_streamer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Behavior Streamer Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Behavior Streamer Example'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  // Use a BehaviorStreamer to track the state of the counter
  final counterState = BehaviorStreamer<int>(0);
  final String title;

  MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            StreamBuilder<int>(
              stream: counterState.stream,
              builder: (context, snapshot) {
                return Text(
                  '${snapshot.data}',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            counterState.value++, // changing the value will notify the stream
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
